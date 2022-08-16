/* paquetes que utilizaremos:
-la clase JFrame nos proporciona funcionalidad para crear ventanas
-la clase BorderLayout nos proporciona funcionalidad para distribuir los
elemtnos graficos */
import java.awt.BorderLayout;
import javax.swing.JFrame;
/* clase VetanaPrincipal hereda de JFrame para obtener funcionalidad
de creacion de ventanas graficas
*/
public class VentanaPrincipal extends JFrame implements Constantes
{
    public PanelDeJuego panelJuego;

    //constructor 
    public VentanaPrincipal() 
    {
        // La ventana principal se inicializa con el pane de juego
        panelJuego= new PanelDeJuego();
        getContentPane().setLayout(new BorderLayout());
        getContentPane().add(panelJuego,BorderLayout.CENTER);

        this.setSize(anchuraCelda*anchuraMundoVirtual+50, alturaCelda*alturaMundoVirtual+80);
    }
}
