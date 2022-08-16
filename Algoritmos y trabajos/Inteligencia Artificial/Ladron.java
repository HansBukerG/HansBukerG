
public class Ladron implements Constantes{
    public Mapa mapa;
    public Celda ladron;
    //public Persecutor persecutor;
    public boolean pasoHabilitado = true;
    
    //variable de interaccion para saber para donde me muevo
    public int interaccion,tiempoDormido,marcador=0;
    
    // para los tiempos que esta afk
    
    //Registro de movimiento
    public int  Izquierda=1,
                Derecha=3,
                Arriba=0,
                Abajo=2;
    //Memoria de ultimo cuadro pisado para asi recordar el ultimo tipo de celda que se estaba pisando
    public char memoria;
    
    
    public BusquedaAnchuraMultiObjetivoLadron anchuraMulti;
    //implementacion de la IA
    //BusquedaRutaAmplitud nueva;
    
    
    public Ladron(int posicionX,int posicionY,Mapa mapa,int tiempoDormido)
    {
        //tiempo dormido
        this.tiempoDormido=tiempoDormido;
        
        this.mapa=mapa;
        ladron=new Celda(posicionX,posicionY,LADRON);
        mapa.celdas[ladron.x][ladron.y].tipo=LADRON;
        interaccion=0;
        
        anchuraMulti= new BusquedaAnchuraMultiObjetivoLadron(mapa, this);
        //anchuraMultiInfo = new BusquedaAnchuraMultiObjetivoInformada(mapa, this);
        /*profundidadMiltiObjetivo = new BusquedaProfundidadMultiObjetivo(mapa, this);*/
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
        if(ladron.y > 0)
        {
            if(nohayPared(ladron.x, ladron.y+ARRIBA))
            {
                if(mapa.celdas[ladron.x][movimiento(ladron.y, ARRIBA)].tipo!=CARTERO)
                {   
                    avanzar(ladron.x,ladron.y,'U');
                    bloqueoDeTexto();                    
                }
                else
                {
                    //avanzar(ladron.x,ladron.y,'U');
                    quitarCartas();
                }
            }
            
        }
    }
    public void moverCeldaAbajo()
    {
        if(ladron.y < alturaMundoVirtual-1)
        {
            if(nohayPared(ladron.x, ladron.y+ABAJO))
            {
                
                if(mapa.celdas[ladron.x][movimiento(ladron.y, ABAJO)].tipo!=CARTERO)
                {
                    avanzar(ladron.x,ladron.y,'D');
                }else
                {
                    //avanzar(ladron.x,ladron.y,'D');
                    quitarCartas();
                }
            }
        }
    }

    public void moverCeldaIzquierda() 
    {
        if(ladron.x > 0)
        {
            if(nohayPared(ladron.x+IZQUIERDA, ladron.y))
            {
                if(mapa.celdas[movimiento(ladron.x, IZQUIERDA)][ladron.y].tipo!=CARTERO)
                {
                    avanzar(ladron.x,ladron.y,'L');
                }
                else
                {
                    //avanzar(ladron.x,ladron.y,'L');
                    quitarCartas();
                }
            }
        }
    }
    
    public void moverCeldaDerecha()
    {
        if(ladron.x < anchuraMundoVirtual-1)
        {
            if(nohayPared(ladron.x+DERECHA, ladron.y))
            {
                if(mapa.celdas[movimiento(ladron.x, DERECHA)][ladron.y].tipo!=CARTERO)
                {
                    avanzar(ladron.x,ladron.y,'R');
                }
                else
                {
                    //avanzar(ladron.x,ladron.y,'R');
                    quitarCartas();
                }
            }
        }
    }
    
    public boolean nohayPared(int x, int y)
    {
        if(     
                mapa.celdas[x][y].tipo != PARED &&
                mapa.celdas[x][y].tipo != PEATON &&
                mapa.celdas[x][y].tipo != EDIFICIO &&
                mapa.celdas[x][y].tipo != AUTOMOVIL &&
                mapa.celdas[x][y].tipo != MICRO &&
                //mapa.celdas[x][y].tipo != CARTERO &&
                noHayVehiculo(x,y) == false
                //mapa.celdas[x][y].tipo != CARRETERA
          )
        {
            return true;
        }
        return false;
    }
    
    //modificar esta parte para la deteccion de vehoculos
    public boolean noHayVehiculo(int x, int y)
    {
        if(
                y > 0 &&
                y < alturaMundoVirtual-1 &&
                x > 0 &&
                x < anchuraMundoVirtual-1
           )
        {
            if(         mapa.celdas[x][y].tipo!=CAMINO  
                    &&  mapa.celdas[x][y].tipo!=CRUCE
                    &&  mapa.celdas[x][y].tipo!=PARADA
                    )
            {   
                if(mapa.celdas[x+DERECHA][y].tipo== AUTOMOVIL )          return true;
                if(mapa.celdas[x+IZQUIERDA][y].tipo== AUTOMOVIL)        return true;
                if(mapa.celdas[x][y+ARRIBA].tipo== AUTOMOVIL )           return true;
                if(mapa.celdas[x][y+ABAJO].tipo== AUTOMOVIL )            return true;
                if(mapa.celdas[x+DERECHA][y+ARRIBA].tipo== AUTOMOVIL )   return true;
                if(mapa.celdas[x+DERECHA][y+ABAJO].tipo== AUTOMOVIL )    return true;
                if(mapa.celdas[x+IZQUIERDA][y+ARRIBA].tipo== AUTOMOVIL ) return true;
                if(mapa.celdas[x+IZQUIERDA][y+ABAJO].tipo== AUTOMOVIL )  return true;
                
                if(mapa.celdas[x+DERECHA][y].tipo== MICRO)          return true;
                if(mapa.celdas[x+IZQUIERDA][y].tipo== MICRO)        return true;
                if(mapa.celdas[x][y+ARRIBA].tipo== MICRO)           return true;
                if(mapa.celdas[x][y+ABAJO].tipo== MICRO)            return true;
                if(mapa.celdas[x+DERECHA][y+ARRIBA].tipo== MICRO)   return true;
                if(mapa.celdas[x+DERECHA][y+ABAJO].tipo== MICRO)    return true;
                if(mapa.celdas[x+IZQUIERDA][y+ARRIBA].tipo== MICRO) return true;
                if(mapa.celdas[x+IZQUIERDA][y+ABAJO].tipo== MICRO)  return true;
                
        
            }
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
                    ladron.y= movimiento(y, ARRIBA);
                    y=movimiento(y,ARRIBA);
                    mapa.celdas[x][y].tipo=LADRON;
                    //persecutor.moverCeldaArriba();
                    break;
            //ABAJO
            case 'D':
                    mapa.celdas[x][y].tipo=memoria;
                    memoria=mapa.celdas[x][movimiento(y, ABAJO)].tipo;
                    ladron.y= movimiento(y, ABAJO);
                    y=movimiento(y,ABAJO);
                    mapa.celdas[x][y].tipo=LADRON;
                    //persecutor.moverCeldaAbajo();
                    break;
            //IZQUIERDA
            case 'L':
                    mapa.celdas[x][y].tipo=memoria;
                    memoria=mapa.celdas[movimiento(x, IZQUIERDA)][y].tipo;
                    ladron.x= movimiento(x, IZQUIERDA);
                    x=movimiento(x, IZQUIERDA);
                    mapa.celdas[x][y].tipo=LADRON;
                    //persecutor.moverCeldaIzquierda();
                    break;
            //DERECHA
            case 'R':
                    mapa.createImage(x, DERECHA);
                    mapa.celdas[x][y].tipo=memoria;
                    memoria=mapa.celdas[movimiento(x, DERECHA)][y].tipo;
                    ladron.x= movimiento(x, DERECHA);
                    x= movimiento(x, DERECHA);
                    mapa.celdas[x][y].tipo=LADRON;
                    //persecutor.moverCeldaDerecha();
                    break;
                    
        }
    }
    
    public int movimiento(int posicion,int direccion)
    {
        return posicion + direccion;
    }

    public void desbloqueoDeTexto()
    {
        mapa.lienzoPadre.DesbloqueoDeTexto();
        //mapa.lienzoPadre.reducirCartas(1);
        for(int i=0;i<27;i++)
                if(mapa.portales[i].portalSeleccionado(ladron.x, ladron.y)) mapa.portales[i].eliminarSolicitudes();
    }
    public void bloqueoDeTexto()
    {
        mapa.lienzoPadre.BloqueoDeTexto();
    }
    
    public void quitarCartas()
    {
        
        mapa.lienzoPadre.cantidadDeCartas =0;
        mapa.lienzoPadre.remanenteDeCartas =0;
        mapa.lienzoPadre.cartasRobadas = true;
    }
    
    }
    




//comprobar si estan en la misma celda, si es asi devolverles su direccion.