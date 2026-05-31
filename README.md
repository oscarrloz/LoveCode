# LoveCode - Web Edition

App tipo Tinder pero para desarrolladores.
Te registras con tus tecnologias, ves perfiles de otros y das likes.
Si dos usuarios se dan like mutuamente, sale un match automatico.

## Tecnologias

- Base de datos: MariaDB
- Backend: Java 17 + Spring Boot
- Frontend: HTML, CSS y JavaScript
- Build: Maven

## Estructura

```
LoveCode/
├── backend/
│   ├── pom.xml
│   └── src/main/java/com/example/
│       ├── Main.java                          -> arranca el servidor
│       ├── model/Usuario.java                 -> clase de la tabla Usuarios
│       ├── repository/UsuarioRepository.java  -> consultas a la BD
│       └── controller/UsuarioController.java  -> rutas del servidor
├── frontend/
│   ├── login.html      -> pantalla de login (basada en el HTML.html original)
│   ├── registro.html   -> pantalla de registro
│   ├── perfiles.html   -> tarjetas de perfiles con likes
│   └── style.css       -> el mismo CSS que ya teniamos
├── database/
│   └── lovecode.sql    -> script SQL completo
├── scripts/
│   ├── backup.sh       -> hace una copia de seguridad
│   └── arranque.sh     -> arranca todo el sistema
└── README.md
```

## Como ejecutarlo

### 1. Base de datos
```bash
mysql -u root -p < database/lovecode.sql
```

### 2. Backend
```bash
cd backend
mvn package
java -jar target/demo-1.0-SNAPSHOT.jar
```
El servidor arranca en http://localhost:8080

### 3. Frontend
Abre `frontend/login.html` en el navegador.

### Con el script de arranque
```bash
chmod +x scripts/arranque.sh
./scripts/arranque.sh
```

## Rutas del servidor

| Metodo | Ruta         | Para que sirve                    |
|--------|--------------|-----------------------------------|
| POST   | /registro    | Registrar usuario nuevo           |
| POST   | /login       | Iniciar sesion                    |
| GET    | /perfiles    | Ver perfiles (con ?idSesion=X)    |
| POST   | /like        | Dar like a alguien                |
| GET    | /tecnologias | Ver las tecnologias disponibles   |
| GET    | /match-xml   | XML del match (con ?idA=X&idB=Y)  |
