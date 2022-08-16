
public class Portal implements Constantes{
    public Mapa mapa;
    public Celda portal;
    public int cantidadSolicitudes;
    
    public Portal(int posicionX,int posicionY,Mapa mapa, int cartas)
    {
        this.mapa=mapa;
        portal=new Celda(posicionX,posicionY,CARTERO);
        mapa.celdas[portal.x][portal.y].tipo=PORTAL;
        
        if(PORTALAUTOMATICO== false)
            cantidadSolicitudes=cartas;
        
    }
    public void eliminarSolicitudes()
    {
        mapa.lienzoPadre.reducirCartas(cantidadSolicitudes);
        cantidadSolicitudes-= mapa.lienzoPadre.cantidadDeCartas+cantidadSolicitudes;
        if (cantidadSolicitudes<0) cantidadSolicitudes = 0;
    }
    
    public boolean portalSeleccionado(int x, int y)
    {
        if(x==portal.x && y==portal.y) return true;
        else        return false;
    }
    
    public String toString()
    {
        return ""+cantidadSolicitudes;
    }
    
    public boolean portalObjetivo()
    {
        if(cantidadSolicitudes>0) return true;
        else return false;
    }
    
    public int asignarCartas(int cartas)
    {
        return cantidadSolicitudes += cartas;
    }
    }
    




//comprobar si estan en la misma celda, si es asi devolverles su direccion.