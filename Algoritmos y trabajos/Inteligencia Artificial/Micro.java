
import java.util.TimerTask;

/**
 *
 * @author Hans Buker
 */
public class Micro extends TimerTask implements Constantes{
    public Mapa mapa;
    public Celda micro;
    //public Persecutor persecutor;
    //variable de interaccion para saber para donde me muevo
    public int interaccion,tiempoDormido;
    
    // para los tiempos que esta afk
    
    //Registro de movimiento
    public int  Izquierda=1,
                Derecha=3,
                Arriba=0,
                Abajo=2;
    //Memoria de ultimo cuadro pisado para asi recordar el ultimo tipo de celda que se estaba pisando
    public char memoria;
    
    @Override
    public void run() 
    {
        
        movimientosAleatorios();
        //if(distancia(automovil.x,mapa.lienzoPadre.cartero.))
        try{
            Thread.sleep(tiempoDormido);
        } catch(InterruptedException ex) 
        {
            
        }
        mapa.lienzoPadre.repaint();
    }
    
    public Micro(int posicionX,int posicionY,Mapa laberinto,int tiempoDormido)
    {
        //tiempo dormido
        this.tiempoDormido=tiempoDormido;
        
        this.mapa=laberinto;
        micro=new Celda(posicionX,posicionY,MICRO);
        laberinto.celdas[micro.x][micro.y].tipo=MICRO;
        interaccion=0;
    }
    
    //En Laberinto se encuentra la ejecucion de cada movimiento
    
    /*    
        CAMINO = 'T';
        CARRETERA ='R';
        PARED = 'W';
        PEATON = 'P';
        CARTERO = 'E';
        PORTAL ='C';
    
        ARRIBA     =   -1; 
        ABAJO      =   1;
        IZQUIERDA  =   -1;
        DERECHA    =   1;
    */
    
    public void moverCeldaArriba()
    {
        if(micro.y > 0)
        {
            if(nohayPared(micro.x, micro.y+ARRIBA))
            {  
                    avanzar(micro.x,micro.y,'U');
                    mapa.lienzoPadre.bloquearDerechaBus= false;
                    mapa.lienzoPadre.bloquearIzquierdaBus= false;
                    mapa.lienzoPadre.bloquearArribaBus= true;
                    mapa.lienzoPadre.bloquearAbajoBus= false;
                    if(micro.x+DERECHA < anchuraMundoVirtual-1)
                        if(mapa.celdas[micro.x+DERECHA][micro.y].tipo==PARADA)
                            reducirPasajeros();
            }
            
        }
        else
        {
            this.moverCeldaIzquierda();
        }
    }
    public void moverCeldaAbajo()
    {
        if(micro.y < alturaMundoVirtual-1)
        {
            if(nohayPared(micro.x, micro.y+ABAJO))
            {
                    avanzar(micro.x,micro.y,'D');
                    mapa.lienzoPadre.bloquearDerechaBus= false;
                    mapa.lienzoPadre.bloquearIzquierdaBus= false;
                    mapa.lienzoPadre.bloquearArribaBus= false;
                    mapa.lienzoPadre.bloquearAbajoBus= true;
                    if(micro.x+IZQUIERDA > 0)
                        if(mapa.celdas[micro.x+IZQUIERDA][micro.y].tipo==PARADA)
                            reducirPasajeros();
            }
        }
        else{
            this.moverCeldaDerecha();
        }
    }

    public void moverCeldaIzquierda() 
    {
        if(micro.x > 0)
        {
            if(nohayPared(micro.x+IZQUIERDA, micro.y))
            {
                    avanzar(micro.x,micro.y,'L');
                    mapa.lienzoPadre.bloquearDerechaBus= false;
                    mapa.lienzoPadre.bloquearIzquierdaBus= true;
                    mapa.lienzoPadre.bloquearArribaBus= false;
                    mapa.lienzoPadre.bloquearAbajoBus= false;
                    
                    if(micro.y+ABAJO < alturaMundoVirtual-1)
                        if(mapa.celdas[micro.x][micro.y+ABAJO].tipo==PARADA)
                            reducirPasajeros();
            }
        }
        else
        {
            this.moverCeldaArriba();
        }
    }
    
    public void moverCeldaDerecha()
    {
        if(micro.x < anchuraMundoVirtual-1)
        {
            if(nohayPared(micro.x+DERECHA, micro.y))
            {
                    avanzar(micro.x,micro.y,'R');
                    mapa.lienzoPadre.bloquearDerechaBus= true;
                    mapa.lienzoPadre.bloquearIzquierdaBus= false;
                    mapa.lienzoPadre.bloquearArribaBus= false;
                    mapa.lienzoPadre.bloquearAbajoBus= false;
                    if(micro.y+ARRIBA > 0)
                        if(mapa.celdas[micro.x][micro.y+ARRIBA].tipo==PARADA)
                            reducirPasajeros();
            }
        }
        else
        {
            this.moverCeldaAbajo();
        }
    }
    
    public boolean nohayPared(int x, int y)
    {
        if(
                mapa.celdas[x][y].tipo != PARED && 
                mapa.celdas[x][y].tipo != CARTERO && 
                mapa.celdas[x][y].tipo != EDIFICIO && 
                mapa.celdas[x][y].tipo != PORTAL && 
                mapa.celdas[x][y].tipo != PEATON &&
                mapa.celdas[x][y].tipo != CAMINO &&
                mapa.celdas[x][y].tipo != AUTOMOVIL &&
                mapa.celdas[x][y].tipo != LADRON
            )
        {
            return true;
        }
        return false;
    }
    
    public void avanzar(int x, int y, char lado)
    {
        switch(lado){
            //ARRIBA
            case 'U':
                    mapa.celdas[x][y].tipo=memoria;
                    memoria=mapa.celdas[x][movimiento(y, ARRIBA)].tipo;
                    micro.y= movimiento(y, ARRIBA);
                    y=movimiento(y,ARRIBA);
                    mapa.celdas[x][y].tipo=MICRO;
                    //persecutor.moverCeldaArriba();
                    break;
            //ABAJO
            case 'D':
                    mapa.celdas[x][y].tipo=memoria;
                    memoria=mapa.celdas[x][movimiento(y, ABAJO)].tipo;
                    micro.y= movimiento(y, ABAJO);
                    y=movimiento(y,ABAJO);
                    mapa.celdas[x][y].tipo=MICRO;
                    //persecutor.moverCeldaAbajo();
                    break;
            //IZQUIERDA
            case 'L':
                    mapa.celdas[x][y].tipo=memoria;
                    memoria=mapa.celdas[movimiento(x, IZQUIERDA)][y].tipo;
                    micro.x= movimiento(x, IZQUIERDA);
                    x=movimiento(x, IZQUIERDA);
                    mapa.celdas[x][y].tipo=MICRO;
                    //persecutor.moverCeldaIzquierda();
                    break;
            //DERECHA
            case 'R':
                    mapa.celdas[x][y].tipo=memoria;
                    memoria=mapa.celdas[movimiento(x, DERECHA)][y].tipo;
                    micro.x= movimiento(x, DERECHA);
                    x= movimiento(x, DERECHA);
                    mapa.celdas[x][y].tipo=MICRO;
                    //persecutor.moverCeldaDerecha();
                    break;
                    
        }
    }
    
    public int distancia(int valor1, int valor2)
    {
        return valor2-valor1;
    }
    
    public int movimiento(int posicion,int direccion)
    {
        return posicion + direccion;
    }
    
        public void movimientosAleatorios()
    {
        int i=numeroAleatorio(1,4);
        boolean salida=false;
        while(salida==false){
            switch(i) 
            {
                case 1:   
                          if(
                                  micro.x == 5 ||
                                  micro.x == 12 ||
                                  micro.x == 19 ||
                                  micro.x == 24
                            )
                            {    
                                this.moverCeldaArriba();
                                salida=true;
                            }
                          else i=numeroAleatorio(1,4);
                                break;
                case 2:   
                           if(  
                                micro.x == 4 ||
                                micro.x == 11 ||
                                micro.x == 18 ||
                                micro.x == 0
                                   )
                                  {
                              
                            this.moverCeldaAbajo();
                            salida=true;
                                  }
                            else i=numeroAleatorio(1,4);
                            break;

                case 3:   

                          if(   micro.y == 5 ||
                                micro.y == 12 ||
                                micro.y == 19 ||
                                micro.y == 24
                            ) 
                          {
                            this.moverCeldaIzquierda();
                            salida=true;
                          } else i=numeroAleatorio(1,4);
                            break;
                case 4:   
                          if(   micro.y == 4 ||
                                micro.y == 11 ||
                                micro.y == 18 ||
                                micro.y == 0
                            ) 
                            {
                            this.moverCeldaDerecha();
                            salida=true;
                            } else i=numeroAleatorio(1,4);
                            break;
            }
        }
        
    }
    
        public void reducirPasajeros()
        {
            mapa.lienzoPadre.reducirPasajeros(1);
        }
    }

/* 
    DISTANCIA
    MODIFICACIONES
*/

