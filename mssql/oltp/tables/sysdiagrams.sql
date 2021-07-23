CREATE TABLE [dbo].[sysdiagrams] (
   [name] [nvarchar](128) NOT NULL,
   [principal_id] [int] NOT NULL,
   [diagram_id] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NULL,
   [definition] [varbinary](max) NULL

   ,CONSTRAINT [PK__sysdiagrams__1F702C3D] PRIMARY KEY CLUSTERED ([diagram_id])
   ,CONSTRAINT [UK_principal_name] UNIQUE NONCLUSTERED ([principal_id], [name])
)


GO
