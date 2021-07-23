CREATE TABLE [dbo].[Maint_UpdateStatisticsSetting] (
   [fulltable_name] [nvarchar](261) NULL,
   [schema_name] [nvarchar](128) NULL,
   [table_name] [nvarchar](128) NOT NULL,
   [rows] [int] NULL,
   [parameterSetting] [varchar](256) NULL,
   [dateCreated] [datetime] NULL,
   [dateModified] [datetime] NULL
)


GO
