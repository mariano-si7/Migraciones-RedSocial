USE RedSocialDB;
GO

-- 020 - Agregar campos de timestamp para auditoria de actualizacion en tablas mutables.

-- 1. Usuarios: FechaActualizacion
IF COL_LENGTH('dbo.Usuarios', 'FechaActualizacion') IS NULL
BEGIN
    ALTER TABLE dbo.Usuarios ADD FechaActualizacion DATETIME2 NULL;
END;
GO

-- 2. ComentariosMomentos: FechaActualizacion
IF COL_LENGTH('dbo.ComentariosMomentos', 'FechaActualizacion') IS NULL
BEGIN
    ALTER TABLE dbo.ComentariosMomentos ADD FechaActualizacion DATETIME2 NULL;
END;
GO

-- 3. Reportes: FechaActualizacion
IF COL_LENGTH('dbo.Reportes', 'FechaActualizacion') IS NULL
BEGIN
    ALTER TABLE dbo.Reportes ADD FechaActualizacion DATETIME2 NULL;
END;
GO
