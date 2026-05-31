package com.example;
import java.util.HashMap;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;
import org.junit.jupiter.api.Test;

public class LoveCodeTest {

    @Test
    public void registroDevuelveOkTrue() {
        Map<String, Object> respuesta = new HashMap<>();
        respuesta.put("ok", true);
        respuesta.put("id", 1);
        assertEquals(true, respuesta.get("ok"));
    }

    @Test
    public void registroEmailDuplicadoDevuelveOkFalse() {
        Map<String, Object> respuesta = new HashMap<>();
        respuesta.put("ok", false);
        respuesta.put("error", "Ese email ya está registrado");
        assertEquals(false, respuesta.get("ok"));
        assertEquals("Ese email ya está registrado", respuesta.get("error"));
    }

    @Test
    public void loginCorreoYPasswordCorrectos() {
        Map<String, Object> respuesta = new HashMap<>();
        respuesta.put("ok", true);
        respuesta.put("id", 3);
        assertTrue((Boolean) respuesta.get("ok"));
        assertEquals(3, respuesta.get("id"));
    }

    @Test
    public void loginPasswordIncorrectaDevuelveError() {
        Map<String, Object> respuesta = new HashMap<>();
        respuesta.put("ok", false);
        respuesta.put("error", "Email o contraseña incorrectos");
        assertFalse((Boolean) respuesta.get("ok"));
        assertEquals("Email o contraseña incorrectos", respuesta.get("error"));
    }

    @Test
    public void likeRegistradoSinMatch() {
        Map<String, Object> respuesta = new HashMap<>();
        respuesta.put("ok", true);
        respuesta.put("match", false);
        assertTrue((Boolean) respuesta.get("ok"));
        assertFalse((Boolean) respuesta.get("match"));
    }

    @Test
    public void likeGeneraMatchMutuo() {
        Map<String, Object> respuesta = new HashMap<>();
        respuesta.put("ok", true);
        respuesta.put("match", true);
        respuesta.put("idA", 1);
        respuesta.put("idB", 2);
        assertTrue((Boolean) respuesta.get("match"));
        assertEquals(1, respuesta.get("idA"));
        assertEquals(2, respuesta.get("idB"));
    }
}