USE RedSocialDB;
GO

-- 021 - Agregar campos de trazabilidad por token y usuario para sobreescrituras en entidades auditables.

-- 1. Usuarios: ModificadoPorTokenId y ModificadoPorUsuarioId
IF COL_LENGTH('dbo.Usuarios', 'ModificadoPorTokenId') IS NULL
BEGIN
    ALTER TABLE dbo.Usuarios ADD ModificadoPorTokenId UNIQUEIDENTIFIER NULL;
END;
GO

IF COL_LENGTH('dbo.Usuarios', 'ModificadoPorUsuarioId') IS NULL
BEGIN
    ALTER TABLE dbo.Usuarios ADD ModificadoPorUsuarioId INT NULL;
END;
GO

-- 2. Momentos: ModificadoPorTokenId y ModificadoPorUsuarioId
IF COL_LENGTH('dbo.Momentos', 'ModificadoPorTokenId') IS NULL
BEGIN
    ALTER TABLE dbo.Momentos ADD ModificadoPorTokenId UNIQUEIDENTIFIER NULL;
END;
GO

IF COL_LENGTH('dbo.Momentos', 'ModificadoPorUsuarioId') IS NULL
BEGIN
    ALTER TABLE dbo.Momentos ADD ModificadoPorUsuarioId INT NULL;
END;
GO

-- 3. PerfilesUsuario: ModificadoPorTokenId y ModificadoPorUsuarioId
IF COL_LENGTH('dbo.PerfilesUsuario', 'ModificadoPorTokenId') IS NULL
BEGIN
    ALTER TABLE dbo.PerfilesUsuario ADD ModificadoPorTokenId UNIQUEIDENTIFIER NULL;
END;
GO

IF COL_LENGTH('dbo.PerfilesUsuario', 'ModificadoPorUsuarioId') IS NULL
BEGIN
    ALTER TABLE dbo.PerfilesUsuario ADD ModificadoPorUsuarioId INT NULL;
END;
GO

-- 4. ComentariosMomentos: ModificadoPorTokenId y ModificadoPorUsuarioId
IF COL_LENGTH('dbo.ComentariosMomentos', 'ModificadoPorTokenId') IS NULL
BEGIN
    ALTER TABLE dbo.ComentariosMomentos ADD ModificadoPorTokenId UNIQUEIDENTIFIER NULL;
END;
GO

IF COL_LENGTH('dbo.ComentariosMomentos', 'ModificadoPorUsuarioId') IS NULL
BEGIN
    ALTER TABLE dbo.ComentariosMomentos ADD ModificadoPorUsuarioId INT NULL;
END;
GO

-- 5. Reportes: ModificadoPorTokenId y ModificadoPorUsuarioId
IF COL_LENGTH('dbo.Reportes', 'ModificadoPorTokenId') IS NULL
BEGIN
    ALTER TABLE dbo.Reportes ADD ModificadoPorTokenId UNIQUEIDENTIFIER NULL;
END;
GO

IF COL_LENGTH('dbo.Reportes', 'ModificadoPorUsuarioId') IS NULL
BEGIN
    ALTER TABLE dbo.Reportes ADD ModificadoPorUsuarioId INT NULL;
END;
GO
