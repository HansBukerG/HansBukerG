import java.util.TimerTask;

public class Automovil extends TimerTask implements Constantes{
    public Mapa mapa;
    public Celda automovil;
    
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
    
    public Automovil(int posicionX,int posicionY,Mapa laberinto,int tiempoDormido)
    {
        //tiempo dormido
        this.tiempoDormido=tiempoDormido;
        
        this.mapa=laberinto;
        automovil=new Celda(posicionX,posicionY,AUTOMOVIL);
        laberinto.celdas[automovil.x][automovil.y].tipo=AUTOMOVIL;
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
        if(automovil.y > 0)
        {
            
                if(nohayPared(automovil.x, automovil.y+ARRIBA))
                {  
                        avanzar(automovil.x,automovil.y,'U');
                }
        }
        else
        {
            this.moverCeldaIzquierda();
        }
    }
    public void moverCeldaAbajo()
    {
        if(automovil.y < alturaMundoVirtual-1)
        {
            
            
                if(nohayPared(automovil.x, automovil.y+ABAJO))
                {
                        avanzar(automovil.x,automovil.y,'D');
                }
            
        }
        else
        {
            this.moverCeldaDerecha();
        }
    }

    public void moverCeldaIzquierda() 
    {
        if(automovil.x > 0)
        {
             
            
                if(nohayPared(automovil.x+IZQUIERDA, automovil.y))
                {
                        avanzar(automovil.x,automovil.y,'L');
                }
            
        }
        else
        {
            this.moverCeldaArriba();
        }
    }
    
    public void moverCeldaDerecha()
    {
        if(automovil.x < anchuraMundoVirtual-1)
        {
            
            
                if(nohayPared(automovil.x+DERECHA, automovil.y))
                {
                        avanzar(automovil.x,automovil.y,'R');
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
                mapa.celdas[x][y].tipo != MICRO &&
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
                    automovil.y= movimiento(y, ARRIBA);
                    y=movimiento(y,ARRIBA);
                    mapa.celdas[x][y].tipo=AUTOMOVIL;
                    //persecutor.moverCeldaArriba();
                    break;
            //ABAJO
            case 'D':
                    mapa.celdas[x][y].tipo=memoria;
                    memoria=mapa.celdas[x][movimiento(y, ABAJO)].tipo;
                    automovil.y= movimiento(y, ABAJO);
                    y=movimiento(y,ABAJO);
                    mapa.celdas[x][y].tipo=AUTOMOVIL;
                    //persecutor.moverCeldaAbajo();
                    break;
            //IZQUIERDA
            case 'L':
                    mapa.celdas[x][y].tipo=memoria;
                    memoria=mapa.celdas[movimiento(x, IZQUIERDA)][y].tipo;
                    automovil.x= movimiento(x, IZQUIERDA);
                    x=movimiento(x, IZQUIERDA);
                    mapa.celdas[x][y].tipo=AUTOMOVIL;
                    //persecutor.moverCeldaIzquierda();
                    break;
            //DERECHA
            case 'R':
                    mapa.celdas[x][y].tipo=memoria;
                    memoria=mapa.celdas[movimiento(x, DERECHA)][y].tipo;
                    automovil.x= movimiento(x, DERECHA);
                    x= movimiento(x, DERECHA);
                    mapa.celdas[x][y].tipo=AUTOMOVIL;
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
        int i;
        i=numeroAleatorio(1,4);
        boolean salida=false;
        while(salida==false){
            switch(i) 
            {
                case 1:   
                            if(
                                  automovil.x == 5 ||
                                  automovil.x == 12 ||
                                  automovil.x == 19 ||
                                  automovil.x == 24
                            )
                            {    
                                this.moverCeldaArriba();
                                salida=true;
                            }
                            else i=numeroAleatorio(1,4);
                          break;
                case 2:   
                        if(  
                                automovil.x == 4 ||
                                automovil.x == 11 ||
                                automovil.x == 18 ||
                                automovil.x == 0
                            )
                            {
                              
                            this.moverCeldaAbajo();
                            salida=true;
                                  }
                            else i=numeroAleatorio(1,4);
                            break;
                case 3:   
                            if(             
                                automovil.y == 5 ||
                                automovil.y == 12 ||
                                automovil.y == 19 ||
                                automovil.y == 24
                            )
                            {
                            this.moverCeldaIzquierda();
                            salida=true;
                            } else i=numeroAleatorio(1,4);
                          break;
                case 4:   
                            if(   automovil.y == 4 ||
                                automovil.y == 11 ||
                                automovil.y == 18 ||
                                automovil.y == 0
                            )
                            {
                            this.moverCeldaDerecha();
                            salida=true;
                            } else i=numeroAleatorio(1,4);
                            break;
            }
        }
    }
    }

/* 
    DISTANCIA
    MODIFICACIONES
*/

