USE RedSocialDB;
GO

-- 019 - Permite guardar hasta 10 rutas de imagen en una sola publicación.
-- Para mantener compatibilidad, una sola imagen continúa guardándose como una ruta normal;
-- varias imágenes se guardan como un arreglo JSON en Momentos.ArchivoUrl.
IF COL_LENGTH('dbo.Momentos', 'ArchivoUrl') IS NOT NULL
BEGIN
    IF EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID('dbo.Momentos') AND name = 'IX_Momentos_Activo_Texto_Fecha')
        DROP INDEX IX_Momentos_Activo_Texto_Fecha ON dbo.Momentos;

    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER ON;
    SET ANSI_PADDING ON;
    SET ANSI_WARNINGS ON;
    SET CONCAT_NULL_YIELDS_NULL ON;
    SET ARITHABORT ON;
    SET NUMERIC_ROUNDABORT OFF;
    ALTER TABLE dbo.Momentos ALTER COLUMN ArchivoUrl NVARCHAR(MAX) NULL;

    CREATE INDEX IX_Momentos_Activo_Texto_Fecha
        ON dbo.Momentos (Activo, FechaCreacion)
        INCLUDE (Texto, IdUsuario, TipoAdjunto, LinkUrl, TotalMeGusta, TotalComentarios);
END;
GO
