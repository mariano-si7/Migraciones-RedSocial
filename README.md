# Migraciones de base de datos - Moment

Estas migraciones crean y actualizan la base de datos inicial de la app.

## Requisitos

- SQL Server instalado o accesible.
- SQL Server Management Studio, Azure Data Studio o una herramienta similar.
- Permisos para crear la base de datos `RedSocialDB`.

## Orden de ejecución

Ejecuta los archivos en este orden:

1. `001_crear_tabla_usuarios.sql`
2. `002_registro_verificacion_email_roles.sql`
3. `003_vista_disponibilidad_usuarios.sql`
4. `004_vista_disponibilidad_emails.sql`
5. `005_crear_tabla_perfiles_usuario.sql`
6. `006_crear_tabla_recuperaciones_password.sql`
7. `007_social_basico_perfiles_seguidores.sql`
8. `008_crear_tabla_momentos.sql`
9. `009_crear_me_gusta_momentos.sql`
10. `010_historial_cambios_perfil.sql`
11. `011_soft_delete_momentos.sql`
12. `012_busqueda_perfiles_momentos.sql`
13. `013_roles_multiples_fundador.sql`
14. `014_reportes_moderacion_advertencias.sql`
15. `015_ajustar_reportes_momentos_con_usuario.sql`
16. `016_chat_conversaciones_mensajes.sql`
17. `017_crear_comentarios_momentos.sql`
18. `018_comentarios_likes_respuestas.sql`
19. `019_momentos_hasta_10_imagenes.sql`
20. `020_agregar_timestamps_actualizacion.sql`
21. `021_agregar_trazabilidad_token_sobreescrituras.sql`

El orden importa porque cada migración agrega columnas y tablas sobre la estructura previa.

## Cómo ejecutar

1. Abre SQL Server Management Studio o Azure Data Studio.
2. Conéctate a tu instancia de SQL Server.
3. Abre el archivo `001_crear_tabla_usuarios.sql`.
4. Ejecuta el script completo.
5. Abre y ejecuta sucesivamente cada archivo hasta el `019`.

Los scripts usan `USE RedSocialDB;`, por lo que la primera migración crea la base si todavía no existe.

## Qué crea cada migración

`001_crear_tabla_usuarios.sql` crea:

- Base de datos `RedSocialDB`.
- Tabla `Usuarios`.
- Restricciones únicas para `NombreUsuario` y `Email`.

`002_registro_verificacion_email_roles.sql` agrega:

- `NombrePerfil`
- `FechaNacimiento`
- `Rol`
- `EmailVerificado`
- Tabla `VerificacionesEmail` para códigos de verificación.

`003_vista_disponibilidad_usuarios.sql` agrega:

- Vista `vw_UsuariosLookup`.
- Índice único sobre `NombreUsuario` para consultas rápidas de disponibilidad.

`004_vista_disponibilidad_emails.sql` agrega:

- Vista `vw_EmailsLookup`.
- Índice único sobre `Email` para consultas rápidas de disponibilidad.

`005_crear_tabla_perfiles_usuario.sql` agrega:

- Tabla `PerfilesUsuario`.
- Relación 1 a 1 con `Usuarios`.
- Migración inicial de `NombrePerfil` y `FechaNacimiento` desde usuarios existentes.

`006_crear_tabla_recuperaciones_password.sql` agrega:

- Tabla `RecuperacionesPassword`.
- Códigos hasheados para recuperación de contraseña.
- Token temporal de recuperación con expiración e intentos fallidos.

`007_social_basico_perfiles_seguidores.sql` agrega:

- `SobreMi` de máximo 300 caracteres.
- `TotalMeEncanta` en perfiles.
- Tabla `Seguidores` con relación única seguidor/seguido.

`008_crear_tabla_momentos.sql` agrega:

- Tabla `Momentos`.
- Relación obligatoria con `Usuarios`.
- Soporte inicial para texto, foto, video y link.

`009_crear_me_gusta_momentos.sql` agrega:

- Tabla `MeGustaMomentos`.
- Relación única por usuario y momento.
- Índices para consultar reacciones del usuario rápidamente.

`010_historial_cambios_perfil.sql` agrega:

- Tabla `HistorialCambiosPerfil`.
- Historial de cambios de nombre de perfil y nombre de usuario.
- Índice por usuario, tipo de cambio y fecha para validar restricciones temporales.

`011_soft_delete_momentos.sql` agrega:

- Campos de eliminación suave en `Momentos`.
- Fecha de entrada al limbo y fecha de eliminación definitiva a 30 días.
- Usuario que eliminó y motivo de eliminación.
- Índice para futuras limpiezas/auditorías.

`012_busqueda_perfiles_momentos.sql` agrega:

- Vista `vw_BusquedaPerfiles`.
- Índices para buscar por nombre de usuario y nombre de perfil.
- Índice base para búsquedas de momentos activos.

`013_roles_multiples_fundador.sql` agrega:

- Tablas `Roles` y `UsuarioRoles` para soporte de múltiples roles y permisos (incluyendo fundador).

`014_reportes_moderacion_advertencias.sql` agrega:

- Tablas `Reportes`, `ModeracionAcciones` y `AdvertenciasUsuario` para moderación.

`015_ajustar_reportes_momentos_con_usuario.sql` agrega:

- Ajuste de integridad para reportes de momentos enlazando al usuario reportado.

`016_chat_conversaciones_mensajes.sql` agrega:

- Tablas `Conversaciones` y `MensajesChat` para mensajería directa en tiempo real.

`017_crear_comentarios_momentos.sql` agrega:

- Tabla `ComentariosMomentos` para comentarios en publicaciones.

`018_comentarios_likes_respuestas.sql` agrega:

- Respuestas anidadas (`IdComentarioPadre`), contadores y tabla `MeGustaComentariosMomentos`.

`019_momentos_hasta_10_imagenes.sql` agrega:

- Ampliación de `ArchivoUrl` a `NVARCHAR(MAX)` en `Momentos` para permitir arreglos JSON de hasta 10 imágenes.

`020_agregar_timestamps_actualizacion.sql` agrega:

- Campos `FechaActualizacion` en `Usuarios`, `ComentariosMomentos` y `Reportes` para auditoría temporal automática.

`021_agregar_trazabilidad_token_sobreescrituras.sql` agrega:

- Campos `ModificadoPorTokenId` (UUID) y `ModificadoPorUsuarioId` (INT) en tablas auditables para rastreo de sobreescrituras por token JWT de sesión.

## Notas importantes

- Los scripts están escritos para SQL Server.
- La app no guarda contraseñas en texto plano; guarda `PasswordHash`.
- Los códigos de verificación tampoco se guardan en texto plano; se guarda `CodigoHash`.
- Si la base ya tiene usuarios, la migración 002 rellena `NombrePerfil` usando `NombreUsuario`.

## Sincronización automática local

Este repo incluye un watcher opcional para Windows. Sirve para que, en esta PC, cada cambio en archivos `.sql` o en este `README.md` genere un commit automático y haga `git push`.

Instalar:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install-watcher.ps1
```

Desinstalar:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\uninstall-watcher.ps1
```

El instalador crea un acceso de arranque en la carpeta de Inicio de Windows del usuario actual. No requiere permisos de administrador.
