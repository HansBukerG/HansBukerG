/* paquetes que utilizaremos */
import java.awt.Canvas;
import java.awt.Color;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.event.InputEvent;
import java.awt.event.KeyEvent;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.util.ArrayList;
import java.util.Timer;


/* la clase Lienzo hereda de Canvas */
public final class Lienzo extends Canvas implements Constantes
{
    
    //para pintar el lienzo
    public Mapa mapa;
    public Cartero cartero;
    public Ladron ladron;
    
    public boolean cartasRobadas= false;
    
    //public Peaton peaton1;
    //public Timer lanzadorTareas;
    public Timer[] lanzadorTareasPeaton = new Timer[CANTIDADPEATONES];
    public Peaton[] peaton = new Peaton[CANTIDADPEATONES];
    
    public Timer[] lanzadorTareasAutomovil = new Timer[CANTIDADVEHICULOS];
    public Automovil[] automovil = new Automovil[CANTIDADVEHICULOS];
    
    public Timer lanzadorMicro;
    public Micro micro1;
    
    public int cantidadDeCartas = CANTIDADCARTAS;
    public int cantidadDePasajeros = CANTIDADPASAJEROS;
    
    
    public char memoria;
    //eliminacion de parpadeo
    public Graphics graficoBuffer;
    public Image imagenBuffer;
    public boolean  bloquearTexto = false, 
                    bloquearDerechaCartero=true,
                    bloquearIzquierdaCartero=false,
                    bloquearArribaCartero= false,
                    bloquearAbajoCartero=false,
            
                    bloquearDerechaBus=true,
                    bloquearIzquierdaBus=false,
                    bloquearArribaBus= false,
                    bloquearAbajoBus=false;
    public String mensaje="";
    
    public int carteroInicialX,carteroInicialY;
    public int posInicialLadronX,posInicialLadronY;
    int contadorCartas=0, remanenteDeCartas=0;
    
    public int anchuraMiniImagen = 16;
    public int alturaMiniImagen = 12;
    public Lienzo()
    {
       
        mapa=new Mapa(this);
        //color de fondo
        this.setBackground(Color.CYAN);
        //dimensiones del lienzo
        this.setSize(mapa.anchuraMapa+70,mapa.alturaMapa+100);
                

              
        //escuchador eventos de teclado  
        addKeyListener(new java.awt.event.KeyAdapter() 
        {
            @Override
            public void keyPressed(KeyEvent e) 
            {
                mapa.moverCelda(e);
                repaint();
            }
        }
        );
        
        /*BEST TRUCO EVER!*/         
        colocarCartero();
        if(ARRANCARDELADRON == true)
            colocarLadron();
        colocarAutomoviles();
        colocarPeatones();
        colocarBus();
        
        
        if(ARRANCARDELADRON ==  true)
        {
            Timer lanzadorTareas1= new Timer();
            lanzadorTareas1.scheduleAtFixedRate(cartero.anchuraMultiInfoLadron, 0, VELOCIDADMUNDO);
            Timer lanzadorTareas = new Timer();
            lanzadorTareas.scheduleAtFixedRate(ladron.anchuraMulti, 0, VELOCIDADMUNDO);
        }
        if(BUSQUEDAMULTIOBJETIVO == true)
        {
            Timer lanzadorTareas2 = new Timer();
            lanzadorTareas2.scheduleAtFixedRate(cartero.anchuraMulti, 0, VELOCIDADMUNDO);
        }
        if(BUSQUEDAINFORMADAMULTIOBJETIVO == true)
        {
            Timer lanzadorTareas3= new Timer();
            lanzadorTareas3.scheduleAtFixedRate(cartero.anchuraMultiInfo, 0, VELOCIDADMUNDO);
        }
        /*if(BUSQUEDAPROFUNDIDADMULTIOBJETIVO == true)
        {
            Timer lanzadorTareas2= new Timer();
            lanzadorTareas2.scheduleAtFixedRate(cartero.profundidadMiltiObjetivo, 0, 500);
        }*/
//Escuchador eventos del mouse
        //mapa.celdas[0][3].preferencia= 10;
        if(MODOMOUSE!=true)
            definirObjetivos();
        else
        {
            addMouseListener(new MouseAdapter() 
            {
                @Override
                public void mouseClicked(MouseEvent evt) 
                {
                    activarCelda(evt);
                    repaint();
                }
            }
            );
        } 
        
        
    }

    public void colocarCartero()
    {
        int i=0, randomX=0,randomY=0;
        do{
            randomX= numeroAleatorio(0, alturaMundoVirtual-1);
            randomY= numeroAleatorio(0, anchuraMundoVirtual-1);
            if(     mapa.celdas[randomX][randomY].tipo != PARED && 
                    mapa.celdas[randomX][randomY].tipo != CARTERO && 
                    mapa.celdas[randomX][randomY].tipo != EDIFICIO && 
                    mapa.celdas[randomX][randomY].tipo != PORTAL && 
                    mapa.celdas[randomX][randomY].tipo != PEATON &&
                    mapa.celdas[randomX][randomY].tipo != CARRETERA
                )
            {
                memoria=mapa.celdas[randomX][randomY].tipo;       
                cartero= new Cartero(randomX,randomY,mapa,0);
                carteroInicialX= randomX;
                carteroInicialY= randomY;
                cartero.memoria=memoria;        
                i++;
            }
        }while(i<1);
    }
    
    public void colocarLadron()
    {
        int i=0, randomX=0,randomY=0;
        do{
            randomX= numeroAleatorio(0, alturaMundoVirtual-1);
            randomY= numeroAleatorio(0, anchuraMundoVirtual-1);
            if(     mapa.celdas[randomX][randomY].tipo != PARED && 
                    mapa.celdas[randomX][randomY].tipo != CARTERO && 
                    mapa.celdas[randomX][randomY].tipo != EDIFICIO && 
                    mapa.celdas[randomX][randomY].tipo != PORTAL && 
                    mapa.celdas[randomX][randomY].tipo != PEATON &&
                    mapa.celdas[randomX][randomY].tipo != CARRETERA &&
                    mapa.celdas[randomX][randomY].tipo != MICRO
                )
            {
                memoria=mapa.celdas[randomX][randomY].tipo;       
                ladron= new Ladron(randomX,randomY,mapa,0);
                posInicialLadronX= randomX;
                posInicialLadronY= randomY;
                ladron.memoria=memoria;        
                i++;
            }
        }while(i<1);
    }
    
    public void colocarPeatones()
    {
        int i=0, randomX=0,randomY=0;
        do{
            randomX= numeroAleatorio(0, alturaMundoVirtual-1);
            randomY= numeroAleatorio(0, anchuraMundoVirtual-1);
            if(     mapa.celdas[randomX][randomY].tipo != PARED && 
                    mapa.celdas[randomX][randomY].tipo != CARTERO && 
                    mapa.celdas[randomX][randomY].tipo != EDIFICIO && 
                    mapa.celdas[randomX][randomY].tipo != PORTAL && 
                    mapa.celdas[randomX][randomY].tipo != PEATON &&
                    mapa.celdas[randomX][randomY].tipo != CARRETERA                     
                    )
            {
                memoria=mapa.celdas[randomX][randomY].tipo;        
                peaton[i] = new Peaton(randomX,randomY,mapa,1);
                peaton[i].memoria=memoria;
                lanzadorTareasPeaton[i]= new Timer();
                lanzadorTareasPeaton[i].scheduleAtFixedRate(peaton[i],0,VELOCIDADMUNDO);         
                i++;
            }
        }while(i<CANTIDADPEATONES);
    }
        public void colocarAutomoviles()
    {
        int i=0, randomX=0,randomY=0;
        do{
            randomX= numeroAleatorio(0, alturaMundoVirtual-1);
            randomY= numeroAleatorio(0, anchuraMundoVirtual-1);
            if(     mapa.celdas[randomX][randomY].tipo != PARED && 
                    mapa.celdas[randomX][randomY].tipo != CARTERO && 
                    mapa.celdas[randomX][randomY].tipo != EDIFICIO && 
                    mapa.celdas[randomX][randomY].tipo != PORTAL && 
                    mapa.celdas[randomX][randomY].tipo != PEATON &&
                    mapa.celdas[randomX][randomY].tipo != CAMINO &&
                    mapa.celdas[randomX][randomY].tipo != PARADA
                    )
            {
                memoria=mapa.celdas[randomX][randomY].tipo;        
                automovil[i] = new Automovil(randomX,randomY,mapa,1);
                automovil[i].memoria=memoria;
                lanzadorTareasAutomovil[i]= new Timer();
                lanzadorTareasAutomovil[i].scheduleAtFixedRate(automovil[i],0,VELOCIDADMUNDO);         
                i++;
            }
        }while(i<CANTIDADVEHICULOS);
    }
    public void colocarBus()
    {
        int i=0,randomX=0,randomY=0;
        do{
        randomX= numeroAleatorio(0, alturaMundoVirtual-1);
        randomY= numeroAleatorio(0, anchuraMundoVirtual-1);
        if(     mapa.celdas[randomX][randomY].tipo != PARED && 
                    mapa.celdas[randomX][randomY].tipo != CARTERO && 
                    mapa.celdas[randomX][randomY].tipo != EDIFICIO && 
                    mapa.celdas[randomX][randomY].tipo != PORTAL && 
                    mapa.celdas[randomX][randomY].tipo != PEATON &&
                    mapa.celdas[randomX][randomY].tipo != CAMINO &&
                    mapa.celdas[randomX][randomY].tipo != AUTOMOVIL &&
                    mapa.celdas[randomX][randomY].tipo != PARADA
                    )
        {
            memoria=mapa.celdas[randomX][randomY].tipo;        
            micro1 = new Micro(randomX,randomY,mapa,1);
            micro1.memoria=memoria;
            lanzadorMicro= new Timer();
            lanzadorMicro.scheduleAtFixedRate(micro1,0,VELOCIDADMUNDO);
            i++;
        }
        }while(i<1);
    }
    
    
    // 2 metodos de interaccion de portal que serviran para escribir el texto deseado cuando se pise el portal.
    public String DesbloqueoDeTexto()
    {
        return mensaje = "Cartero en portal";
    }
    public String BloqueoDeTexto()
    {
        return mensaje = "";
    }
    
    public void iniciarIA(int x, int y, char tipo)
    {
        if(tipo=='A')
        {
            long t1=System.nanoTime();
            cartero.anchuraMultiInfoLadron.destinos.add(new Estado(x,y,'N',null));
            long t2=System.nanoTime();
            double seg=(t2-t1)/1000000000.0;
            System.out.println("Tiempo calculo ruta anchura:"+seg+" seg");
            //System.out.println(buscador.pasos);
        }
        else{
            if(tipo=='P')
            {
                long t1=System.nanoTime();
                
                cartero.anchuraMulti.destinos.add(new Estado(x,y,'N',null));
                long t2=System.nanoTime();
                double seg=(t2-t1)/1000000000.0;
                System.out.println("Tiempo calculo ruta:"+seg+" seg");
            }
            else
            {
                if(tipo== 'K')
                {
                    long t1=System.nanoTime();
                    cartero.anchuraMultiInfo.destinos.add(new Estado(x,y,'N',null));
                    long t2=System.nanoTime();
                    double seg=(t2-t1)/1000000000.0;
                    System.out.println("Tiempo calculo ruta:"+seg+" seg");
                }
            }
        }
    }
        //metodo llamada la primera que se pinta
    @Override
    public void paint(Graphics g) 
    {
        
        update(g);
        
    }
    @Override
    public void update(Graphics g)
    {
        //inicialización del buffer gráfico mediante la imagen
        if(graficoBuffer==null){
            imagenBuffer=createImage(this.getWidth(),this.getHeight());
            graficoBuffer=imagenBuffer.getGraphics();
        }
        //volcamos color de fondo e imagen en el nuevo buffer grafico
        graficoBuffer.setColor(getBackground());
        graficoBuffer.fillRect(0,0,this.getWidth(),this.getHeight());
        mapa.update(graficoBuffer);
        //pintamos la imagen previa
        g.drawImage(imagenBuffer, 0, 0, null);
        g.setFont(FuenteMensajeTipo1);
        if(cantidadDeCartas==0 && cartasRobadas ==false) g.drawString("Cartero en correos. Todas las cartas han sido entregadas.",50,160);
        if(cantidadDeCartas==0 && cartasRobadas ==true) g.drawString("Al cartero le han robado parte o todos sus correos.",50,160);
        g.drawString(mensaje,30,160);
        g.drawString("peat= "+	CUADRANTE01	,	(	1	)*(anchuraCelda+1)	,	(	2	)*(alturaCelda+1));
        g.drawString("peat= "+	CUADRANTE02	,	(	8	)*(anchuraCelda+1)	,	(	2	)*(alturaCelda+1));
        g.drawString("peat= "+	CUADRANTE03	,	(	15	)*(anchuraCelda+1)	,	(	2	)*(alturaCelda+1));
        g.drawString("peat= "+	CUADRANTE04	,	(	22	)*(anchuraCelda+1)	,	(	2	)*(alturaCelda+1));
        g.drawString("peat= "+	CUADRANTE11	,	(	1	)*(anchuraCelda+1)	,	(	8	)*(alturaCelda+1));
        g.drawString("peat= "+	CUADRANTE12	,	(	8	)*(anchuraCelda+1)	,	(	8	)*(alturaCelda+1));
        g.drawString("peat= "+	CUADRANTE13	,	(	15	)*(anchuraCelda+1)	,	(	7	)*(alturaCelda+1));
        g.drawString("peat= "+	CUADRANTE14	,	(	22	)*(anchuraCelda+1)	,	(	8	)*(alturaCelda+1));
        g.drawString("peat= "+	CUADRANTE21	,	(	1	)*(anchuraCelda+1)	,	(	14	)*(alturaCelda+1));
        g.drawString("peat= "+	CUADRANTE22	,	(	8	)*(anchuraCelda+1)	,	(	14	)*(alturaCelda+1));
        g.drawString("peat= "+	CUADRANTE23	,	(	15	)*(anchuraCelda+1)	,	(	14	)*(alturaCelda+1));
        g.drawString("peat= "+	CUADRANTE24	,	(	22	)*(anchuraCelda+1)	,	(	14	)*(alturaCelda+1));
        g.drawString("peat= "+	CUADRANTE31	,	(	1	)*(anchuraCelda+1)	,	(	22	)*(alturaCelda+1));
        g.drawString("peat= "+	CUADRANTE32	,	(	8	)*(anchuraCelda+1)	,	(	21	)*(alturaCelda+1));
        g.drawString("peat= "+	CUADRANTE33	,	(	15	)*(anchuraCelda+1)	,	(	21	)*(alturaCelda+1));
        g.drawString("peat= "+	CUADRANTE34	,	(	22	)*(anchuraCelda+1)	,	(	22	)*(alturaCelda+1));
        for(int i=0;i<28;i++) g.drawString("m"+(i+1)+"= "+mapa.portales[i].toString(),(mapa.portales[i].portal.x	)*(anchuraCelda+1),(mapa.portales[i].portal.y+1	)*(alturaCelda+1));

        //g.drawImage(this.mapa.celdas[0][0].portal,this.cartero.cartero.x*(alturaCelda+1), this.cartero.cartero.y*(anchuraCelda+1),null);
        posicionCartasPeaton(g, this.cartero.cartero.x, this.cartero.cartero.y);
        posicionPasajerosBus(g, this.micro1.micro.x, this.micro1.micro.y);
    }
    
    public void posicionCartasPeaton(Graphics g,int x,int y)
    {
        for(int i=0;i<cantidadDeCartas;i++)
        {        
                
                //if(y+i < alturaMundoVirtual-1)
                if(bloquearArribaCartero== true)
                {
                    g.drawImage(this.mapa.celdas[0][0].minimensaje,(x)*(anchuraCelda+1),(y+1)*(alturaCelda+1)+i*(alturaMiniImagen+1),null);
                    g.drawString(""+(i+1+remanenteDeCartas),(x+1)*(anchuraCelda+1),(y+1)*(alturaCelda+1)+i*(alturaMiniImagen+1));
                }
                //if(y-i > 0)
                if(bloquearAbajoCartero== true)
                {
                    g.drawImage(this.mapa.celdas[0][0].minimensaje,(x)*(anchuraCelda+1),(y-1)*(alturaCelda+1)-i*(alturaMiniImagen+1),null);
                    g.drawString(""+(i+1+remanenteDeCartas),(x-1)*(anchuraCelda+1),(y-1)*(alturaCelda+1)-i*(alturaMiniImagen+1));
                }
                //if(x+i < anchuraMundoVirtual-1)
                if(bloquearIzquierdaCartero== true)
                {
                    g.drawImage(this.mapa.celdas[0][0].minimensaje,(x+1)*(anchuraCelda+1)+i*(anchuraMiniImagen+1),y*(alturaCelda+1),null);
                    g.drawString(""+(i+1+remanenteDeCartas),(x+1)*(anchuraCelda+1)+i*(anchuraMiniImagen+1),y*(alturaCelda+1));
                }
                //if(x-i > 0)
                if(bloquearDerechaCartero== true)
                {
                    g.drawImage(this.mapa.celdas[0][0].minimensaje,(x-1)*(anchuraCelda+1)-i*(anchuraMiniImagen+1),y*(alturaCelda+1),null);
                    g.drawString(""+(i+1+remanenteDeCartas),(x-1)*(anchuraCelda+1)-i*(anchuraMiniImagen+1),y*(alturaCelda+1));
                }
        }
        
    }
    
    public void posicionPasajerosBus(Graphics g,int x,int y)
    {
        for(int i=0;i<cantidadDePasajeros;i++)
        {        
                
                if(y+i < alturaMundoVirtual-1)
                if(bloquearArribaBus== true)
                    g.drawImage(this.mapa.celdas[0][0].peaton,(x)*(anchuraCelda+1),(y+1)*(alturaCelda+1)+i*(alturaCelda+1),null);
                if(y-i > 0)
                if(bloquearAbajoBus== true)
                    g.drawImage(this.mapa.celdas[0][0].peaton,(x)*(anchuraCelda+1),(y-1)*(alturaCelda+1)-i*(alturaCelda+1),null);
                if(x+i < anchuraMundoVirtual-1)
                if(bloquearIzquierdaBus== true)
                    g.drawImage(this.mapa.celdas[0][0].peaton,(x+1)*(anchuraCelda+1)+i*(anchuraCelda+1),y*(alturaCelda+1),null);
                if(x-i > 0)
                if(bloquearDerechaBus== true)
                    g.drawImage(this.mapa.celdas[0][0].peaton,(x-1)*(anchuraCelda+1)-i*(anchuraCelda+1),y*(alturaCelda+1),null);
        }
    }
    
    public void reducirCartas(int n)
    {
        this.cantidadDeCartas-=n;
        this.remanenteDeCartas+=n;
    }
    
    public void reducirPasajeros(int n)
    {
        this.cantidadDePasajeros-=n;
    }
        
    
    
    
    
    
    private void activarCelda(MouseEvent evt) 
{  
    
        for(int i=0; i < anchuraMundoVirtual; i++)
            for ( int j=0 ; j < alturaMundoVirtual ; j++)
            {                       
                if ( mapa.celdas[i][j].celdaSeleccionada(evt.getX(),evt.getY()) ) 
                {
                    //Para saber si se pulso
                    if((evt.getModifiers() & InputEvent.BUTTON1_MASK) == InputEvent.BUTTON1_MASK) 
                    {
                        if(cartero.nohayPared(i, j)){
                            if(mapa.celdas[i][j].tipo==PORTAL)
                            {    
                                if(contadorCartas!=CANTIDADCARTAS)
                                {     
                                    
                                    if(BUSQUEDAINFORMADAMULTIOBJETIVO == true)
                                    {
                                        System.out.println("Boton derecho - Busqueda en anchura informada multiobjetivo");
                                        mapa.celdas[i][j].tipo=PORTALOBJETIVO;
                                        iniciarIA(i, j,'K');
                                        contadorCartas++;
                                    }
                                    if(BUSQUEDAMULTIOBJETIVO == true)
                                    {
                                        System.out.println("Boton derecho - Busqueda en anchura multiobjetivo");
                                        mapa.celdas[i][j].tipo=PORTALOBJETIVO;
                                        iniciarIA(i, j,'P');
                                        contadorCartas++;
                                    }
                                    if(ARRANCARDELADRON == true)
                                    {
                                        System.out.println("Boton derecho - Busqueda en profundidad multiobjetivo");
                                        mapa.celdas[i][j].tipo=PORTALOBJETIVO;
                                        iniciarIA(i, j,'A');
                                        contadorCartas++;
                                    }
                                    
                                }
                                else
                                {
                                    System.out.println("No quedan mas cartas para repartir");
                                }
                            }
                        }
                    }
                }
            }
    }

    private void definirObjetivos() {
        for(int i=0; i<28; i++) 
            if(mapa.portales[i].portalObjetivo())
            {              
                if(contadorCartas!=CANTIDADCARTAS)
                {  
                    if(BUSQUEDAINFORMADAMULTIOBJETIVO == true)
                    {
                        System.out.println("Busqueda en anchura informada multiobjetivo");
                        mapa.celdas[mapa.portales[i].portal.x][mapa.portales[i].portal.y].tipo= PORTALOBJETIVO;
                        iniciarIA(mapa.portales[i].portal.x, mapa.portales[i].portal.y,'K');
                        contadorCartas++;
                    }
                    // esto es para el ladron
                    if(BUSQUEDAMULTIOBJETIVO == true)
                    {
                        System.out.println("Busqueda en anchura multiobjetivo");
                        
                        mapa.celdas[mapa.portales[i].portal.x][mapa.portales[i].portal.y].tipo= PORTALOBJETIVO;
                        iniciarIA(mapa.portales[i].portal.x, mapa.portales[i].portal.y,'P');
                        contadorCartas++;
                    }
                    if(ARRANCARDELADRON == true)
                    {
                        System.out.println("Busqueda en anchura multiobjetivo");
                        
                        mapa.celdas[mapa.portales[i].portal.x][mapa.portales[i].portal.y].tipo= PORTALOBJETIVO;
                        iniciarIA(mapa.portales[i].portal.x, mapa.portales[i].portal.y,'A');
                        contadorCartas++;
                    }
                }
            } 
        
                
    }
}
