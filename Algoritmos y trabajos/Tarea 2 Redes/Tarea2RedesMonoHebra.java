import java.io.*; 
import java.net.*; 

public class Tarea2RedesMonoHebra {
    
  public static void main(String argv[]) throws Exception 
    { 
        boolean conexion = true;
        LeerMensaje Cliente;
        String clientSentence;
        try (ServerSocket welcomeSocket = new ServerSocket(80)) {
            while(true)
            {
                Socket connectionSocket = welcomeSocket.accept();
                BufferedReader inFromClient = new BufferedReader(new InputStreamReader(connectionSocket.getInputStream()));
                PrintWriter outToClient =  new PrintWriter(connectionSocket.getOutputStream(), true);
                Cliente = new LeerMensaje(connectionSocket,inFromClient,outToClient);
                connectionSocket.close();
            }
            
        }
    }
} 
 

