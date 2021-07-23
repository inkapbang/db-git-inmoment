CREATE TABLE [dbo].[PageCriterion] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [allowChanges] [bit] NULL,
   [numericValue] [float] NULL,
   [textValue] [varchar](150) NULL,
   [timeValue] [datetime] NULL,
   [booleanValue] [bit] NULL,
   [dateRangeUnit] [int] NULL,
   [dateRangeOffset] [int] NULL,
   [operatorType] [int] NULL,
   [promptObjectId] [int] NULL,
   [version] [int] NOT NULL
       DEFAULT (0),
   [dataFieldObjectId] [int] NULL,
   [criterionType] [int] NOT NULL,
   [includeAll] [bit] NULL,
   [periodObjectId] [int] NULL,
   [singleSelect] [bit] NULL,
   [periodEditType] [int] NULL,
   [labelObjectId] [int] NOT NULL,
   [locationCategoryObjectId] [int] NULL,
   [enabledInclusionType] [int] NULL,
   [optimizable] [bit] NOT NULL
       DEFAULT ((0)),
   [relativePeriodTypeObjectId] [int] NULL,
   [relativePeriodCount] [smallint] NULL,
   [relativePeriodOffset] [smallint] NULL,
   [relativeSubPeriodTypeObjectId] [int] NULL,
   [dateSelectionType] [int] NULL,
   [relativeDisplayOption] [smallint] NULL,
   [inclusionType] [int] NULL,
   [attributeGroupObjectId] [int] NULL,
   [locationCategoryTypeObjectId] [int] NULL,
   [parentDataFieldObjectId] [int] NULL,
   [dateRangeRenderingType] [int] NULL,
   [dateListPickerMode] [bit] NULL
       DEFAULT ((0)),
   [pearModelObjectId] [int] NULL,
   [relativeSubTotalPeriodTypeObjectId] [int] NULL,
   [dynamicUnitSelectionType] [int] NULL,
   [periodTypeHierarchyObjectId] [int] NULL,
   [topLevelCount] [int] NULL,
   [dynamicUnitHistoricalHierarchies] [bit] NOT NULL
      CONSTRAINT [D_PageCriterion_dynamicUnitHistoricalHierarchies] DEFAULT ((0))

   ,CONSTRAINT [PK_PageCriterion] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UK_PageCriterion_Label] UNIQUE NONCLUSTERED ([labelObjectId])
)

CREATE NONCLUSTERED INDEX [IX_PageCriterion_dataFieldObjectId] ON [dbo].[PageCriterion] ([dataFieldObjectId])
CREATE NONCLUSTERED INDEX [IX_PageCriterion_FK__PageCrite__locat__486C4AAC] ON [dbo].[PageCriterion] ([locationCategoryTypeObjectId])
CREATE NONCLUSTERED INDEX [IX_PageCriterion_LocationAttributeGroup] ON [dbo].[PageCriterion] ([attributeGroupObjectId])
CREATE NONCLUSTERED INDEX [IX_PageCriterion_locationCategoryObjectId] ON [dbo].[PageCriterion] ([locationCategoryObjectId])
CREATE NONCLUSTERED INDEX [IX_PageCriterion_PearModel] ON [dbo].[PageCriterion] ([pearModelObjectId])
CREATE NONCLUSTERED INDEX [IX_PageCriterion_periodObjectId] ON [dbo].[PageCriterion] ([periodObjectId])
CREATE NONCLUSTERED INDEX [IX_PageCriterion_PeriodType] ON [dbo].[PageCriterion] ([relativePeriodTypeObjectId])
CREATE NONCLUSTERED INDEX [IX_PageCriterion_PeriodTypeHierarchy] ON [dbo].[PageCriterion] ([periodTypeHierarchyObjectId])
CREATE NONCLUSTERED INDEX [IX_PageCriterion_relativeSubTotalPeriodTypeObjectId] ON [dbo].[PageCriterion] ([relativeSubTotalPeriodTypeObjectId])
CREATE NONCLUSTERED INDEX [IX_PageCriterion_SubPeriodType] ON [dbo].[PageCriterion] ([relativeSubPeriodTypeObjectId])

GO
