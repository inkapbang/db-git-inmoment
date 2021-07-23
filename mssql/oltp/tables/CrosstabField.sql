CREATE TABLE [dbo].[CrosstabField] (
   [objectId] [bigint] NOT NULL
      IDENTITY (1,1),
   [crosstabFieldType] [int] NOT NULL,
   [pageObjectId] [int] NOT NULL,
   [labelObjectId] [int] NOT NULL,
   [dataFieldObjectId] [int] NOT NULL,
   [sequence] [int] NOT NULL,
   [totalType] [int] NULL,
   [totalPrecision] [int] NULL,
   [formatter] [int] NULL,
   [backgroundColor] [char](6) NULL,
   [alignment] [int] NULL,
   [commentPresentationOption] [int] NULL,
   [conditionalFormattingType] [int] NULL,
   [conditionalFormattingMinColor] [char](6) NULL,
   [conditionalFormattingMaxColor] [char](6) NULL,
   [conditionalFormattingMin] [float] NULL,
   [conditionalFormattingMax] [float] NULL,
   [version] [int] NOT NULL,
   [inclusionType] [int] NULL

   ,CONSTRAINT [PK_CrosstabField] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [CrosstabField_dataFieldObjectId] ON [dbo].[CrosstabField] ([dataFieldObjectId])
CREATE NONCLUSTERED INDEX [CrosstabField_labelObjectId] ON [dbo].[CrosstabField] ([labelObjectId])
CREATE NONCLUSTERED INDEX [CrosstabField_pageObjectId] ON [dbo].[CrosstabField] ([pageObjectId])

GO
