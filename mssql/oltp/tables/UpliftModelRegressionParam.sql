CREATE TABLE [dbo].[UpliftModelRegressionParam] (
   [regressionObjectId] [int] NOT NULL,
   [paramType] [int] NOT NULL,
   [dataFieldObjectId] [int] NOT NULL,
   [ordinalLevel] [int] NOT NULL,
   [value] [float] NOT NULL

   ,CONSTRAINT [PK_UpliftModelRegressionParam] PRIMARY KEY CLUSTERED ([regressionObjectId], [dataFieldObjectId], [ordinalLevel], [paramType])
)


GO
