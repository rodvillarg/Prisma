# Gimnasio API — Código base (Semana 5)

API REST en NestJS para el gimnasio: `Clases`, `Horarios`, `Miembros` e `Inscripciones`, cada
módulo con dominio, DTOs e infraestructura separados (patrón repositorio + inyección por token).
Los datos viven en memoria — ningún repositorio se conecta todavía a una base de datos real.

Este proyecto es el punto de partida de la Práctica 8 (Prisma) y la Práctica 9 (Blindar la API).

## Preguntas Práctica 8.

**1. ¿Por qué el paquete del adaptador se llama adapter-mariadb si usamos MySQL?**
Porque MariaDB nació como un fork de MySQL y todavía usa el mismo protocolo de conexión. 

**2. ¿Editar schema.prisma cambió algo en la base de datos antes de migrar?**
No, el schema.prisma solo es un archivo de texto que describe cómo quiero mi base, pero no toca nada todavía. 

**3. ¿La carpeta de migraciones es una foto del esquema o un historial?**
Es un historial, cada carpeta que se crea dentro de migrations guarda el SQL que se necesitó en ese momento para pasar del estado anterior al nuevo, entonces si las abro en orden puedo ver cómo fue creciendo la base desde el inicio.

**4. ¿Por qué Horario.clase sí crea columna y Clase.horarios no?**
Porque Horario es el lado que tiene la llave foránea (claseId), o sea el lado "muchos" de la relación. El @relation con fields y references es el que le dice a Prisma en qué tabla va la columna real. Clase.horarios solo es para poder acceder a los horarios desde el código, pero en la base de datos no genera ninguna columna.

**5. ¿De dónde sale la relación de muchos a muchos entre Miembro y Horario, si nunca se declaró?**
Sale de la tabla Inscripcion, que funciona como tabla intermedia con una llave foránea hacia Horario y otra hacia Miembro. 

## Cómo correrlo

```bash
npm install
npm run start:dev
```

El servidor levanta en `http://localhost:3000`. En `peticiones.http` está la batería completa de
pruebas (requiere la extensión "REST Client" de VS Code).

## Estructura

```
src/
  clases/        CRUD de clases del gimnasio
  horarios/      CRUD de horarios (día, hora, cupo, entrenador)
  miembros/      CRUD de miembros del gimnasio
  inscripciones/ inscribir a un miembro a un horario, con reglas de cupo y duplicados
  datos/         datos de arranque (seed) que usan Horarios y Miembros
```

Cada módulo sigue la misma forma: `dominio/` (entidades + interfaz del repositorio), `dto/`,
`infra/` (repositorio en memoria) y el token de inyección en `<módulo>.tokens.ts`.
