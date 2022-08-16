/* paquetes que utilizaremos */
import java.awt.Graphics;
import java.awt.Point;
import java.awt.Rectangle;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import javax.imageio.ImageIO;
import javax.swing.JComponent;
/* clase Celda que era de JComponent e implementa Constantes */
public class Celda extends JComponent implements Constantes 
{
    //posicion x e y de la Celda
    public int x;
    public int y;
    public Rectangle rectanguloCelda;
    public char tipo;
    
    //public int valorDeCelda; 
    
    // se agrega nueva entidad llamada "pelota"
    public BufferedImage    camino, 
                            pared, 
                            carretera, 
                            peaton, 
                            portal, 
                            cartero, 
                            edificio, 
                            automovil,
                            cruce,
                            micro,
                            parada,
                            mensaje,
                            portalObjetivo,
                            ladron,
                            minimensaje;
    
    

    //sprites    
    
    public int indexSprite;
    public BufferedImage sprites[],imagenSprites;
    
    //prioridad de celda
    public int prioridad=0;
    
    //constructor
    
    public Celda(int x,int y,char tipo) 
    {
        this.x=x;
        this.y=y;
        this.tipo=tipo;
        rectanguloCelda= new Rectangle(x,y,anchuraCelda,alturaCelda);
        
        //sprites 
        indexSprite=2;
        
        try 
        {
            camino          =   ImageIO.read(new File("imagenes/camino.png"));
            pared           =   ImageIO.read(new File("imagenes/pared.png"));
            carretera       =   ImageIO.read(new File("imagenes/carretera.png"));
            peaton          =   ImageIO.read(new File("imagenes/peaton.png"));
            portal          =   ImageIO.read(new File("imagenes/portal.png"));
            cartero         =   ImageIO.read(new File("imagenes/cartero.png"));
            edificio        =   ImageIO.read(new File("imagenes/edificio.png"));
            automovil       =   ImageIO.read(new File("imagenes/automovil.png"));
            cruce           =   ImageIO.read(new File("imagenes/cruce.png"));
            micro           =   ImageIO.read(new File("imagenes/micro.png"));
            parada          =   ImageIO.read(new File("imagenes/parada.png"));
            mensaje         =   ImageIO.read(new File("imagenes/mensaje.png"));
            portalObjetivo  =   ImageIO.read(new File("imagenes/portalObjetivo.png"));
            ladron          =   ImageIO.read(new File("imagenes/ladron.png"));
            minimensaje     =   ImageIO.read(new File("imagenes/minimensaje.png"));
        } catch (IOException e) 
        {
        System.out.println(e.toString());
        }
    }
    //metodo para dibujar celda, hace uso de drawRect
    @Override
    public void update(Graphics g)
    {
        switch(tipo) 
        {
            // Camino
            case 'C':   g.drawImage(portal,x,y, this);
                        break;
            //carretera
            case 'R':   g.drawImage(carretera,x,y, this); 
                        break;
            //Pared
            case 'W':   g.drawImage(pared,x,y, this);
                        break;
            //Peaton
            case 'P':   g.drawImage(peaton,x,y, this); 
                        break;
            //Cartero
            case 'E':   g.drawImage(cartero,x,y, this); 
                        break;
            //Portal
            case 'T':   g.drawImage(camino, x, y, null);
                        break;
            //edificio
            case 'K':   g.drawImage(edificio, x, y, null);
                        break;
            //automovil
            case 'A':   g.drawImage(automovil, x, y, null);
                        break;
            //cruce
            case 'V':   g.drawImage(cruce, x, y, null);
            break;
            //micro
            case MICRO:   g.drawImage(micro, x, y, null);
            break;
            //parada
            case PARADA:   g.drawImage(parada, x, y, null);
            break;
            //mensaje
            case MENSAJE:   g.drawImage(mensaje, x, y, null);
            break;
            //portal objetivo
            case PORTALOBJETIVO:   g.drawImage(portalObjetivo, x, y, null);
            break;
            //ladron
            case LADRON:   g.drawImage(ladron, x, y, null);
            break;
        }
    }
    
    @Override
    public void paintComponent(Graphics g) 
    {
            update(g);
    }
    
    
    
    public boolean celdaSeleccionada(int xp,int yp) 
    {
        return rectanguloCelda.contains(new Point(xp,yp));
    }
}