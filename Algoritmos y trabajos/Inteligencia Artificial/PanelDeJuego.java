
import java.awt.BorderLayout;
import javax.swing.JPanel;

// El panel de juego contendra el lienzo

class PanelDeJuego extends JPanel implements Constantes {
    public Lienzo lienzo;
    
    public PanelDeJuego()
    {
        this.setLayout(new BorderLayout());
        // Llamada del lienzo
        lienzo= new Lienzo();
        lienzo.setFocusable(true);
        lienzo.requestFocus();
        this.add(lienzo);
    }
    
}
