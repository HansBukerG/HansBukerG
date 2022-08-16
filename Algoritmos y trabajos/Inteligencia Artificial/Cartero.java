
public class Cartero implements Constantes{
    public Mapa mapa;
    public Celda cartero;
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
    
    
    //public BusquedaAnchuraMultiObjetivo anchuraMulti;
    public BusquedaAnchuraMultiObjetivoInformadaConLadron anchuraMultiInfoLadron;
    public BusquedaAnchuraMultiObjetivoInformada anchuraMultiInfo;
    public BusquedaAnchuraMultiObjetivoCartero anchuraMulti;
    //implementacion de la IA
    //BusquedaRutaAmplitud nueva;
    
    
    public Cartero(int posicionX,int posicionY,Mapa mapa,int tiempoDormido)
    {
        //tiempo dormido
        this.tiempoDormido=tiempoDormido;
        
        this.mapa=mapa;
        cartero=new Celda(posicionX,posicionY,CARTERO);
        mapa.celdas[cartero.x][cartero.y].tipo=CARTERO;
        interaccion=0;
        
        anchuraMulti= new BusquedaAnchuraMultiObjetivoCartero(mapa, this);
        anchuraMultiInfoLadron = new BusquedaAnchuraMultiObjetivoInformadaConLadron(mapa, this);
        anchuraMultiInfo =  new BusquedaAnchuraMultiObjetivoInformada(mapa, this);
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
        if(cartero.y > 0)
        {
            if(nohayPared(cartero.x, cartero.y+ARRIBA))
            {
                if(mapa.celdas[cartero.x][movimiento(cartero.y, ARRIBA)].tipo!=PORTALOBJETIVO)
                {   
                    avanzar(cartero.x,cartero.y,'U');
                    bloqueoDeTexto();
                    mapa.lienzoPadre.bloquearDerechaCartero= false;
                    mapa.lienzoPadre.bloquearIzquierdaCartero= false;
                    mapa.lienzoPadre.bloquearArribaCartero= true;
                    mapa.lienzoPadre.bloquearAbajoCartero= false;
                }
                else
                {
                    avanzar(cartero.x,cartero.y,'U');
                    desbloqueoDeTexto();
                    mapa.lienzoPadre.bloquearDerechaCartero= false;
                    mapa.lienzoPadre.bloquearIzquierdaCartero= false;
                    mapa.lienzoPadre.bloquearArribaCartero= true;
                    mapa.lienzoPadre.bloquearAbajoCartero= false;
                }
            }
            
        }
    }
    public void moverCeldaAbajo()
    {
        if(cartero.y < alturaMundoVirtual-1)
        {
            if(nohayPared(cartero.x, cartero.y+ABAJO))
            {
                
                if(mapa.celdas[cartero.x][movimiento(cartero.y, ABAJO)].tipo!=PORTALOBJETIVO)
                {
                    avanzar(cartero.x,cartero.y,'D');
                    bloqueoDeTexto();
                    mapa.lienzoPadre.bloquearDerechaCartero= false;
                    mapa.lienzoPadre.bloquearIzquierdaCartero= false;
                    mapa.lienzoPadre.bloquearArribaCartero= false;
                    mapa.lienzoPadre.bloquearAbajoCartero= true;
                }else
                {
                    avanzar(cartero.x,cartero.y,'D');
                    desbloqueoDeTexto();
                    mapa.lienzoPadre.bloquearDerechaCartero= false;
                    mapa.lienzoPadre.bloquearIzquierdaCartero= false;
                    mapa.lienzoPadre.bloquearArribaCartero= false;
                    mapa.lienzoPadre.bloquearAbajoCartero= true;
                }
            }
        }
    }

    public void moverCeldaIzquierda() 
    {
        if(cartero.x > 0)
        {
            if(nohayPared(cartero.x+IZQUIERDA, cartero.y))
            {
                if(mapa.celdas[movimiento(cartero.x, IZQUIERDA)][cartero.y].tipo!=PORTALOBJETIVO)
                {
                    avanzar(cartero.x,cartero.y,'L');
                    bloqueoDeTexto();
                    mapa.lienzoPadre.bloquearDerechaCartero= false;
                    mapa.lienzoPadre.bloquearIzquierdaCartero= true;
                    mapa.lienzoPadre.bloquearArribaCartero= false;
                    mapa.lienzoPadre.bloquearAbajoCartero= false;
                }
                else
                {
                    avanzar(cartero.x,cartero.y,'L');
                    desbloqueoDeTexto();
                    mapa.lienzoPadre.bloquearDerechaCartero= false;
                    mapa.lienzoPadre.bloquearIzquierdaCartero= true;
                    mapa.lienzoPadre.bloquearArribaCartero= false;
                    mapa.lienzoPadre.bloquearAbajoCartero= false;
                }
            }
        }
    }
    
    public void moverCeldaDerecha()
    {
        if(cartero.x < anchuraMundoVirtual-1)
        {
            if(nohayPared(cartero.x+DERECHA, cartero.y))
            {
                if(mapa.celdas[movimiento(cartero.x, DERECHA)][cartero.y].tipo!=PORTALOBJETIVO)
                {
                    avanzar(cartero.x,cartero.y,'R');
                    bloqueoDeTexto();
                    mapa.lienzoPadre.bloquearDerechaCartero= true;
                    mapa.lienzoPadre.bloquearIzquierdaCartero= false;
                    mapa.lienzoPadre.bloquearArribaCartero= false;
                    mapa.lienzoPadre.bloquearAbajoCartero= false;
                }
                else
                {
                    avanzar(cartero.x,cartero.y,'R');
                    desbloqueoDeTexto();
                    mapa.lienzoPadre.bloquearDerechaCartero= true;
                    mapa.lienzoPadre.bloquearIzquierdaCartero= false;
                    mapa.lienzoPadre.bloquearArribaCartero= false;
                    mapa.lienzoPadre.bloquearAbajoCartero= false;
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
                mapa.celdas[x][y].tipo != LADRON &&
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
                    cartero.y= movimiento(y, ARRIBA);
                    y=movimiento(y,ARRIBA);
                    mapa.celdas[x][y].tipo=CARTERO;
                    //persecutor.moverCeldaArriba();
                    break;
            //ABAJO
            case 'D':
                    mapa.celdas[x][y].tipo=memoria;
                    memoria=mapa.celdas[x][movimiento(y, ABAJO)].tipo;
                    cartero.y= movimiento(y, ABAJO);
                    y=movimiento(y,ABAJO);
                    mapa.celdas[x][y].tipo='E';
                    //persecutor.moverCeldaAbajo();
                    break;
            //IZQUIERDA
            case 'L':
                    mapa.celdas[x][y].tipo=memoria;
                    memoria=mapa.celdas[movimiento(x, IZQUIERDA)][y].tipo;
                    cartero.x= movimiento(x, IZQUIERDA);
                    x=movimiento(x, IZQUIERDA);
                    mapa.celdas[x][y].tipo='E';
                    //persecutor.moverCeldaIzquierda();
                    break;
            //DERECHA
            case 'R':
                    mapa.createImage(x, DERECHA);
                    mapa.celdas[x][y].tipo=memoria;
                    memoria=mapa.celdas[movimiento(x, DERECHA)][y].tipo;
                    cartero.x= movimiento(x, DERECHA);
                    x= movimiento(x, DERECHA);
                    mapa.celdas[x][y].tipo='E';
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
                if(mapa.portales[i].portalSeleccionado(cartero.x, cartero.y)) mapa.portales[i].eliminarSolicitudes();
    }
    public void bloqueoDeTexto()
    {
        mapa.lienzoPadre.BloqueoDeTexto();
    }
    
    public void ponerPeatones()
    {}
    
    }
    




//comprobar si estan en la misma celda, si es asi devolverles su direccion.