import java.util.TimerTask;

public class Peaton extends TimerTask implements Constantes{
    public Mapa mapa;
    public Celda peaton;
    
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
        
        try{
            Thread.sleep(tiempoDormido);
        } catch(InterruptedException ex) 
        {
            
        }
        mapa.lienzoPadre.repaint();
    }
    
    public Peaton(int posicionX,int posicionY,Mapa laberinto,int tiempoDormido)
    {
        //tiempo dormido
        this.tiempoDormido=tiempoDormido;
        
        this.mapa=laberinto;
        peaton=new Celda(posicionX,posicionY,PEATON);
        laberinto.celdas[peaton.x][peaton.y].tipo=PEATON;
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
        if(peaton.y > 0)
        {
            if(nohayPared(peaton.x, peaton.y+ARRIBA))
            {  
                    avanzar(peaton.x,peaton.y,'U');
            }
            
        }
    }
    public void moverCeldaAbajo()
    {
        if(peaton.y < alturaMundoVirtual-1)
        {
            if(nohayPared(peaton.x, peaton.y+ABAJO))
            {
                    avanzar(peaton.x,peaton.y,'D');
            }
        }
    }

    public void moverCeldaIzquierda() 
    {
        if(peaton.x > 0)
        {
            if(nohayPared(peaton.x+IZQUIERDA, peaton.y))
            {
                    avanzar(peaton.x,peaton.y,'L');
            }
        }
    }
    
    public void moverCeldaDerecha()
    {
        if(peaton.x < anchuraMundoVirtual-1)
        {
            if(nohayPared(peaton.x+DERECHA, peaton.y))
            {
                    avanzar(peaton.x,peaton.y,'R');
            }
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
                mapa.celdas[x][y].tipo != CARRETERA &&
                mapa.celdas[x][y].tipo != AUTOMOVIL &&
                mapa.celdas[x][y].tipo != MICRO &&
                mapa.celdas[x][y].tipo != LADRON &&
                mapa.celdas[x][y].tipo != PORTALOBJETIVO
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
                    peaton.y= movimiento(y, ARRIBA);
                    y=movimiento(y,ARRIBA);
                    mapa.celdas[x][y].tipo=PEATON;
                    //persecutor.moverCeldaArriba();
                    break;
            //ABAJO
            case 'D':
                    mapa.celdas[x][y].tipo=memoria;
                    memoria=mapa.celdas[x][movimiento(y, ABAJO)].tipo;
                    peaton.y= movimiento(y, ABAJO);
                    y=movimiento(y,ABAJO);
                    mapa.celdas[x][y].tipo=PEATON;
                    //persecutor.moverCeldaAbajo();
                    break;
            //IZQUIERDA
            case 'L':
                    mapa.celdas[x][y].tipo=memoria;
                    memoria=mapa.celdas[movimiento(x, IZQUIERDA)][y].tipo;
                    peaton.x= movimiento(x, IZQUIERDA);
                    x=movimiento(x, IZQUIERDA);
                    mapa.celdas[x][y].tipo=PEATON;
                    //persecutor.moverCeldaIzquierda();
                    break;
            //DERECHA
            case 'R':
                    mapa.celdas[x][y].tipo=memoria;
                    memoria=mapa.celdas[movimiento(x, DERECHA)][y].tipo;
                    peaton.x= movimiento(x, DERECHA);
                    x= movimiento(x, DERECHA);
                    mapa.celdas[x][y].tipo=PEATON;
                    //persecutor.moverCeldaDerecha();
                    break;
                    
        }
    }
    
    public int movimiento(int posicion,int direccion)
    {
        return posicion + direccion;
    }
    
        public void movimientosAleatorios()
    {
        int i;
        i=numeroAleatorio(1,4);
        switch(i) 
        {
            case 1:   this.moverCeldaArriba();
                      break;
            case 2:   this.moverCeldaAbajo();
                      break;
            case 3:   this.moverCeldaIzquierda();
                      break;
            case 4:   this.moverCeldaDerecha();
                      break;
        }
    }
    
    }
    

