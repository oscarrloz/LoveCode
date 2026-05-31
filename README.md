# LoveCode

LoveCode es una aplicación web para conectar desarrolladores según las tecnologías que conocen o que les interesan. Funciona de forma similar a una app de citas, pero orientada al mundo tech.

Los usuarios se registran indicando sus tecnologías, exploran perfiles de otros desarrolladores y pueden dar like a los que les interesen. Cuando dos usuarios se dan like mutuamente, el sistema genera un match automáticamente y muestra una ficha de compatibilidad con las tecnologías que tienen en común.

## Tecnologías utilizadas

- Base de datos: MariaDB (ejecutada en máquina virtual Debian)
- Backend: Java 17 con Spring Boot y conexión JDBC
- Frontend: HTML, CSS y JavaScript con transformaciones XSLT
- Build: Maven

## Estructura del proyecto
LoveCode/
├── backend/
│   ├── pom.xml
│   └── src/
├── frontend/
│   ├── login.html
│   ├── registro.html
│   ├── perfiles.html
│   ├── match.xml
│   ├── match.xsl
│   └── style.css
├── database/
│   └── lovecode.sql
└── scripts/
├── backup.sh
└── arranque.sh

## Cómo ejecutar

1. Importar el archivo lovecode.sql en MariaDB
2. Configurar los datos de conexión en application.properties
3. Arrancar el backend con `mvn spring-boot:run`
4. Abrir login.html en el navegador

## Funcionalidades

- Registro de usuarios con selección de tecnologías
- Inicio de sesión con validación de credenciales
- Visualización de perfiles en formato de tarjetas
- Sistema de likes entre usuarios
- Generación automática de matches
- Ficha de compatibilidad en formato XML transformada con XSLT