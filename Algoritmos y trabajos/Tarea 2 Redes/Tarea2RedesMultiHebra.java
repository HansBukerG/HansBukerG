import java.io.*; 
import java.net.*; 

public class Tarea2RedesMultiHebra extends Thread {
private Socket socket;
    public Tarea2RedesMultiHebra(Socket s){
        socket = s;
        this.start();
      }
    public void run(){
        
          try{
                LeerMensaje Cliente;
                BufferedReader inFromClient = new BufferedReader(new InputStreamReader(socket.getInputStream())); 
                PrintWriter outToClient =  new PrintWriter(socket.getOutputStream(), true);
                Cliente = new LeerMensaje(socket,inFromClient,outToClient);
                socket.close(); 
          
          }catch(IOException e){
            System.out.println("Socket error");
          }
      }
    
    
  public static void main(String argv[]) throws Exception 
    { 
        boolean conexion = true;
        
        String clientSentence;
        try (ServerSocket welcomeSocket = new ServerSocket(80)) {
            
           while(true) { 
            // Porteria que deberia hacer este paso
             Socket connectionSocket = welcomeSocket.accept();
             Tarea2RedesMultiHebra server = new Tarea2RedesMultiHebra(connectionSocket);
        }
            
        } 
        
        
    }
} 
            