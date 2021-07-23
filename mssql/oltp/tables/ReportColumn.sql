CREATE TABLE [dbo].[ReportColumn] (
   [objectid] [int] NOT NULL
      IDENTITY (1,1),
   [pageObjectId] [int] NULL,
   [totalType] [int] NOT NULL,
   [sequence] [int] NULL,
   [subtotalColumn] [bit] NULL,
   [sortOrder] [int] NULL,
   [sortDescending] [bit] NULL,
   [totalOnlyOnInnermostGroup] [bit] NULL,
   [goalObjectId] [int] NULL,
   [version] [int] NOT NULL
       DEFAULT (0),
   [DataFieldObjectId] [int] NOT NULL,
   [totalPrecision] [int] NOT NULL
       DEFAULT (1),
   [backgroundColor] [char](6) NULL,
   [widthPercent] [int] NULL,
   [alignment] [int] NULL,
   [formatter] [int] NOT NULL
       DEFAULT ((0)),
   [columnComputationObjectId] [int] NULL,
   [labelObjectId] [int] NOT NULL,
   [hidden] [bit] NULL,
   [drillDownTargetPageObjectId] [int] NULL,
   [commentPresentationOption] [int] NOT NULL
       DEFAULT ((0)),
   [conditionalFormattingType] [int] NULL
       DEFAULT ((0)),
   [conditionalFormattingMinColor] [varchar](6) NULL,
   [conditionalFormattingMaxColor] [varchar](6) NULL,
   [conditionalFormattingMin] [float] NULL,
   [conditionalFormattingMax] [float] NULL,
   [conditionalFormattingStartWithColor] [bit] NULL
       DEFAULT ((0)),
   [hideDefaultGroup] [bit] NULL,
   [parentDataFieldObjectId] [int] NULL,
   [displayDirtyWords] [tinyint] NOT NULL
      CONSTRAINT [DF_ReportColumn_displayDirtyWords] DEFAULT ((0)),
   [groupingLevels] [int] NOT NULL,
   [visibility] [tinyint] NOT NULL,
   [linkedReportTargetPageObjectId] [int] NULL,
   [dynamicDrillDown] [bit] NULL,
   [staticValue] [varchar](200) NULL,
   [staticValueType] [int] NULL,
   [dynamicDateFilter] [bit] NULL
      CONSTRAINT [D_dynamicDateFilter] DEFAULT ((0)),
   [inclusionType] [int] NULL,
   [imageSize] [int] NULL

   ,CONSTRAINT [PK_ReportColumn] PRIMARY KEY CLUSTERED ([objectid])
   ,CONSTRAINT [UK_ReportColumn_label] UNIQUE NONCLUSTERED ([labelObjectId])
)

CREATE NONCLUSTERED INDEX [IX_ReportColumn_by_DataField] ON [dbo].[ReportColumn] ([DataFieldObjectId])
CREATE NONCLUSTERED INDEX [IX_ReportColumn_by_Report] ON [dbo].[ReportColumn] ([pageObjectId]) INCLUDE ([sequence], [labelObjectId])
CREATE NONCLUSTERED INDEX [IX_ReportColumn_columnComputationObjectId] ON [dbo].[ReportColumn] ([columnComputationObjectId])
CREATE NONCLUSTERED INDEX [IX_ReportColumn_drillDownTargetPageObjectId] ON [dbo].[ReportColumn] ([drillDownTargetPageObjectId])
CREATE NONCLUSTERED INDEX [IX_ReportColumn_goalObjectId] ON [dbo].[ReportColumn] ([goalObjectId])
CREATE NONCLUSTERED INDEX [IX_ReportColumn_LinkedReportTargetPageObjectId] ON [dbo].[ReportColumn] ([linkedReportTargetPageObjectId])
CREATE NONCLUSTERED INDEX [IX_ReportColumn_pageObjectId] ON [dbo].[ReportColumn] ([pageObjectId]) INCLUDE ([objectid], [totalType], [sequence], [sortOrder], [sortDescending], [totalOnlyOnInnermostGroup], [goalObjectId], [version], [DataFieldObjectId], [totalPrecision], [backgroundColor], [widthPercent], [alignment], [formatter], [columnComputationObjectId], [labelObjectId], [commentPresentationOption], [conditionalFormattingType], [conditionalFormattingMinColor], [conditionalFormattingMaxColor], [conditionalFormattingMin], [conditionalFormattingMax], [hideDefaultGroup], [parentDataFieldObjectId], [displayDirtyWords], [groupingLevels], [visibility], [linkedReportTargetPageObjectId], [dynamicDrillDown], [staticValue], [staticValueType], [dynamicDateFilter], [inclusionType], [imageSize])

GO
