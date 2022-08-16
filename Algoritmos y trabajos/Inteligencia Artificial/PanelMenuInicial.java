
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.event.ActionEvent;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;

/*El panel de menu inicial sera para anteponer una ventana de inicio al juego cuando se quiera iniciar,
    El boton comenzar mostrara la ventana principal de juego que contendra el lienzo
    El boton salir contendra cerrara la aplicacion
*/

public class PanelMenuInicial extends JPanel implements Constantes {
    
    public JButton comenzar,salir;
    public JLabel presentacion,textoAdicional;
    public JFrame ventana_principal;
    public Graphics graficoBuffer;
        
    public PanelMenuInicial(JFrame ventana_principal)
    {
        this.ventana_principal= ventana_principal;
        
        this.setLayout(null);
        this.setSize(800,600);
                
        presentacion= new JLabel("Hola");
        presentacion.setFont(new Font("Times New Roman",Font.BOLD,40));
        presentacion.setForeground(Color.orange);
        presentacion.setBounds(300,ALTURA_VENTANA/5,400,200);
        
        textoAdicional= new JLabel("Selecciona una opcion");
        textoAdicional.setFont(new Font("Times New Roman",Font.BOLD,40));
        textoAdicional.setForeground(Color.orange);
        textoAdicional.setBounds(250,ALTURA_VENTANA/4,400,200);
        
        comenzar= new JButton("COMENZAR");
        comenzar.setBounds(50,450,310,100);
        comenzar.setOpaque(false);
        comenzar.setFont(new Font("Times New Roman",Font.BOLD,20));
        comenzar.setBackground(Color.BLACK);
        comenzar.setForeground(Color.ORANGE);
        comenzar.setHorizontalTextPosition(JButton.CENTER);
        comenzar.setVerticalTextPosition(JButton.CENTER);
        comenzar.addActionListener(this::pulsarBotonComenzar);
        
        salir= new JButton("SALIR");
        salir.setBounds(400,450,310,100);
        salir.setOpaque(false);
        salir.setFont(new Font("Times New Roman",Font.BOLD,20));
        salir.setBackground(Color.BLACK);
        salir.setForeground(Color.ORANGE);
        salir.setHorizontalTextPosition(JButton.CENTER);
        salir.setVerticalTextPosition(JButton.CENTER);
        salir.addActionListener(this::pulsarBotonSalir);
        
        
        
        add(comenzar);
        add(salir);
        add(presentacion);
        add(textoAdicional);
        
        //volcamos color de fondo e imagen en el nuevo buffer grafico
    }


    public void pulsarBotonComenzar(ActionEvent e)
    {
        ventana_principal.setVisible(false);
        this.setVisible(false);
        VentanaPrincipal vp=new VentanaPrincipal();
        vp.setVisible(true);
        vp.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    }

    public void pulsarBotonSalir(ActionEvent e)
    {
        System.exit(0);
    }  
}


//ffedbac tiene que evr con todo el contenido adicional, como al voz del comentarista, el puntaje del usuario