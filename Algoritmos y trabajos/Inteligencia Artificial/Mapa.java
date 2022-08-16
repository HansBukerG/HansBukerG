import java.awt.Graphics;
import java.awt.event.KeyEvent;
import javax.swing.JComponent;

public class Mapa extends JComponent implements Constantes 
{
    public int anchuraMapa,alturaMapa;//dimensiones del laberinto
    public Celda[][] celdas;//las casillas n x m
    //public Celda celdaMovimiento;
    public Lienzo lienzoPadre;
    public Portal[] portales= new  Portal[28];


    public Mapa(Lienzo lienzoPadre) 
    {
        this.lienzoPadre=lienzoPadre;
        
        celdas= new Celda[anchuraMundoVirtual][alturaMundoVirtual];
        //inicializar el array de celdas
        this.llenarMapa();     
        //ancho y largo del laberinto
        this.crearCiudad();
        
        this.definirDimensionDeMapa();
        this.ponerParadas();
        
        
        
        
        this.	cuadrante01	(	CUADRANTE01	);
        this.	cuadrante02	(	CUADRANTE02	);
        this.	cuadrante03	(	CUADRANTE03	);
        this.	cuadrante04	(	CUADRANTE04	);
        this.	cuadrante11	(	CUADRANTE11	);
        this.	cuadrante12	(	CUADRANTE12	);
        this.	cuadrante13	(	CUADRANTE13	);
        this.	cuadrante14	(	CUADRANTE14	);
        this.	cuadrante21	(	CUADRANTE21	);
        this.	cuadrante22	(	CUADRANTE22	);
        this.	cuadrante23	(	CUADRANTE23	);
        this.	cuadrante24	(	CUADRANTE24	);
        this.	cuadrante31	(	CUADRANTE31	);
        this.	cuadrante32	(	CUADRANTE32	);
        this.	cuadrante33	(	CUADRANTE33	);
        this.	cuadrante34	(	CUADRANTE34	);

        if(PORTALAUTOMATICO == true)
        {
            asignarCartas(CANTIDADCARTAS,CANTIDADPORTALESACTIVOS);
        }
        
    }
    
    
    public void llenarMapa(){
        for(int i=0; i < anchuraMundoVirtual; i++)
            for ( int j=0 ; j < alturaMundoVirtual ; j++)
            {
                celdas[i][j]=new Celda(i+(i*anchuraCelda),j+(j*alturaCelda),CARRETERA);
                celdas[i][j].prioridad= PREFERENCIACALLE;
            }
    }
    
    public void crearCiudad()
    {
        // Creando el mapa con objetos del tipo edificio, pared y portal
        celdas[	1	][	1	].tipo=	EDIFICIO	;
        celdas[	2	][	1	].tipo=	EDIFICIO	;
        celdas[	7	][	1	].tipo=	PARED	;
        celdas[	8	][	1	].tipo=	EDIFICIO	;
        celdas[	9	][	1	].tipo=	EDIFICIO	;
        celdas[	14	][	1	].tipo=	EDIFICIO	;
        celdas[	15	][	1	].tipo=	EDIFICIO	;
        celdas[	16	][	1	].tipo=	EDIFICIO	;
        celdas[	21	][	1	].tipo=	EDIFICIO	;
        celdas[	22	][	1	].tipo=	EDIFICIO	;
        celdas[	23	][	1	].tipo=	EDIFICIO	;
        
        
        celdas[	1	][	2	].tipo=	PARED	;
        portales[0]= new Portal(2,2,this,PORTAL1);
        celdas[	7	][	2	].tipo=	PARED	;
        portales[1]= new Portal(8,2,this,PORTAL2);
        celdas[	9	][	2	].tipo=	EDIFICIO	;
        celdas[	14	][	2	].tipo=	PARED	;
        portales[2]= new Portal(15,2,this,PORTAL3);
        celdas[	16	][	2	].tipo=	PARED	;
        celdas[	21	][	2	].tipo=	EDIFICIO	;
        portales[3]= new Portal(22,2,this,PORTAL4);
        celdas[	23	][	2	].tipo=	EDIFICIO	;
        
        celdas[	1	][	7	].tipo=	EDIFICIO	;
        celdas[	2	][	7	].tipo=	EDIFICIO	;
        celdas[	7	][	7	].tipo=	PARED	;
        celdas[	8	][	7	].tipo=	PARED	;
        celdas[	9	][	7	].tipo=	PARED	;
        celdas[	14	][	7	].tipo=	PARED	;
        portales[4]= new Portal(15,7,this,PORTAL5);
        celdas[	16	][	7	].tipo=	EDIFICIO	;
        celdas[	21	][	7	].tipo=	EDIFICIO	;
        celdas[	22	][	7	].tipo=	EDIFICIO	;
        celdas[	23	][	7	].tipo=	PARED	;
        
        celdas[	1	][	8	].tipo=	EDIFICIO	;
        portales[5]= new Portal(2,8,this,PORTAL6);
        portales[6]= new Portal(7,8,this,PORTAL7);
        celdas[	8	][	8	].tipo=	EDIFICIO	;
        portales[7]= new Portal(9,8,this,PORTAL8);
        celdas[	14	][	8	].tipo=	PARED	;
        celdas[	15	][	8	].tipo=	EDIFICIO	;
        portales[8]= new Portal(16,8,this,PORTAL9);
        portales[9]= new Portal(21,8,this,PORTAL10);
        celdas[	22	][	8	].tipo=	EDIFICIO	;
        celdas[	23	][	8	].tipo=	PARED	;
        
        celdas[	1	][	9	].tipo=	EDIFICIO	;
        celdas[	2	][	9	].tipo=	EDIFICIO	;
        celdas[	7	][	9	].tipo=	EDIFICIO	;
        portales[10]= new Portal(8,9,this,PORTAL11);
        celdas[	9	][	9	].tipo=	EDIFICIO	;
        celdas[	14	][	9	].tipo=	PARED	;
        celdas[	15	][	9	].tipo=	PARED	;
        celdas[	16	][	9	].tipo=	PARED	;
        celdas[	21	][	9	].tipo=	EDIFICIO	;
        celdas[	22	][	9	].tipo=	EDIFICIO	;
        celdas[	23	][	9	].tipo=	PARED	;
        
        portales[11]= new Portal(1,14,this,PORTAL12);
        celdas[	2	][	14	].tipo=	EDIFICIO	;
        celdas[	7	][	14	].tipo=	PARED	;
        celdas[	8	][	14	].tipo=	PARED	;
        celdas[	9	][	14	].tipo=	PARED	;
        celdas[	14	][	14	].tipo=	PARED	;
        celdas[	15	][	14	].tipo=	PARED	;
        celdas[	16	][	14	].tipo=	PARED	;
        celdas[	21	][	14	].tipo=	EDIFICIO	;
        celdas[	22	][	14	].tipo=	EDIFICIO	;
        celdas[	23	][	14	].tipo=	PARED	;
        
        celdas[	1	][	15	].tipo=	EDIFICIO	;
        portales[12]= new Portal(2,15,this,PORTAL13);
        portales[13]= new Portal(7,15,this,PORTAL14);
        celdas[	8	][	15	].tipo=	EDIFICIO	;
        celdas[	9	][	15	].tipo=	PARED	;
        portales[14]= new Portal(14,15,this,PORTAL15);
        celdas[	15	][	15	].tipo=	EDIFICIO	;
        portales[15]= new Portal(16,15,this,PORTAL16);
        portales[16]= new Portal(21,15,this,PORTAL17);
        celdas[	22	][	15	].tipo=	EDIFICIO	;
        celdas[	23	][	15	].tipo=	PARED	;
        
        portales[17]= new Portal(1,16,this,PORTAL18);
        celdas[	2	][	16	].tipo=	EDIFICIO	;
        celdas[	7	][	16	].tipo=	EDIFICIO	;
        portales[18]= new Portal(8,16,this,PORTAL19);
        celdas[	9	][	16	].tipo=	PARED	;
        celdas[	14	][	16	].tipo=	EDIFICIO	;
        portales[19]= new Portal(15,16,this,PORTAL20);
        celdas[	16	][	16	].tipo=	EDIFICIO	;
        celdas[	21	][	16	].tipo=	EDIFICIO	;
        celdas[	22	][	16	].tipo=	EDIFICIO	;
        celdas[	23	][	16	].tipo=	PARED	;
        
        celdas[	1	][	21	].tipo=	EDIFICIO	;
        celdas[	2	][	21	].tipo=	EDIFICIO	;
        celdas[	7	][	21	].tipo=	EDIFICIO	;
        portales[20]= new Portal(8,21,this,PORTAL21);
        celdas[	9	][	21	].tipo=	EDIFICIO	;
        celdas[	14	][	21	].tipo=	EDIFICIO	;
        portales[21]= new Portal(15,21,this,PORTAL22);
        celdas[	16	][	21	].tipo=	EDIFICIO	;
        celdas[	21	][	21	].tipo=	EDIFICIO	;
        celdas[	22	][	21	].tipo=	EDIFICIO	;
        celdas[	23	][	21	].tipo=	PARED	;
        
        celdas[	1	][	22	].tipo=	EDIFICIO	;
        portales[22]= new Portal(2,22,this,PORTAL23);
        portales[23]= new Portal(7,22,this,PORTAL24);
        celdas[	8	][	22	].tipo=	EDIFICIO	;
        portales[24]= new Portal(9,22,this,PORTAL25);
        portales[25]= new Portal(14,22,this,PORTAL26);
        celdas[	15	][	22	].tipo=	EDIFICIO	;
        portales[26]= new Portal(16,22,this,PORTAL27);
        portales[27]= new Portal(21,22,this,PORTAL28);
        celdas[	22	][	22	].tipo=	EDIFICIO	;
        celdas[	23	][	22	].tipo=	PARED	;
        
        celdas[	1	][	23	].tipo=	EDIFICIO	;
        celdas[	2	][	23	].tipo=	EDIFICIO	;
        celdas[	7	][	23	].tipo=	PARED	;
        celdas[	8	][	23	].tipo=	PARED	;
        celdas[	9	][	23	].tipo=	PARED	;
        celdas[	14	][	23	].tipo=	PARED	;
        celdas[	15	][	23	].tipo=	PARED	;
        celdas[	16	][	23	].tipo=	PARED	;
        celdas[	21	][	23	].tipo=	PARED	;
        celdas[	22	][	23	].tipo=	PARED	;
        celdas[	23	][	23	].tipo=	PARED	;
       
        
        
        
        //Columnas de caminos
         for(int i=0; i < 3; i++) celdas[0][i].tipo=CAMINO;
         for(int i=6; i < 10; i++) celdas[0][i].tipo=CAMINO;
         for(int i=13; i < 17; i++) celdas[0][i].tipo=CAMINO;
         for(int i=20; i < 25; i++) celdas[0][i].tipo=CAMINO;
         
         for(int i=0; i < 3; i++) celdas[3][i].tipo=CAMINO;
         for(int i=6; i < 10; i++) celdas[3][i].tipo=CAMINO;
         for(int i=13; i < 17; i++) celdas[3][i].tipo=CAMINO;
         for(int i=20; i < 25; i++) celdas[3][i].tipo=CAMINO;
         
         for(int i=0; i < 3; i++) celdas[6][i].tipo=CAMINO;
         for(int i=6; i < 10; i++) celdas[6][i].tipo=CAMINO;
         for(int i=13; i < 17; i++) celdas[6][i].tipo=CAMINO;
         for(int i=20; i < 25; i++) celdas[6][i].tipo=CAMINO;
         
         for(int i=0; i < 3; i++) celdas[10][i].tipo=CAMINO;
         for(int i=6; i < 10; i++) celdas[10][i].tipo=CAMINO;
         for(int i=13; i < 17; i++) celdas[10][i].tipo=CAMINO;
         for(int i=20; i < 25; i++) celdas[10][i].tipo=CAMINO;
         
         for(int i=0; i < 3; i++) celdas[13][i].tipo=CAMINO;
         for(int i=6; i < 10; i++) celdas[13][i].tipo=CAMINO;
         for(int i=13; i < 17; i++) celdas[13][i].tipo=CAMINO;
         for(int i=20; i < 25; i++) celdas[13][i].tipo=CAMINO;
         
         for(int i=0; i < 3; i++) celdas[17][i].tipo=CAMINO;
         for(int i=6; i < 10; i++) celdas[17][i].tipo=CAMINO;
         for(int i=13; i < 17; i++) celdas[17][i].tipo=CAMINO;
         for(int i=20; i < 25; i++) celdas[17][i].tipo=CAMINO;
         
         for(int i=0; i < 3; i++) celdas[20][i].tipo=CAMINO;
         for(int i=6; i < 10; i++) celdas[20][i].tipo=CAMINO;
         for(int i=13; i < 17; i++) celdas[20][i].tipo=CAMINO;
         for(int i=20; i < 25; i++) celdas[20][i].tipo=CAMINO;
         
         for(int i=0; i < 3; i++) celdas[24][i].tipo=CAMINO;
         for(int i=6; i < 10; i++) celdas[24][i].tipo=CAMINO;
         for(int i=13; i < 17; i++) celdas[24][i].tipo=CAMINO;
         for(int i=20; i < 25; i++) celdas[24][i].tipo=CAMINO;
        
        //Filas de caminos
         for(int i=0; i < 3; i++) celdas[i][0].tipo=CAMINO;
         for(int i=6; i < 10; i++) celdas[i][0].tipo=CAMINO;
         for(int i=13; i < 17; i++) celdas[i][0].tipo=CAMINO;
         for(int i=20; i < 25; i++) celdas[i][0].tipo=CAMINO;
         
         for(int i=0; i < 4; i++) celdas[i][3].tipo=CAMINO;
         for(int i=6; i < 11; i++) celdas[i][3].tipo=CAMINO;
         for(int i=13; i < 18; i++) celdas[i][3].tipo=CAMINO;
         for(int i=20; i < 25; i++) celdas[i][3].tipo=CAMINO;
         
         for(int i=0; i < 4; i++) celdas[i][6].tipo=CAMINO;
         for(int i=6; i < 11; i++) celdas[i][6].tipo=CAMINO;
         for(int i=13; i < 18; i++) celdas[i][6].tipo=CAMINO;
         for(int i=20; i < 25; i++) celdas[i][6].tipo=CAMINO;
         
         for(int i=0; i < 4; i++) celdas[i][10].tipo=CAMINO;
         for(int i=6; i < 11; i++) celdas[i][10].tipo=CAMINO;
         for(int i=13; i < 18; i++) celdas[i][10].tipo=CAMINO;
         for(int i=20; i < 25; i++) celdas[i][10].tipo=CAMINO;
         
         for(int i=0; i < 4; i++) celdas[i][13].tipo=CAMINO;
         for(int i=6; i < 11; i++) celdas[i][13].tipo=CAMINO;
         for(int i=13; i < 18; i++) celdas[i][13].tipo=CAMINO;
         for(int i=20; i < 25; i++) celdas[i][13].tipo=CAMINO;
         
         for(int i=0; i < 4; i++) celdas[i][17].tipo=CAMINO;
         for(int i=6; i < 11; i++) celdas[i][17].tipo=CAMINO;
         for(int i=13; i < 18; i++) celdas[i][17].tipo=CAMINO;
         for(int i=20; i < 25; i++) celdas[i][17].tipo=CAMINO;
         
         for(int i=0; i < 4; i++) celdas[i][20].tipo=CAMINO;
         for(int i=6; i < 11; i++) celdas[i][20].tipo=CAMINO;
         for(int i=13; i < 18; i++) celdas[i][20].tipo=CAMINO;
         for(int i=20; i < 25; i++) celdas[i][20].tipo=CAMINO;
         
         for(int i=0; i < 4; i++) celdas[i][24].tipo=CAMINO;
         for(int i=6; i < 11; i++) celdas[i][24].tipo=CAMINO;
         for(int i=13; i < 18; i++) celdas[i][24].tipo=CAMINO;
         for(int i=20; i < 25; i++) celdas[i][24].tipo=CAMINO;

        //colocando cruces
        celdas[	4	][	0	]. tipo= CRUCE;
        celdas[	5	][	0	]. tipo= CRUCE;
        celdas[	11	][	0	]. tipo= CRUCE;
        celdas[	12	][	0	]. tipo= CRUCE;
        celdas[	18	][	0	]. tipo= CRUCE;
        celdas[	19	][	0	]. tipo= CRUCE;
        celdas[	4	][	3	]. tipo= CRUCE;
        celdas[	5	][	3	]. tipo= CRUCE;
        celdas[	11	][	3	]. tipo= CRUCE;
        celdas[	12	][	3	]. tipo= CRUCE;
        celdas[	18	][	3	]. tipo= CRUCE;
        celdas[	19	][	3	]. tipo= CRUCE;
        celdas[	4	][	6	]. tipo= CRUCE;
        celdas[	5	][	6	]. tipo= CRUCE;
        celdas[	11	][	6	]. tipo= CRUCE;
        celdas[	12	][	6	]. tipo= CRUCE;
        celdas[	18	][	6	]. tipo= CRUCE;
        celdas[	19	][	6	]. tipo= CRUCE;
        celdas[	4	][	10	]. tipo= CRUCE;
        celdas[	5	][	10	]. tipo= CRUCE;
        celdas[	11	][	10	]. tipo= CRUCE;
        celdas[	12	][	10	]. tipo= CRUCE;
        celdas[	18	][	10	]. tipo= CRUCE;
        celdas[	19	][	10	]. tipo= CRUCE;
        celdas[	4	][	13	]. tipo= CRUCE;
        celdas[	5	][	13	]. tipo= CRUCE;
        celdas[	11	][	13	]. tipo= CRUCE;
        celdas[	12	][	13	]. tipo= CRUCE;
        celdas[	18	][	13	]. tipo= CRUCE;
        celdas[	19	][	13	]. tipo= CRUCE;
        celdas[	4	][	17	]. tipo= CRUCE;
        celdas[	5	][	17	]. tipo= CRUCE;
        celdas[	11	][	17	]. tipo= CRUCE;
        celdas[	12	][	17	]. tipo= CRUCE;
        celdas[	18	][	17	]. tipo= CRUCE;
        celdas[	19	][	17	]. tipo= CRUCE;
        celdas[	4	][	20	]. tipo= CRUCE;
        celdas[	5	][	20	]. tipo= CRUCE;
        celdas[	11	][	20	]. tipo= CRUCE;
        celdas[	12	][	20	]. tipo= CRUCE;
        celdas[	18	][	20	]. tipo= CRUCE;
        celdas[	19	][	20	]. tipo= CRUCE;
        celdas[	4	][	24	]. tipo= CRUCE;
        celdas[	5	][	24	]. tipo= CRUCE;
        celdas[	11	][	24	]. tipo= CRUCE;
        celdas[	12	][	24	]. tipo= CRUCE;
        celdas[	18	][	24	]. tipo= CRUCE;
        celdas[	19	][	24	]. tipo= CRUCE; 

        celdas[	0	][	4	]. tipo= CRUCE;
        celdas[	0	][	5	]. tipo= CRUCE;
        celdas[	0	][	11	]. tipo= CRUCE;
        celdas[	0	][	12	]. tipo= CRUCE;
        celdas[	0	][	18	]. tipo= CRUCE;
        celdas[	0	][	19	]. tipo= CRUCE;
        celdas[	3	][	4	]. tipo= CRUCE;
        celdas[	3	][	5	]. tipo= CRUCE;
        celdas[	3	][	11	]. tipo= CRUCE;
        celdas[	3	][	12	]. tipo= CRUCE;
        celdas[	3	][	18	]. tipo= CRUCE;
        celdas[	3	][	19	]. tipo= CRUCE;
        celdas[	6	][	4	]. tipo= CRUCE;
        celdas[	6	][	5	]. tipo= CRUCE;
        celdas[	6	][	11	]. tipo= CRUCE;
        celdas[	6	][	12	]. tipo= CRUCE;
        celdas[	6	][	18	]. tipo= CRUCE;
        celdas[	6	][	19	]. tipo= CRUCE;
        celdas[	10	][	4	]. tipo= CRUCE;
        celdas[	10	][	5	]. tipo= CRUCE;
        celdas[	10	][	11	]. tipo= CRUCE;
        celdas[	10	][	12	]. tipo= CRUCE;
        celdas[	10	][	18	]. tipo= CRUCE;
        celdas[	10	][	19	]. tipo= CRUCE;
        celdas[	13	][	4	]. tipo= CRUCE;
        celdas[	13	][	5	]. tipo= CRUCE;
        celdas[	13	][	11	]. tipo= CRUCE;
        celdas[	13	][	12	]. tipo= CRUCE;
        celdas[	13	][	18	]. tipo= CRUCE;
        celdas[	13	][	19	]. tipo= CRUCE;
        celdas[	17	][	4	]. tipo= CRUCE;
        celdas[	17	][	5	]. tipo= CRUCE;
        celdas[	17	][	11	]. tipo= CRUCE;
        celdas[	17	][	12	]. tipo= CRUCE;
        celdas[	17	][	18	]. tipo= CRUCE;
        celdas[	17	][	19	]. tipo= CRUCE;
        celdas[	20	][	4	]. tipo= CRUCE;
        celdas[	20	][	5	]. tipo= CRUCE;
        celdas[	20	][	11	]. tipo= CRUCE;
        celdas[	20	][	12	]. tipo= CRUCE;
        celdas[	20	][	18	]. tipo= CRUCE;
        celdas[	20	][	19	]. tipo= CRUCE;
        celdas[	24	][	4	]. tipo= CRUCE;
        celdas[	24	][	5	]. tipo= CRUCE;
        celdas[	24	][	11	]. tipo= CRUCE;
        celdas[	24	][	12	]. tipo= CRUCE;
        celdas[	24	][	18	]. tipo= CRUCE;
        celdas[	24	][	19	]. tipo= CRUCE;
        
        celdas[	4	][	0	].	prioridad=	0;
        celdas[	5	][	0	].	prioridad=	0;
        celdas[	11	][	0	].	prioridad=	0;
        celdas[	12	][	0	].	prioridad=	0;
        celdas[	18	][	0	].	prioridad=	0;
        celdas[	19	][	0	].	prioridad=	0;
        celdas[	4	][	3	].	prioridad=	0;
        celdas[	5	][	3	].	prioridad=	0;
        celdas[	11	][	3	].	prioridad=	0;
        celdas[	12	][	3	].	prioridad=	0;
        celdas[	18	][	3	].	prioridad=	0;
        celdas[	19	][	3	].	prioridad=	0;
        celdas[	4	][	6	].	prioridad=	0;
        celdas[	5	][	6	].	prioridad=	0;
        celdas[	11	][	6	].	prioridad=	0;
        celdas[	12	][	6	].	prioridad=	0;
        celdas[	18	][	6	].	prioridad=	0;
        celdas[	19	][	6	].	prioridad=	0;
        celdas[	4	][	10	].	prioridad=	0;
        celdas[	5	][	10	].	prioridad=	0;
        celdas[	11	][	10	].	prioridad=	0;
        celdas[	12	][	10	].	prioridad=	0;
        celdas[	18	][	10	].	prioridad=	0;
        celdas[	19	][	10	].	prioridad=	0;
        celdas[	4	][	13	].	prioridad=	0;
        celdas[	5	][	13	].	prioridad=	0;
        celdas[	11	][	13	].	prioridad=	0;
        celdas[	12	][	13	].	prioridad=	0;
        celdas[	18	][	13	].	prioridad=	0;
        celdas[	19	][	13	].	prioridad=	0;
        celdas[	4	][	17	].	prioridad=	0;
        celdas[	5	][	17	].	prioridad=	0;
        celdas[	11	][	17	].	prioridad=	0;
        celdas[	12	][	17	].	prioridad=	0;
        celdas[	18	][	17	].	prioridad=	0;
        celdas[	19	][	17	].	prioridad=	0;
        celdas[	4	][	20	].	prioridad=	0;
        celdas[	5	][	20	].	prioridad=	0;
        celdas[	11	][	20	].	prioridad=	0;
        celdas[	12	][	20	].	prioridad=	0;
        celdas[	18	][	20	].	prioridad=	0;
        celdas[	19	][	20	].	prioridad=	0;
        celdas[	4	][	24	].	prioridad=	0;
        celdas[	5	][	24	].	prioridad=	0;
        celdas[	11	][	24	].	prioridad=	0;
        celdas[	12	][	24	].	prioridad=	0;
        celdas[	18	][	24	].	prioridad=	0;
        celdas[	19	][	24	].	prioridad=	0;
        celdas[	0	][	4	].	prioridad=	0;
        celdas[	0	][	5	].	prioridad=	0;
        celdas[	0	][	11	].	prioridad=	0;
        celdas[	0	][	12	].	prioridad=	0;
        celdas[	0	][	18	].	prioridad=	0;
        celdas[	0	][	19	].	prioridad=	0;
        celdas[	3	][	4	].	prioridad=	0;
        celdas[	3	][	5	].	prioridad=	0;
        celdas[	3	][	11	].	prioridad=	0;
        celdas[	3	][	12	].	prioridad=	0;
        celdas[	3	][	18	].	prioridad=	0;
        celdas[	3	][	19	].	prioridad=	0;
        celdas[	6	][	4	].	prioridad=	0;
        celdas[	6	][	5	].	prioridad=	0;
        celdas[	6	][	11	].	prioridad=	0;
        celdas[	6	][	12	].	prioridad=	0;
        celdas[	6	][	18	].	prioridad=	0;
        celdas[	6	][	19	].	prioridad=	0;
        celdas[	10	][	4	].	prioridad=	0;
        celdas[	10	][	5	].	prioridad=	0;
        celdas[	10	][	11	].	prioridad=	0;
        celdas[	10	][	12	].	prioridad=	0;
        celdas[	10	][	18	].	prioridad=	0;
        celdas[	10	][	19	].	prioridad=	0;
        celdas[	13	][	4	].	prioridad=	0;
        celdas[	13	][	5	].	prioridad=	0;
        celdas[	13	][	11	].	prioridad=	0;
        celdas[	13	][	12	].	prioridad=	0;
        celdas[	13	][	18	].	prioridad=	0;
        celdas[	13	][	19	].	prioridad=	0;
        celdas[	17	][	4	].	prioridad=	0;
        celdas[	17	][	5	].	prioridad=	0;
        celdas[	17	][	11	].	prioridad=	0;
        celdas[	17	][	12	].	prioridad=	0;
        celdas[	17	][	18	].	prioridad=	0;
        celdas[	17	][	19	].	prioridad=	0;
        celdas[	20	][	4	].	prioridad=	0;
        celdas[	20	][	5	].	prioridad=	0;
        celdas[	20	][	11	].	prioridad=	0;
        celdas[	20	][	12	].	prioridad=	0;
        celdas[	20	][	18	].	prioridad=	0;
        celdas[	20	][	19	].	prioridad=	0;
        celdas[	24	][	4	].	prioridad=	0;
        celdas[	24	][	5	].	prioridad=	0;
        celdas[	24	][	11	].	prioridad=	0;
        celdas[	24	][	12	].	prioridad=	0;
        celdas[	24	][	18	].	prioridad=	0;
        celdas[	24	][	19	].	prioridad=	0;

    }
    
    public void ponerParadas()
    {
        celdas[	8	][	3	].tipo=PARADA;
        celdas[	15	][	3	].tipo=PARADA;
        celdas[	22	][	3	].tipo=PARADA;
        celdas[	8	][	6	].tipo=PARADA;
        celdas[	15	][	6	].tipo=PARADA;
        celdas[	22	][	6	].tipo=PARADA;
        
        celdas[	8	][	10	].tipo=PARADA;
        celdas[	15	][	10	].tipo=PARADA;
        celdas[	22	][	10	].tipo=PARADA;
        celdas[	8	][	13	].tipo=PARADA;
        celdas[	15	][	13	].tipo=PARADA;
        celdas[	22	][	13	].tipo=PARADA;
        
        celdas[	8	][	17	].tipo=PARADA;
        celdas[	15	][	17	].tipo=PARADA;
        celdas[	22	][	17	].tipo=PARADA;
        celdas[	8	][	20	].tipo=PARADA;
        celdas[	15	][	20	].tipo=PARADA;
        celdas[	22	][	20	].tipo=PARADA;
        
        celdas[	3	][	8	].tipo=PARADA;
        celdas[	3	][	15	].tipo=PARADA;
        celdas[	3	][	22	].tipo=PARADA;
        celdas[	6	][	8	].tipo=PARADA;
        celdas[	6	][	15	].tipo=PARADA;
        celdas[	6	][	22	].tipo=PARADA;
        
        celdas[	10	][	8	].tipo=PARADA;
        celdas[	10	][	15	].tipo=PARADA;
        celdas[	10	][	22	].tipo=PARADA;
        celdas[	13	][	8	].tipo=PARADA;
        celdas[	13	][	15	].tipo=PARADA;
        celdas[	13	][	22	].tipo=PARADA;
        
        celdas[	17	][	8	].tipo=PARADA;
        celdas[	17	][	15	].tipo=PARADA;
        celdas[	17	][	22	].tipo=PARADA;
        celdas[	20	][	8	].tipo=PARADA;
        celdas[	20	][	15	].tipo=PARADA;
        celdas[	20	][	22	].tipo=PARADA;
        
    }
    
    
    public void definirDimensionDeMapa(){
        this.anchuraMapa=anchuraMundoVirtual*anchuraCelda;
        this.alturaMapa=alturaMundoVirtual*alturaCelda;
        this.setSize(anchuraMapa,alturaMapa); 
    }
    
    
    @Override
    public void paintComponent(Graphics g) 
    {
           update(g);
    }
    
    @Override
    public void update(Graphics g)
    {
                for(int i=0; i < anchuraMundoVirtual ; i++)
                    for ( int j=0 ; j < alturaMundoVirtual; j++)
                        celdas[i][j].paintComponent(g);
    }
    
    public void moverCelda( KeyEvent evento ) 
    {
        switch( evento.getKeyCode() ) 
        {
            case KeyEvent.VK_W:
            System.out.println("Mover arriba");
            lienzoPadre.cartero.moverCeldaArriba();
            break;
            case KeyEvent.VK_S:
            System.out.println("Mover abajo");
            lienzoPadre.cartero.moverCeldaAbajo();
            break;
            case KeyEvent.VK_A:
            System.out.println("Mover izquierda");
            lienzoPadre.cartero.moverCeldaIzquierda();
            break;
            case KeyEvent.VK_D:
            System.out.println("Mover derecha");
            lienzoPadre.cartero.moverCeldaDerecha();
            break;
        }
    }

    public void cuadrante01(int CUADRANTE01) {
        int i;
        for(i=0;i<3;i++) 
        {
            celdas[i][0].prioridad=CUADRANTE01;
            celdas[i][3].prioridad=CUADRANTE01;
            
            celdas[0][i].prioridad=CUADRANTE01;
            celdas[3][i].prioridad=CUADRANTE01;
        }
    }

    public void cuadrante02(int CUADRANTE02) {
        int i;
        for(i=6;i<10;i++) 
        {
            celdas[i][0].prioridad=CUADRANTE02;
            celdas[i][3].prioridad=CUADRANTE02;
        }
        for(i=0;i<3;i++) 
        {
            celdas[6][i].prioridad=CUADRANTE02;
            celdas[10][i].prioridad=CUADRANTE02;
        }
    }

    public void cuadrante03(int CUADRANTE03) {
        int i;
        for(i=13;i<17;i++) 
        {
            celdas[i][0].prioridad=CUADRANTE03;
            celdas[i][3].prioridad=CUADRANTE03;
        }
        for(i=0;i<3;i++) 
        {
            celdas[13][i].prioridad=CUADRANTE03;
            celdas[17][i].prioridad=CUADRANTE03;
        }
    }

    public void cuadrante04(int CUADRANTE04) {
        int i;
        for(i=20;i<24;i++) 
        {
            celdas[i][0].prioridad=CUADRANTE04;
            celdas[i][3].prioridad=CUADRANTE04;
        }
        for(i=0;i<3;i++) 
        {
            celdas[20][i].prioridad=CUADRANTE04;
            celdas[24][i].prioridad=CUADRANTE04;
        }
    }

    public void cuadrante11(int CUADRANTE11) {
        int i;
        for(i=0;i<3;i++) 
        {
            celdas[i][6].prioridad=CUADRANTE11;
            celdas[i][10].prioridad=CUADRANTE11;
        }
        for(i=6;i<10;i++) 
        {
            celdas[0][i].prioridad=CUADRANTE11;
            celdas[3][i].prioridad=CUADRANTE11;
        }
    }

    public void cuadrante12(int CUADRANTE12) {
        int i;
        for(i=6;i<10;i++) 
        {
            celdas[i][6].prioridad=CUADRANTE12;
            celdas[i][10].prioridad=CUADRANTE12;
        }
        for(i=6;i<10;i++) 
        {
            celdas[6][i].prioridad=CUADRANTE12;
            celdas[10][i].prioridad=CUADRANTE12;
        }
    }

    public void cuadrante13(int CUADRANTE13) {
        int i;
        for(i=13;i<17;i++) 
        {
            celdas[i][6].prioridad=CUADRANTE13;
            celdas[i][10].prioridad=CUADRANTE13;
        }
        for(i=6;i<10;i++) 
        {
            celdas[13][i].prioridad=CUADRANTE13;
            celdas[17][i].prioridad=CUADRANTE13;
        }
    }

    public void cuadrante14(int CUADRANTE14) {
        int i;
        for(i=20;i<24;i++) 
        {
            celdas[i][6].prioridad=CUADRANTE14;
            celdas[i][10].prioridad=CUADRANTE14;
        }
        for(i=6;i<10;i++) 
        {
            celdas[20][i].prioridad=CUADRANTE14;
            celdas[24][i].prioridad=CUADRANTE14;
        }
    }

    public void cuadrante21(int CUADRANTE21) {
        int i;
        for(i=0;i<3;i++) 
        {
            celdas[i][13].prioridad=CUADRANTE21;
            celdas[i][17].prioridad=CUADRANTE21;
        }
        for(i=13;i<17;i++) 
        {
            celdas[0][i].prioridad=CUADRANTE21;
            celdas[3][i].prioridad=CUADRANTE21;
        }
    }

    public void cuadrante22(int CUADRANTE22) {
        int i;
        for(i=6;i<10;i++) 
        {
            celdas[i][13].prioridad=CUADRANTE22;
            celdas[i][17].prioridad=CUADRANTE22;
        }
        for(i=13;i<17;i++) 
        {
            celdas[6][i].prioridad=CUADRANTE22;
            celdas[10][i].prioridad=CUADRANTE22;
        }
    }

    public void cuadrante23(int CUADRANTE23) {
        int i;
        int         x1=13,
                    x2=17,
                    y1=13,
                    y2=17;
        for(i=x1;i<x2;i++) 
        {
            celdas[i][y1].prioridad=CUADRANTE23;
            celdas[i][y2].prioridad=CUADRANTE23;
        }
        for(i=y1;i<y2;i++) 
        {
            celdas[x1][i].prioridad=CUADRANTE23;
            celdas[x2][i].prioridad=CUADRANTE23;
        }
    }

    public void cuadrante24(int CUADRANTE24) {
        int i;
        int         x1=20,
                    x2=24,
                    y1=13,
                    y2=17;
        for(i=x1;i<x2;i++) 
        {
            celdas[i][y1].prioridad=CUADRANTE24;
            celdas[i][y2].prioridad=CUADRANTE24;
        }
        for(i=y1;i<y2;i++) 
        {
            celdas[x1][i].prioridad=CUADRANTE24;
            celdas[x2][i].prioridad=CUADRANTE24;
        }
    }

    public void cuadrante31(int CUADRANTE31) {
        int i;
        int         x1=0,
                    x2=3,
                    y1=20,
                    y2=24;
        for(i=x1;i<x2;i++) 
        {
            celdas[i][y1].prioridad=CUADRANTE31;
            celdas[i][y2].prioridad=CUADRANTE31;
        }
        for(i=y1;i<y2;i++) 
        {
            celdas[x1][i].prioridad=CUADRANTE31;
            celdas[x2][i].prioridad=CUADRANTE31;
        }
    }

    public void cuadrante32(int CUADRANTE32) {
        int i;
        int         x1=6,
                    x2=10,
                    y1=20,
                    y2=24;
        for(i=x1;i<x2;i++) 
        {
            celdas[i][y1].prioridad=CUADRANTE32;
            celdas[i][y2].prioridad=CUADRANTE32;
        }
        for(i=y1;i<y2;i++) 
        {
            celdas[x1][i].prioridad=CUADRANTE32;
            celdas[x2][i].prioridad=CUADRANTE32;
        }
    }

    public void cuadrante33(int CUADRANTE33) {
        int i;
        int         x1=13,
                    x2=17,
                    y1=20,
                    y2=24;
        for(i=x1;i<x2;i++) 
        {
            celdas[i][y1].prioridad=CUADRANTE33;
            celdas[i][y2].prioridad=CUADRANTE33;
        }
        for(i=y1;i<y2;i++) 
        {
            celdas[x1][i].prioridad=CUADRANTE33;
            celdas[x2][i].prioridad=CUADRANTE33;
        }
    }

    public void cuadrante34(int CUADRANTE34) {
        int i;
        int         x1=20,
                    x2=24,
                    y1=20,
                    y2=24;
        for(i=x1;i<x2;i++) 
        {
            celdas[i][y1].prioridad=CUADRANTE34;
            celdas[i][y2].prioridad=CUADRANTE34;
        }
        for(i=y1;i<y2;i++) 
        {
            celdas[x1][i].prioridad=CUADRANTE34;
            celdas[x2][i].prioridad=CUADRANTE34;
        }
    }
    
    public void asignarCartas(int cartas, int cantPortal)
    {
        int contador=0,randomReparticion=0,totalcartas=cartas;
        if(cantPortal-1<=0)   cantPortal = 1;
        if(cantPortal-1>27)   cantPortal = 27;
        do
        {
            randomReparticion= numeroAleatorio(0, cartas);
            portales[numeroAleatorio(0, cantPortal-1)].asignarCartas(randomReparticion);
            contador+=randomReparticion;
            cartas -= randomReparticion; 
        }
        while(contador<totalcartas && cartas > 0);
        System.out.println("Cartas sobrantes: "+cartas);
    }
};