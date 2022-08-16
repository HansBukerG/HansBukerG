
import java.util.ArrayList;
import java.util.TimerTask;
import java.util.PriorityQueue;
import java.util.Queue;

public class BusquedaAnchuraMultiObjetivoInformada extends TimerTask implements Constantes{
    
    public Mapa mapa;
    public Cartero cartero1;
    public PriorityQueue<Estado> colaEstados;
    public ArrayList<Estado> historial;
    public ArrayList<Character> pasos;
    //para tener un busqueda anchura multiobjetivo
    public ArrayList<Estado> destinos;
    public int index_pasos;
    public Estado inicial;
    public Estado objetivo;
    public Estado temp;
    public boolean exito;
    public boolean parar;
    
    public BusquedaAnchuraMultiObjetivoInformada(Mapa mapa,Cartero cartero) {
        
        this.mapa=mapa;
        this.cartero1=cartero;
        colaEstados=new PriorityQueue<>();
        historial=new ArrayList<>();
        pasos=new ArrayList<>();
        destinos=new ArrayList<>();
        
        index_pasos=0;
        exito=false;
        parar=false;
    }
    
    public boolean buscar(Estado inicial,Estado objetivo) {
        
        /*inicial.prioridad=distancia(
                                        inicial.x,
                                        inicial.y,
                                        laberinto.lienzoPadre.adversario.adversario.x,
                                        laberinto.lienzoPadre.adversario.adversario.y
        );*/
        
        System.out.println("Estado inicial"+inicial.toString()+"Prioridad= "+inicial.prioridad);
        System.out.println("Estado objetivo"+objetivo.toString()+"Prioridad= "+objetivo.prioridad);
        
        index_pasos=0;
        
        colaEstados.add(inicial);
        historial.add(inicial);
        
        this.objetivo=objetivo;
        exito=false;
        
        if ( inicial.equals(objetivo)) exito=true;
        
        while ( !colaEstados.isEmpty() && !exito ){
            
            temp=colaEstados.poll();
            //System.out.println(temp.toString());
            //colaEstados.remove(0);
            moverArriba(temp);
            moverAbajo(temp);
            moverIzquierda(temp);
            moverDerecha(temp);
        }
        
        if ( exito ) {
            System.out.println("Ruta calculada");
            this.calcularRuta();
            return true;
        }
        else {
            System.out.println("La ruta no pudo calcularse");
            
            return false;
        }
        
    }
    
    private void moverArriba(Estado e) {  
        if ( e.y > 0 ) {
            if ( cartero1.nohayPared(e.x, e.y-1)) { 
                 Estado arriba=new Estado(e.x,e.y-1,'U',e);
                 arriba.prioridad = (int) (mapa.celdas[arriba.x][arriba.y].prioridad+distancia(arriba,objetivo));
                 
                 if ( !historial.contains(arriba)) {
                    colaEstados.add(arriba);
                    historial.add(arriba);
                    if ( arriba.equals(objetivo)) {
                        objetivo=arriba;
                        exito=true;
                    }
                    
                 }
            }     
        }
    }
    
    private void moverAbajo(Estado e) {
       
        if ( e.y+1< alturaMundoVirtual ) { 
            if ( cartero1.nohayPared(e.x, e.y+1) ) {
                 Estado abajo=new Estado(e.x,e.y+1,'D',e);   
                 abajo.prioridad = (int) (mapa.celdas[abajo.x][abajo.y].prioridad+distancia(abajo,objetivo));
                 if ( !historial.contains(abajo)) {
                    colaEstados.add(abajo);
                    historial.add(abajo);
                    //laberinto.celdas[e.x][e.y+1].tipo='A';
                    if ( abajo.equals(objetivo)) {
                        //laberinto.celdas[e.x][e.y+1].tipo='P';
                        objetivo=abajo;
                        exito=true;
                    }
                 }   
            }     
        }
    }    
    
    private void moverIzquierda(Estado e) {
        if ( e.x > 0 ) {
            if ( cartero1.nohayPared(e.x-1, e.y) ) {
                Estado izquierda=new Estado(e.x-1,e.y,'L',e);
                izquierda.prioridad = (int) (mapa.celdas[izquierda.x][izquierda.y].prioridad+distancia(izquierda,objetivo));

                if ( !historial.contains(izquierda)) {
                    
                   colaEstados.add(izquierda);
                   historial.add(izquierda);
                   
                   if ( izquierda.equals(objetivo)) {
                       
                       objetivo=izquierda;
                       exito=true;
                   }
                }   
            }    
        }
    }    
    
    private void moverDerecha(Estado e) {
        
        if ( e.x < anchuraMundoVirtual-1 ) {
            if ( cartero1.nohayPared(e.x+1, e.y) ) {
                Estado derecha=new Estado(e.x+1,e.y,'R',e); 
                derecha.prioridad = (int) (mapa.celdas[derecha.x][derecha.y].prioridad+distancia(derecha,objetivo));
                if ( !historial.contains(derecha)){
                 colaEstados.add(derecha);
                 historial.add(derecha);
                 
                 if ( derecha.equals(objetivo)) {
                     objetivo=derecha;
                     exito=true;
                 }
               }  
            }     
        }
    }    
    
    public void calcularRuta() {
        Estado predecesor=objetivo;
        do{
            pasos.add(0,predecesor.oper);
            predecesor=predecesor.predecesor;
        }while ( predecesor != null);
        index_pasos=pasos.size()-1;
        
    }
    
    //distancia adversario
    public double distancia(Estado primero, Estado segundo) {
        double valor;
        double parte1=Math.pow(Math.abs(primero.x-segundo.x),2);
        double parte2=Math.pow(Math.abs(primero.y-segundo.y),2);
        parte1+=parte2;
        valor=Math.sqrt(parte1);
        return valor;
    }
    
    @Override
    public void run() {
        if(mapa.lienzoPadre.cantidadDeCartas>0)
        {
            if(destinos.size()!=0)
            {
                colaEstados.clear();
                historial.clear();
                pasos.clear();
                Estado subinicial,subobjetivo;
                boolean resultado;
                subinicial=new Estado(  cartero1.cartero.x,
                                                cartero1.cartero.y,'N',null);
                subobjetivo=destinos.get(0);
                subinicial.prioridad= (int) (mapa.celdas[cartero1.cartero.x][cartero1.cartero.y].prioridad+distancia(subinicial,subobjetivo));

                resultado = buscar(subinicial, subobjetivo);
                if(resultado == true)
                {
                        if ( subinicial.equals(subobjetivo) ) 
                        { 
                                destinos.remove(subobjetivo);
                        }
                        if ( pasos.size() > 1 ) {
                           switch(pasos.get(1)) {
                              case 'D': cartero1.moverCeldaAbajo();break;
                              case 'U': cartero1.moverCeldaArriba(); break;
                              case 'R': cartero1.moverCeldaDerecha();break;
                              case 'L': cartero1.moverCeldaIzquierda();break;
                            }


                                mapa.lienzoPadre.repaint(); 
                            }
                }

            }
            else
            {
                colaEstados.clear();
                historial.clear();
                pasos.clear();
                Estado subinicial,subobjetivo;
                boolean resultado;
                subinicial=new Estado(  cartero1.cartero.x,
                                                cartero1.cartero.y,'N',null);
                subobjetivo= new Estado(  mapa.lienzoPadre.carteroInicialX,
                                                mapa.lienzoPadre.carteroInicialY,'N',null);
                subinicial.prioridad= (int) (mapa.celdas[cartero1.cartero.x][cartero1.cartero.y].prioridad+distancia(subinicial,subobjetivo));

                resultado = buscar(subinicial, subobjetivo);
                if(resultado == true)
                {
                        if ( subinicial.equals(subobjetivo) ) 
                        { 
                            destinos.remove(subobjetivo);
                        }
                        if ( pasos.size() > 1 ) {
                           switch(pasos.get(1)) {
                              case 'D': cartero1.moverCeldaAbajo();break;
                              case 'U': cartero1.moverCeldaArriba(); break;
                              case 'R': cartero1.moverCeldaDerecha();break;
                              case 'L': cartero1.moverCeldaIzquierda();break;
                            }


                                mapa.lienzoPadre.repaint(); 
                            }
                }
            }
        }
        else
        {
                destinos.clear();
                destinos.add(new Estado(  mapa.lienzoPadre.carteroInicialX,
                                                mapa.lienzoPadre.carteroInicialY,'N',null));
                colaEstados.clear();
                historial.clear();
                pasos.clear();
                Estado subinicial,subobjetivo;
                boolean resultado;
                subinicial=new Estado(  cartero1.cartero.x,
                                                cartero1.cartero.y,'N',null);
                subobjetivo= destinos.get(0);
                subinicial.prioridad= (int) (mapa.celdas[cartero1.cartero.x][cartero1.cartero.y].prioridad+distancia(subinicial,subobjetivo));

                resultado = buscar(subinicial, subobjetivo);
                if(resultado == true)
                {
                        if ( subinicial.equals(subobjetivo) ) 
                        { 
                                destinos.remove(subobjetivo);
                        }
                        if ( pasos.size() > 1 ) {
                           switch(pasos.get(1)) {
                              case 'D': cartero1.moverCeldaAbajo();break;
                              case 'U': cartero1.moverCeldaArriba(); break;
                              case 'R': cartero1.moverCeldaDerecha();break;
                              case 'L': cartero1.moverCeldaIzquierda();break;
                            }


                                mapa.lienzoPadre.repaint(); 
                            }
                }
        }
    }
   
}