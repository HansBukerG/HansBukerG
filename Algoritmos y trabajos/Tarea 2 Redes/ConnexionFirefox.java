
import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Date;

public class ConnexionFirefox 
{
    
    PrintWriter outToClient;
    DataOutputStream salida;
    String[] lecturaCliente;
    Date fecha= new Date();
    ConnexionFirefox(PrintWriter outToClient, String[] lecturaCliente,DataOutputStream salida) throws IOException {
        this.outToClient=outToClient;
        this.lecturaCliente=lecturaCliente;
        this.salida= salida;
        this.Mensaje();
        
    }
    
    /*
        Aqui construyo el formulario de cabecera para firefox
    */
    public void formularioRespuestaHtml()
    {
        this.outToClient.println(       "HTTP/1.1 200 OK\r\n"
                                    +   "Date: "+fecha+"\r\n"
                                    +   "Server: ElMejorServerDelMundo/1.0 (YoOS)\r\n"
                                    +   "Keep-Alive: timeout=10, max 100\r\n"
                                    +   "Connection: Keep Alive\r\n"
                                    +   "Content-Type: text/html\r\n"
                                    +   "\r\n"
        );
        
    }
    
    public void Mensaje() throws IOException
    {
        int j=0;
        String[] campos=this.lecturaCliente[0].split("\\s");
            enviarDocumentoHtml(campos[1]);
    }
    
    /*Aqui leo el documento html en base a la peticion GET*/
    public void enviarDocumentoHtml(String campos) throws FileNotFoundException, IOException
    {
        try{
            int i=0;
            File archivo = new File("RespuestasWebFirefox"+campos);
            FileReader fr = new FileReader(archivo);
            BufferedReader br = new BufferedReader(fr);
            String texto = br.readLine();
            StringBuffer cadena2 = new StringBuffer();
            while((texto = br.readLine())!= null)
            {
                cadena2.append(texto);                
            }
            this.formularioRespuestaHtml();
            this.outToClient.println(cadena2.toString());
        }catch(IOException e)
        {
            int i=0;
            File archivo = new File("RespuestasWebFirefox/error.html");
            FileReader fr = new FileReader(archivo);
            BufferedReader br = new BufferedReader(fr);
            String texto = br.readLine();
            StringBuffer cadena2 = new StringBuffer();
            while((texto = br.readLine())!= null)
            {
                cadena2.append(texto);                
            }
            this.formularioRespuestaHtml();
            this.outToClient.println(cadena2.toString());
        }
    }
    

}
