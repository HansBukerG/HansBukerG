
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.Socket;

public class LeerMensaje {
    
    Socket connectionSocket;
    BufferedReader inFromClient;
    PrintWriter outToClient;
    String[] lecturaCliente;
    ConnexionChrome chrome;
    ConnexionFirefox firefox;
    DataOutputStream salida;
    
    public LeerMensaje(Socket connectionSocket, BufferedReader inFromClient, PrintWriter outToClient) throws IOException {
        
        this.connectionSocket   =   connectionSocket;
        this.outToClient        =   outToClient;
        int i=0;
        this.inFromClient       =   inFromClient;
        salida= new DataOutputStream(this.connectionSocket.getOutputStream());
        lecturaCliente = new String[20];
        /*
            Aqui traspaso los mensajes que me envia el navegador y son guardados en un array
        */
        do{
            
            lecturaCliente[i] = this.inFromClient.readLine();
            System.out.println("Del Cliente:"+lecturaCliente[i]);
            i++;
        }while(!"".equals(lecturaCliente[i-1]));
        
        if(detectarOrigen(lecturaCliente,i)== 0)
        {
            System.out.println("Iniciando Conexion");
            this.firefox= new ConnexionFirefox(this.outToClient,lecturaCliente,salida);
        }
        else
        {
            if(detectarOrigen(lecturaCliente,i)== 1)
            {
                System.out.println("Iniciando Conexion");
                this.chrome=new ConnexionChrome(this.outToClient,lecturaCliente,salida);
            }
            else
            {
                if(detectarOrigen(lecturaCliente,i)== -1)
                {
                    System.out.println("Error: Navegador no detectado");
                }
            }
        
        }
        
        
    }
    
    /* detectarOrigen verificara desde que navegador provendra  el mensaje
        0= El navegador detectado es Firefox
        1= El navegador detectado es Chrome
    */
    
    public int detectarOrigen(String[] lectura, int contador)
    {
        int i;
        for(i=0;i<contador-1;i++)
        {    
            if(verificarMensaje(lectura[i])==0) return 0;
            if(verificarMensaje(lectura[i])==1) return 1;
        }
        return -1;
    }
    
    /*
        Aqui verifico entre las lineas de texto el tipo de navegador que se esta comunicando con mi servidor
    */
    public int verificarMensaje(String Mensaje)
    {
        if(Mensaje.contains("User-Agent"))
        {
            if(Mensaje.contains("Firefox"))
            {
                System.out.println("Firefox reconocido");
                return 0;
            }
            if(Mensaje.contains("Chrome"))
            {
                System.out.println("Chrome reconocido");
                return 1;
            }
        }
        return -1;
    }
}
