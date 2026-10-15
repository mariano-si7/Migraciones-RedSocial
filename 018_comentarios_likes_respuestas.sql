USE RedSocialDB;
GO

IF COL_LENGTH('dbo.ComentariosMomentos', 'IdComentarioPadre') IS NULL
BEGIN
    ALTER TABLE dbo.ComentariosMomentos ADD IdComentarioPadre INT NULL;
END;
GO

IF COL_LENGTH('dbo.ComentariosMomentos', 'TotalMeGusta') IS NULL
BEGIN
    ALTER TABLE dbo.ComentariosMomentos ADD TotalMeGusta INT NOT NULL CONSTRAINT DF_ComentariosMomentos_TotalMeGusta DEFAULT 0;
END;
GO

IF COL_LENGTH('dbo.ComentariosMomentos', 'TotalRespuestas') IS NULL
BEGIN
    ALTER TABLE dbo.ComentariosMomentos ADD TotalRespuestas INT NOT NULL CONSTRAINT DF_ComentariosMomentos_TotalRespuestas DEFAULT 0;
END;
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_ComentariosMomentos_ComentarioPadre'
)
BEGIN
    ALTER TABLE dbo.ComentariosMomentos
    ADD CONSTRAINT FK_ComentariosMomentos_ComentarioPadre
        FOREIGN KEY (IdComentarioPadre) REFERENCES dbo.ComentariosMomentos(IdComentario);
END;
GO

IF EXISTS (
    SELECT 1 FROM sys.indexes WHERE name = 'IX_ComentariosMomentos_Momento_Activo_Fecha'
)
BEGIN
    DROP INDEX IX_ComentariosMomentos_Momento_Activo_Fecha ON dbo.ComentariosMomentos;
END;
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.indexes WHERE name = 'IX_ComentariosMomentos_Momento_Padre_Activo_Fecha'
)
BEGIN
    CREATE INDEX IX_ComentariosMomentos_Momento_Padre_Activo_Fecha
    ON dbo.ComentariosMomentos(IdMomento, IdComentarioPadre, Activo, FechaCreacion);
END;
GO

ALTER TABLE dbo.ComentariosMomentos ALTER COLUMN Texto NVARCHAR(300) NOT NULL;
GO

IF OBJECT_ID('dbo.MeGustaComentariosMomentos', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.MeGustaComentariosMomentos (
        IdComentarioMeGusta INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_MeGustaComentariosMomentos PRIMARY KEY,
        IdComentario INT NOT NULL,
        IdUsuario INT NOT NULL,
        FechaCreacion DATETIME2 NOT NULL CONSTRAINT DF_MeGustaComentariosMomentos_FechaCreacion DEFAULT SYSUTCDATETIME(),
        CONSTRAINT FK_MeGustaComentariosMomentos_Comentarios FOREIGN KEY (IdComentario) REFERENCES dbo.ComentariosMomentos(IdComentario) ON DELETE CASCADE,
        CONSTRAINT FK_MeGustaComentariosMomentos_Usuarios FOREIGN KEY (IdUsuario) REFERENCES dbo.Usuarios(IdUsuario)
    );

    CREATE UNIQUE INDEX UX_MeGustaComentariosMomentos_Comentario_Usuario
    ON dbo.MeGustaComentariosMomentos(IdComentario, IdUsuario);
END;
GO
