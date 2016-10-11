package bancos;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


/**
 *
 * @author João Victor Ignacio
 * @author Danilo Aguiar
 * @author Renan Distadio
 * @author Carlos Iatarola
 */

public class Conexao {
    
    public static Connection connection = null; //atributo do tipo Connection
    
    public static String status = "Não conectou...";
    static String serverName = ""; 
    static String mydatabase = "";
    static String url = "";            
    static String username = ""; //nome de um usuário de seu BD
    static String password = "";
    
    public static java.sql.Connection getConexaoMySQL() {    
        
        try {
            // Carregando o JDBC Driver padrão
            String driverName = "com.mysql.jdbc.Driver";
            Class.forName(driverName);
            
            // Configurando a nossa conexão com um banco de dados//
            serverName = "localhost"; //caminho do servidor do BD 
            mydatabase = "mydb"; //nome do seu banco de dados
            url = "jdbc:mysql://" + serverName + "/" + mydatabase;
            username = "root"; //nome de um usuário de seu BD
            password = ""; //sua senha de acesso
            connection = DriverManager.getConnection(url, username, password);
            
            //Testa sua conexão//
            if (connection != null) {
                status = ("STATUS--->Conectado com sucesso!");
            } else {
                status = ("STATUS--->Não foi possivel realizar conexão");
            }
            
            return connection;
            
        } catch (ClassNotFoundException e) {  //Driver não encontrado
            System.out.println("O driver expecificado nao foi encontrado.");
            return null;
        } catch (SQLException e) {
            //Não conseguindo se conectar ao banco
            System.out.println("Nao foi possivel conectar ao Banco de Dados.");
            return null;
        }
            
    }    
    
    //Método que retorna o status da sua conexão//
    public static String statusConection() {
        //JOptionPane.showMessageDialog(null, status);
        return status;
    }
    
    public static Connection getConexao(){
        return connection;
    }
    
    
    //Método que fecha sua conexão//
    public static boolean FecharConexao() {
         try{
             Conexao.getConexaoMySQL().close();
             return true;
         } catch (SQLException e) {
             return false;
         }
    }   
    
    //Método que reinicia sua conexão//
    public static java.sql.Connection ReiniciarConexao() {
        FecharConexao();
        return Conexao.getConexaoMySQL();
    }
    
}
