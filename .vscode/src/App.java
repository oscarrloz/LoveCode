import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class App {
    public static void main(String[] args) {

        String host = "192.168.0.18";          
        int port = 3306;
        String database = "LoveCode";
        String user = "db_admin";
        String password = "1234";

        String url = "jdbc:mariadb://" + host + ":" + port + "/" + database;

        try (
            Connection conn = DriverManager.getConnection(url, user, password);
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT 1")
        ) {
            rs.next();
            System.out.println("Conexión OK: " + rs.getInt(1));
        } catch (Exception e) {
            System.out.println("Error:");
            e.printStackTrace();
        }
    }
}