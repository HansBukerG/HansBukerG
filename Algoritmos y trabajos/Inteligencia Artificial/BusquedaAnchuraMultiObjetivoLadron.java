
import java.util.ArrayList;
import java.util.TimerTask;
import java.util.logging.Level;
import java.util.logging.Logger;

public class BusquedaAnchuraMultiObjetivoLadron extends TimerTask implements Constantes{
    
    public Mapa mapa;
    public Ladron ladron1;
    public ArrayList<Estado> colaEstados;
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
    
    public BusquedaAnchuraMultiObjetivoLadron(Mapa mapa,Ladron ladron) {
        
        this.mapa=mapa;
        this.ladron1=ladron;
        colaEstados=new ArrayList<>();
        historial=new ArrayList<>();
        pasos=new ArrayList<>();
        
        destinos=new ArrayList<>();
        
        index_pasos=0;
        exito=false;
        parar=false;
    }
    
    public boolean buscar(Estado inicial,Estado objetivo) {
        
        
        System.out.println("Estado inicial"+inicial.toString());
        System.out.println("Estado objetivo"+objetivo.toString());
        index_pasos=0;
        colaEstados.add(inicial);
        historial.add(inicial);
        this.objetivo=objetivo;
        exito=false;
        
        if ( inicial.equals(objetivo)) exito=true;
        
        while ( !colaEstados.isEmpty() && !exito ){
            
            temp=colaEstados.get(0);
            //System.out.println(temp.toString());
            colaEstados.remove(0);
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
            if ( ladron1.nohayPared(e.x, e.y-1)) { 
                 Estado arriba=new Estado(e.x,e.y-1,'U',e);
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
       
        if ( e.y+1 < alturaMundoVirtual ) { 
            if ( ladron1.nohayPared(e.x, e.y+1) ) {
                 Estado abajo=new Estado(e.x,e.y+1,'D',e);   
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
            if ( ladron1.nohayPared(e.x-1, e.y) ) {
                Estado izquierda=new Estado(e.x-1,e.y,'L',e);
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
            if ( ladron1.nohayPared(e.x+1, e.y) ) {
               Estado derecha=new Estado(e.x+1,e.y,'R',e); 
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
    
    @Override
    public void run() {
        if(mapa.lienzoPadre.cantidadDeCartas>0)
        {
            
                colaEstados.clear();
                historial.clear();
                pasos.clear();
                Estado subinicial,subobjetivo;
                boolean resultado;
                subinicial=new Estado(  ladron1.ladron.x,
                                                ladron1.ladron.y,'N',null);
                subobjetivo=new Estado(  mapa.lienzoPadre.cartero.cartero.x,
                                                mapa.lienzoPadre.cartero.cartero.y,'N',null);
                resultado = buscar(subinicial, subobjetivo);
                if(resultado == true)
                {
                    if ( subinicial.equals(subobjetivo) ) 
                    {
                        destinos.remove(subobjetivo);
                    }
                    if ( pasos.size() > 1 ) {
                       switch(pasos.get(1)) {
                          case 'D': ladron1.moverCeldaAbajo();break;
                          case 'U': ladron1.moverCeldaArriba(); break;
                          case 'R': ladron1.moverCeldaDerecha();break;
                          case 'L': ladron1.moverCeldaIzquierda();break;
                        }


                            mapa.lienzoPadre.repaint(); 
                        }
                }
            
            }
            else
            {
                /*colaEstados.clear();
                historial.clear();
                pasos.clear();
                Estado subinicial,subobjetivo;
                boolean resultado;
                subinicial=new Estado(  ladron1.ladron.x,
                                                ladron1.ladron.y,'N',null);
                subobjetivo=new Estado(  mapa.lienzoPadre.posInicialLadronX,
                                                mapa.lienzoPadre.posInicialLadronY,'N',null);
                resultado = buscar(subinicial, subobjetivo);
                if(resultado == true)
                {
                    if ( subinicial.equals(subobjetivo) ) 
                    { 
                            destinos.remove(subobjetivo);
                    }
                    if ( pasos.size() > 1 ) {
                       switch(pasos.get(1)) {
                          case 'D': ladron1.moverCeldaAbajo();break;
                          case 'U': ladron1.moverCeldaArriba(); break;
                          case 'R': ladron1.moverCeldaDerecha();break;
                          case 'L': ladron1.moverCeldaIzquierda();break;
                        }


                            mapa.lienzoPadre.repaint(); 
                        }
                }*/
            }
        
        }
        
    
}