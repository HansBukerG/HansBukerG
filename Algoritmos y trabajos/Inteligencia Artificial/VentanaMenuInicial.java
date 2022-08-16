


import javax.swing.JFrame;

public class VentanaMenuInicial extends JFrame 
{
    
    public PanelMenuInicial panel;
    public VentanaMenuInicial()
    {
        panel= new PanelMenuInicial(this);
        this.getContentPane().add(panel);
        this.setSize(panel.getSize());
        this.setResizable(false);
    }
}


//set layout sirve para organizar las variables... cuando se declara en null es por que es el usuario el que distribuye lso elementos