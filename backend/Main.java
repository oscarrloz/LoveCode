import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Main {

   static String url = "jdbc:mariadb://192.168.0.18:3306/LoveCode";
    static String usuario = "root";
    static String contrasena = "1234";

    public static void main(String[] args) {

        try {
            Connection conexion = DriverManager.getConnection(url, usuario, contrasena);
            System.out.println("Conexion exitosa a la base de datos");

            consultarUsuarios(conexion);
            consultarTecnologias(conexion);

            conexion.close();
            System.out.println("Conexion cerrada");

        } catch (SQLException e) {
            System.out.println("Error al conectar: " + e.getMessage());
        }
    }

    static void consultarUsuarios(Connection conexion) throws SQLException {
        Statement consulta = conexion.createStatement();
        ResultSet resultado = consulta.executeQuery("SELECT * FROM Usuarios");

        System.out.println("Lista Usuarios:");
        while (resultado.next()) {
            System.out.println("- " + resultado.getString("nombre"));
        }
    }

    static void consultarTecnologias(Connection conexion) throws SQLException {
        Statement consulta = conexion.createStatement();
        ResultSet resultado = consulta.executeQuery("SELECT * FROM Tecnologias");

        System.out.println("Lista de tecnologías:");
        while (resultado.next()) {
            System.out.println("- " + resultado.getString("nombre"));
        }
    }
}