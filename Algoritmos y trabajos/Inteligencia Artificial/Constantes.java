
import java.awt.Font;
import java.util.Random;



public interface Constantes 
{
    //Aqui defino la cantidad de pasajeros que tendra el microbus
    public final int CANTIDADPASAJEROS = 3;
    
    //Aqui defino la cantidad de cartas que tendra cada cartero junto a la cantidad de portales que podrian activarse para solicitar cartas
    public final int CANTIDADCARTAS = 10;
    public final int CANTIDADPORTALESACTIVOS = 3;
    
    //Aqui defino la preferencia de la calle, como default tendra valor de 0
    public final int PREFERENCIACALLE = 0;
    
    //De las siguientes 3 variables de constantes, solo una puede estar activa a la vez
    public final boolean ARRANCARDELADRON = true;
    //opcional habilitar heuristica de deteccion de ladron
    public final boolean HEURISTICALADRON = true;
    
    public final boolean BUSQUEDAINFORMADAMULTIOBJETIVO = false;
    public final boolean BUSQUEDAMULTIOBJETIVO = false;
    
    public final int VELOCIDADMUNDO= 300;
    //En esta serie de contantes, defino la cantidad depeatones que habra dentro de cada cuadrante
    
    public final int CUADRANTE01 =100;
    public final int CUADRANTE02 =100;
    public final int CUADRANTE03 =100;
    public final int CUADRANTE04 =100;
    
    public final int CUADRANTE11 =0;
    public final int CUADRANTE12 =0;
    public final int CUADRANTE13 =0;
    public final int CUADRANTE14 =0;
    
    public final int CUADRANTE21 =0;
    public final int CUADRANTE22 =0;
    public final int CUADRANTE23 =0;
    public final int CUADRANTE24 =0;
    
    public final int CUADRANTE31 =0;
    public final int CUADRANTE32 =0;
    public final int CUADRANTE33 =0;
    public final int CUADRANTE34 =0;
    
    
    public final int anchuraCelda=32;
    public final int alturaCelda=32;
    public final int anchuraMundoVirtual=25;
    public final int alturaMundoVirtual=25;
  
    
    
    //Para manejar los tipos de celdas
    
    public final char CAMINO = 'T';
    public final char CARRETERA ='R';
    public final char PARED = 'W';
    public final char PEATON = 'P';
    public final char CARTERO = 'E';
    public final char PORTAL ='C';
    public final char EDIFICIO ='K';
    public final char AUTOMOVIL = 'A';
    public final char CRUCE= 'V';
    public final char MICRO= 'D';
    public final char PARADA= 'L';
    public final char MENSAJE= 'O';
    public final char PORTALOBJETIVO = 'H';
    public final char LADRON = 'G';
    
    //Para manejar los movimientos de celdas
    public final int ARRIBA     =   -1; 
    public final int ABAJO      =   1;
    public final int IZQUIERDA  =   -1;
    public final int DERECHA    =   1;
    
    // Cantidad NPC
    public final int CANTIDADPEATONES = 5;
    public final int CANTIDADVEHICULOS = 5;
    

    

    
    //Esta constante desactiva el funcionamiento por medio del mouse pero activa el funcionamiento por designacion automatica.
    public final boolean MODOMOUSE = false;
    
    
    public final boolean PORTALAUTOMATICO = true;
    //Aqui se definen las variables de cartas y la cantidad de portales activos que podrian solicitar una carta o mas
    
    
        //En esta serie de constantes, defino la cantidad de  mensajes  por la cual estara esperando cada portal
    public	final	int	PORTAL1         =       3	;
    public	final	int	PORTAL2         =       20	;
    public	final	int	PORTAL3         =       0	;
    public	final	int	PORTAL4         =       1	;
    public	final	int	PORTAL5         =       1	;
    public	final	int	PORTAL6         =       0	;
    public	final	int	PORTAL7         =   	0       ;  
    public	final	int	PORTAL8         =       0	;
    public	final	int	PORTAL9         =       0	;
    public	final	int	PORTAL10	=	0	;
    public	final	int	PORTAL11	=	0	;
    public	final	int	PORTAL12	=	0	;
    public	final	int	PORTAL13	=	0	;
    public	final	int	PORTAL14	=	10	;
    public	final	int	PORTAL15	=	0	;
    public	final	int	PORTAL16	=	0	;
    public	final	int	PORTAL17	=	0	;
    public	final	int	PORTAL18	=	0	;
    public	final	int	PORTAL19	=	0	;
    public	final	int	PORTAL20	=	0	;
    public	final	int	PORTAL21	=	0	;
    public	final	int	PORTAL22	=	0	;
    public	final	int	PORTAL23	=	0	;
    public	final	int	PORTAL24	=	0	;
    public	final	int	PORTAL25	=	0	;
    public	final	int	PORTAL26	=	0	;
    public	final	int	PORTAL27	=	0	;
    public	final	int	PORTAL28	=	0	;
    
        
    
    
    
    
    


    
    
    default int numeroAleatorio(int minimo, int maximo) {
        Random random = new Random();
        int numero_aleatorio = random.nextInt ((maximo - minimo) + 1) + minimo;
        return numero_aleatorio;
    }

    public final Font FuenteMensajeTipo1 = new Font("Times New Roman",Font.BOLD,23);
    // para la ventana del menu inicial
    public int ANCHURA_VENTANA=800;
    public int ALTURA_VENTANA=600;
}