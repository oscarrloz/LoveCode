package com.example.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.model.Usuario;
import com.example.repository.UsuarioRepository;

@RestController
@CrossOrigin(origins = "*")
public class UsuarioController {

    @Autowired
    private UsuarioRepository usuarioRepo;

    @Autowired
    private JdbcTemplate jdbc;

    @PostMapping("/registro")
    public Map<String, Object> registro(@RequestBody Map<String, Object> datos) {

        Map<String, Object> respuesta = new HashMap<>();

        String nombre      = (String) datos.get("nombre");
        String email       = (String) datos.get("email");
        String password    = (String) datos.get("password");
        String descripcion = (String) datos.getOrDefault("descripcion", "");

        if (usuarioRepo.findByEmail(email).isPresent()) {
            respuesta.put("ok", false);
            respuesta.put("error", "Ese email ya esta registrado");
            return respuesta;
        }

        Usuario nuevo = new Usuario();
        nuevo.setNombre(nombre);
        nuevo.setEmail(email);
        nuevo.setPassword(password);
        nuevo.setDescripcion(descripcion);
        usuarioRepo.save(nuevo);

        List<Integer> tecnologias = (List<Integer>) datos.get("tecnologias");
        if (tecnologias != null) {
            for (int idTec : tecnologias) {
                jdbc.update(
                    "INSERT IGNORE INTO usuarios_tecnologias (id_usuario, id_tecnologia) VALUES (?, ?)",
                    nuevo.getId(), idTec
                );
            }
        }

        System.out.println("Usuario registrado: " + nombre);
        respuesta.put("ok", true);
        respuesta.put("id", nuevo.getId());
        return respuesta;
    }

    @PostMapping("/login")
    public Map<String, Object> login(@RequestBody Map<String, Object> datos) {

        Map<String, Object> respuesta = new HashMap<>();

        String email    = (String) datos.get("email");
        String password = (String) datos.get("password");

        Optional<Usuario> usuario = usuarioRepo.findByEmailAndPassword(email, password);

        if (usuario.isPresent()) {
            System.out.println("Login OK: " + email);
            respuesta.put("ok", true);
            respuesta.put("id", usuario.get().getId());
        } else {
            respuesta.put("ok", false);
            respuesta.put("error", "Email o contrasena incorrectos");
        }

        return respuesta;
    }

    @GetMapping("/perfiles")
    public List<Map<String, Object>> perfiles(@RequestParam int idSesion) {

        List<Usuario> usuarios = usuarioRepo.findAllExcept(idSesion);
        List<Map<String, Object>> lista = new ArrayList<>();

        for (Usuario u : usuarios) {
            List<String> tecs = jdbc.queryForList(
                "SELECT t.nombre FROM tecnologias t " +
                "JOIN usuarios_tecnologias ut ON ut.id_tecnologia = t.id " +
                "WHERE ut.id_usuario = ?",
                String.class, u.getId()
            );

            Map<String, Object> perfil = new HashMap<>();
            perfil.put("id",          u.getId());
            perfil.put("nombre",      u.getNombre());
            perfil.put("descripcion", u.getDescripcion());
            perfil.put("tecnologias", tecs);
            lista.add(perfil);
        }

        return lista;
    }

    @GetMapping("/tecnologias")
    public List<Map<String, Object>> tecnologias() {
        return jdbc.queryForList("SELECT id, nombre FROM tecnologias ORDER BY nombre");
    }

    @PostMapping("/like")
    public Map<String, Object> darLike(@RequestBody Map<String, Object> datos) {

        Map<String, Object> respuesta = new HashMap<>();

        int idEmisor   = (int) datos.get("idEmisor");
        int idReceptor = (int) datos.get("idReceptor");

        try {
            jdbc.update(
                "INSERT IGNORE INTO likes (id_emisor, id_receptor) VALUES (?, ?)",
                idEmisor, idReceptor
            );
        } catch (Exception e) {
            System.out.println("Error al guardar like: " + e.getMessage());
        }

        Integer hay = jdbc.queryForObject(
            "SELECT COUNT(*) FROM matches " +
            "WHERE (id_usuario1 = ? AND id_usuario2 = ?) " +
            "   OR (id_usuario1 = ? AND id_usuario2 = ?)",
            Integer.class,
            Math.min(idEmisor, idReceptor), Math.max(idEmisor, idReceptor),
            Math.min(idEmisor, idReceptor), Math.max(idEmisor, idReceptor)
        );

        boolean hayMatch = hay != null && hay > 0;
        respuesta.put("ok",    true);
        respuesta.put("match", hayMatch);

        if (hayMatch) {
            String xml = generarXml(idEmisor, idReceptor);
            respuesta.put("xml", xml);
            respuesta.put("idA", idEmisor);
            respuesta.put("idB", idReceptor);
            System.out.println("Match entre " + idEmisor + " y " + idReceptor);
        }

        return respuesta;
    }

    @GetMapping("/match-xml")
    public String matchXml(@RequestParam int idA, @RequestParam int idB) {
        return generarXml(idA, idB);
    }

    private String generarXml(int idA, int idB) {

        String sqlUsuario =
            "SELECT u.nombre, u.descripcion, " +
            "GROUP_CONCAT(t.nombre ORDER BY t.nombre SEPARATOR ',') AS tecnologias " +
            "FROM usuarios u " +
            "LEFT JOIN usuarios_tecnologias ut ON ut.id_usuario = u.id " +
            "LEFT JOIN tecnologias t ON t.id = ut.id_tecnologia " +
            "WHERE u.id = ? GROUP BY u.id";

        Map<String, Object> u1 = jdbc.queryForMap(sqlUsuario, idA);
        Map<String, Object> u2 = jdbc.queryForMap(sqlUsuario, idB);

        String fecha = jdbc.queryForObject(
            "SELECT fecha_match AS fecha FROM matches " +
            "WHERE (id_usuario1 = ? AND id_usuario2 = ?) " +
            "   OR (id_usuario1 = ? AND id_usuario2 = ?)",
            String.class,
            Math.min(idA,idB), Math.max(idA,idB),
            Math.min(idA,idB), Math.max(idA,idB)
        );

        List<String> comunes = jdbc.queryForList(
            "SELECT t.nombre FROM tecnologias t " +
            "JOIN usuarios_tecnologias a ON a.id_tecnologia = t.id AND a.id_usuario = ? " +
            "JOIN usuarios_tecnologias b ON b.id_tecnologia = t.id AND b.id_usuario = ?",
            String.class, idA, idB
        );

        StringBuilder xml = new StringBuilder();
        xml.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
        xml.append("<match>\n");
        xml.append("  <fecha>").append(fecha).append("</fecha>\n");

        xml.append("  <usuario1>\n");
        xml.append("    <nombre>").append(u1.get("nombre")).append("</nombre>\n");
        xml.append("    <descripcion>").append(u1.get("descripcion")).append("</descripcion>\n");
        xml.append("    <tecnologias>\n");
        String t1 = (String) u1.get("tecnologias");
        if (t1 != null) for (String t : t1.split(","))
            xml.append("      <tecnologia>").append(t.trim()).append("</tecnologia>\n");
        xml.append("    </tecnologias>\n");
        xml.append("  </usuario1>\n");

        xml.append("  <usuario2>\n");
        xml.append("    <nombre>").append(u2.get("nombre")).append("</nombre>\n");
        xml.append("    <descripcion>").append(u2.get("descripcion")).append("</descripcion>\n");
        xml.append("    <tecnologias>\n");
        String t2 = (String) u2.get("tecnologias");
        if (t2 != null) for (String t : t2.split(","))
            xml.append("      <tecnologia>").append(t.trim()).append("</tecnologia>\n");
        xml.append("    </tecnologias>\n");
        xml.append("  </usuario2>\n");

        xml.append("  <tecnologias_comunes>\n");
        for (String t : comunes)
            xml.append("    <tecnologia>").append(t).append("</tecnologia>\n");
        xml.append("  </tecnologias_comunes>\n");
        xml.append("</match>\n");

        return xml.toString();
    }
}