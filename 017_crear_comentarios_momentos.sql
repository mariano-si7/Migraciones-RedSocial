USE RedSocialDB;
GO

IF OBJECT_ID('dbo.ComentariosMomentos', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.ComentariosMomentos (
        IdComentario INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_ComentariosMomentos PRIMARY KEY,
        IdMomento INT NOT NULL,
        IdUsuario INT NOT NULL,
        Texto NVARCHAR(500) NOT NULL,
        Activo BIT NOT NULL CONSTRAINT DF_ComentariosMomentos_Activo DEFAULT 1,
        FechaCreacion DATETIME2 NOT NULL CONSTRAINT DF_ComentariosMomentos_FechaCreacion DEFAULT SYSUTCDATETIME(),
        FechaEliminacion DATETIME2 NULL,
        CONSTRAINT FK_ComentariosMomentos_Momentos FOREIGN KEY (IdMomento) REFERENCES dbo.Momentos(IdMomento) ON DELETE CASCADE,
        CONSTRAINT FK_ComentariosMomentos_Usuarios FOREIGN KEY (IdUsuario) REFERENCES dbo.Usuarios(IdUsuario)
    );

    CREATE INDEX IX_ComentariosMomentos_Momento_Activo_Fecha ON dbo.ComentariosMomentos(IdMomento, Activo, FechaCreacion);
    CREATE INDEX IX_ComentariosMomentos_Usuario_Fecha ON dbo.ComentariosMomentos(IdUsuario, FechaCreacion);
END;
GO
