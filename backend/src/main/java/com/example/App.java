package com.example;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

@Component
public class App implements CommandLineRunner {

    @Autowired
    private JdbcTemplate jdbc;

    @Override
    public void run(String... args) {
        Integer resultado = jdbc.queryForObject("SELECT 1", Integer.class);
        System.out.println("Conexion OK: " + resultado);
        consultarUsuarios();
        consultarTecnologias();
    }

    void consultarUsuarios() {
        List<Map<String, Object>> usuarios = jdbc.queryForList("SELECT * FROM usuarios");
        System.out.println("Lista de usuarios:");
        for (Map<String, Object> u : usuarios) {
            System.out.println("- " + u.get("nombre"));
        }
    }

    void consultarTecnologias() {
        List<Map<String, Object>> tecs = jdbc.queryForList("SELECT * FROM tecnologias");
        System.out.println("Lista de tecnologias:");
        for (Map<String, Object> t : tecs) {
            System.out.println("- " + t.get("nombre"));
        }
    }

    void registrarUsuario(String nombre, String email, String password, String descripcion) {
        jdbc.update(
            "INSERT INTO usuarios (nombre, email, password, descripcion) VALUES (?, ?, ?, ?)",
            nombre, email, password, descripcion
        );
        System.out.println("Usuario registrado: " + nombre);
    }
}
