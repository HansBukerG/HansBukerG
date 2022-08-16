
import java.util.ArrayList;
import java.util.TimerTask;
import java.util.logging.Level;
import java.util.logging.Logger;

public class BusquedaAnchuraMultiObjetivoCartero extends TimerTask implements Constantes{
    
    public Mapa mapa;
    public Cartero cartero1;
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
    
    public BusquedaAnchuraMultiObjetivoCartero(Mapa mapa,Cartero cartero) {
        
        this.mapa=mapa;
        this.cartero1=cartero;
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
            if ( cartero1.nohayPared(e.x, e.y-1)) { 
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
            if ( cartero1.nohayPared(e.x, e.y+1) ) {
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
            if ( cartero1.nohayPared(e.x-1, e.y) ) {
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
            if ( cartero1.nohayPared(e.x+1, e.y) ) {
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
            if(destinos.size()!=0){
                colaEstados.clear();
                historial.clear();
                pasos.clear();
                Estado subinicial,subobjetivo;
                boolean resultado;
                subinicial=new Estado(  cartero1.cartero.x,
                                                cartero1.cartero.y,'N',null);
                subobjetivo=destinos.get(0);
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
                subobjetivo=new Estado(  mapa.lienzoPadre.carteroInicialX,
                                                mapa.lienzoPadre.carteroInicialY,'N',null);
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
                subobjetivo=destinos.get(0);
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