CREATE TABLE [dbo].[CategoricalTransformationRule] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [ruleType] [int] NOT NULL,
   [transformationFieldObjectId] [int] NOT NULL,
   [dataFieldOptionObjectId] [int] NOT NULL,
   [operator] [int] NOT NULL,
   [conditionValue1] [varchar](255) NULL,
   [conditionValue2] [varchar](255) NULL,
   [sequence] [int] NOT NULL

   ,CONSTRAINT [PK_CategoricalTransformationRule] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_CategoricalTransformationRule_dataFieldOptionObjectId] ON [dbo].[CategoricalTransformationRule] ([dataFieldOptionObjectId])
CREATE NONCLUSTERED INDEX [IX_CategoricalTransformationRule_transformationFieldObjectId] ON [dbo].[CategoricalTransformationRule] ([transformationFieldObjectId])

GO
