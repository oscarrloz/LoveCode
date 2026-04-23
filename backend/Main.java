import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Main {
    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/lovecode";
        String usuario = "root";
        String contrasena = "1234567890";

        try {
            Connection conexion = DriverManager.getConnection(url, usuario, contrasena);
            System.out.println("Conexión establecida con la base de datos");

            Statement consulta = conexion.createStatement();
            ResultSet resultado = consulta.executeQuery("SELECT * FROM Usuarios");

            while (resultado.next()) {
                System.out.println("Usuario: " + resultado.getString("nombre"));
            }

            conexion.close();

        } catch (SQLException e) {
            System.out.println("Error al conectar: " + e.getMessage());
        }
    }
}


