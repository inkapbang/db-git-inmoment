CREATE TABLE [dbo].[DataField] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [fieldType] [int] NOT NULL,
   [systemField] [bit] NOT NULL
       DEFAULT (0),
   [organizationObjectId] [int] NULL,
   [name] [varchar](50) NOT NULL,
   [readOnly] [bit] NOT NULL
       DEFAULT (0),
   [scorePointsPossible] [float] NULL,
   [scoreType] [int] NULL,
   [locationCategoryTypeObjectId] [int] NULL,
   [version] [int] NOT NULL,
   [defaultGoalObjectId] [int] NULL,
   [encrypted] [bit] NULL,
   [enabled] [bit] NULL,
   [scriptBindingName] [varchar](40) NULL,
   [personalInfo] [bit] NOT NULL
       DEFAULT ((0)),
   [labelObjectId] [int] NOT NULL,
   [textObjectId] [int] NOT NULL,
   [formatter] [int] NOT NULL
       DEFAULT ((0)),
   [visibleInDetail] [bit] NOT NULL,
   [encryptiontype] [tinyint] NULL
       DEFAULT ((0)),
   [reversed] [bit] NOT NULL
       DEFAULT ((0)),
   [reportHierarchyMapObjectId] [int] NULL,
   [answerType] [int] NULL,
   [upliftModelObjectId] [int] NULL,
   [optionDisplayMode] [int] NULL,
   [periodObjectId] [int] NULL,
   [ordinalOffset] [int] NULL,
   [definedLength] [int] NULL,
   [entityType] [int] NULL,
   [required] [bit] NULL,
   [scale] [int] NULL,
   [sequence] [int] NULL,
   [standardField] [bit] NULL,
   [showLabel] [bit] NULL,
   [surveyDataFieldId] [int] NULL,
   [userEditable] [bit] NULL,
   [visible] [bit] NULL,
   [purgeSurveyAnswer] [bit] NULL,
   [segmentTypeObjectId] [int] NULL,
   [runtimeComputed] [bit] NULL,
   [computeByRow] [bit] NULL,
   [requireAllComponents] [bit] NULL,
   [externalId] [varchar](255) NULL

   ,CONSTRAINT [PK_DataField] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UK_DataField_Label] UNIQUE NONCLUSTERED ([labelObjectId])
   ,CONSTRAINT [UK_DataField_Text] UNIQUE NONCLUSTERED ([textObjectId])
)

CREATE NONCLUSTERED INDEX [IX_DataField_by_Organization_fieldType_name] ON [dbo].[DataField] ([organizationObjectId], [fieldType], [name])
CREATE NONCLUSTERED INDEX [IX_DataField_by_Organization_scriptBindingName_name] ON [dbo].[DataField] ([organizationObjectId], [scriptBindingName], [name])
CREATE NONCLUSTERED INDEX [IX_DataField_by_scriptBindingName_Organization] ON [dbo].[DataField] ([scriptBindingName], [organizationObjectId]) INCLUDE ([fieldType], [name])
CREATE NONCLUSTERED INDEX [IX_DataField_by_systemField] ON [dbo].[DataField] ([systemField])
CREATE NONCLUSTERED INDEX [IX_DataField_defaultGoalObjectId] ON [dbo].[DataField] ([defaultGoalObjectId])
CREATE NONCLUSTERED INDEX [ix_Datafield_fieldtype] ON [dbo].[DataField] ([fieldType], [organizationObjectId]) INCLUDE ([objectId], [systemField], [name], [scorePointsPossible], [scoreType], [locationCategoryTypeObjectId], [version], [defaultGoalObjectId], [encrypted], [enabled], [scriptBindingName], [personalInfo], [labelObjectId], [textObjectId], [formatter], [visibleInDetail], [reversed], [reportHierarchyMapObjectId])
CREATE NONCLUSTERED INDEX [IX_DataField_fieldType_organizati8onObjectId] ON [dbo].[DataField] ([fieldType], [organizationObjectId]) INCLUDE ([objectId], [systemField], [name], [scorePointsPossible], [scoreType], [locationCategoryTypeObjectId], [version], [defaultGoalObjectId], [encrypted], [enabled], [scriptBindingName], [personalInfo], [labelObjectId], [textObjectId], [formatter], [visibleInDetail], [reversed], [answerType], [upliftModelObjectId], [optionDisplayMode], [periodObjectId], [ordinalOffset], [definedLength], [entityType], [required], [scale], [sequence], [standardField], [showLabel], [userEditable], [visible], [purgeSurveyAnswer])
CREATE NONCLUSTERED INDEX [IX_DataField_fieldType_organizationObjectId] ON [dbo].[DataField] ([fieldType], [organizationObjectId]) INCLUDE ([objectId], [systemField], [name], [scorePointsPossible], [scoreType], [locationCategoryTypeObjectId], [version], [defaultGoalObjectId], [encrypted], [enabled], [scriptBindingName], [personalInfo], [labelObjectId], [textObjectId], [formatter], [visibleInDetail], [reversed])
CREATE NONCLUSTERED INDEX [IX_DataField_fieldType_organizationObjectId2] ON [dbo].[DataField] ([fieldType], [organizationObjectId]) INCLUDE ([objectId], [systemField], [name], [scorePointsPossible], [scoreType], [locationCategoryTypeObjectId], [version], [defaultGoalObjectId], [encrypted], [enabled], [scriptBindingName], [personalInfo], [labelObjectId], [textObjectId], [formatter], [visibleInDetail], [reversed], [reportHierarchyMapObjectId], [answerType])
CREATE NONCLUSTERED INDEX [IX_DataField_fieldType_organizationObjectId3] ON [dbo].[DataField] ([fieldType], [organizationObjectId]) INCLUDE ([objectId], [systemField], [name], [scorePointsPossible], [scoreType], [locationCategoryTypeObjectId], [version], [defaultGoalObjectId], [encrypted], [enabled], [scriptBindingName], [personalInfo], [labelObjectId], [textObjectId], [formatter], [visibleInDetail], [reversed], [answerType], [upliftModelObjectId], [optionDisplayMode], [periodObjectId], [ordinalOffset], [definedLength], [entityType], [required], [scale], [sequence], [standardField], [showLabel], [userEditable], [visible], [purgeSurveyAnswer], [segmentTypeObjectId])
CREATE NONCLUSTERED INDEX [IX_DataField_fieldType2_organizationObjectId] ON [dbo].[DataField] ([fieldType], [organizationObjectId]) INCLUDE ([objectId], [systemField], [name], [scorePointsPossible], [scoreType], [locationCategoryTypeObjectId], [version], [defaultGoalObjectId], [encrypted], [enabled], [scriptBindingName], [personalInfo], [labelObjectId], [textObjectId], [formatter], [visibleInDetail], [reversed], [reportHierarchyMapObjectId], [answerType], [upliftModelObjectId], [optionDisplayMode])
CREATE NONCLUSTERED INDEX [IX_DataField_FieldTypeOrgID] ON [dbo].[DataField] ([fieldType], [organizationObjectId]) INCLUDE ([objectId], [systemField], [name], [scorePointsPossible], [scoreType], [locationCategoryTypeObjectId], [version], [defaultGoalObjectId], [encrypted], [enabled], [scriptBindingName], [personalInfo], [labelObjectId], [textObjectId], [formatter])
CREATE NONCLUSTERED INDEX [IX_Datafield_FieldtypeOrgidTextid] ON [dbo].[DataField] ([fieldType], [organizationObjectId], [textObjectId]) INCLUDE ([objectId], [systemField], [name], [scorePointsPossible])
CREATE NONCLUSTERED INDEX [IX_DataField_locationCategoryTypeObjectId] ON [dbo].[DataField] ([locationCategoryTypeObjectId])
CREATE NONCLUSTERED INDEX [IX_DataField_organizationObjectId] ON [dbo].[DataField] ([organizationObjectId]) INCLUDE ([objectId], [fieldType], [systemField], [name], [scorePointsPossible], [scoreType], [locationCategoryTypeObjectId], [version], [defaultGoalObjectId], [encrypted], [enabled], [scriptBindingName], [personalInfo], [labelObjectId], [textObjectId], [formatter], [visibleInDetail], [reversed])
CREATE NONCLUSTERED INDEX [IX_DataField_organizationObjectId2] ON [dbo].[DataField] ([organizationObjectId]) INCLUDE ([objectId], [fieldType], [systemField], [name], [scorePointsPossible], [scoreType], [locationCategoryTypeObjectId], [version], [defaultGoalObjectId], [encrypted], [enabled], [scriptBindingName], [personalInfo], [labelObjectId], [textObjectId], [formatter], [visibleInDetail], [reversed], [answerType], [upliftModelObjectId], [optionDisplayMode], [periodObjectId], [ordinalOffset], [definedLength], [entityType], [required], [scale], [sequence], [standardField], [showLabel], [userEditable], [visible], [purgeSurveyAnswer], [segmentTypeObjectId])
CREATE NONCLUSTERED INDEX [IX_DataField_Period] ON [dbo].[DataField] ([periodObjectId])
CREATE NONCLUSTERED INDEX [IX_DataField_personalInfo] ON [dbo].[DataField] ([personalInfo])
CREATE NONCLUSTERED INDEX [IX_DataField_ReportHierarchyMap] ON [dbo].[DataField] ([reportHierarchyMapObjectId])
CREATE NONCLUSTERED INDEX [IX_DataField_SegmentTypeObjectID] ON [dbo].[DataField] ([segmentTypeObjectId])
CREATE NONCLUSTERED INDEX [IX_DataField_surveyDataFieldId] ON [dbo].[DataField] ([surveyDataFieldId])
CREATE NONCLUSTERED INDEX [IX_DataField_UpliftModel] ON [dbo].[DataField] ([upliftModelObjectId])
CREATE NONCLUSTERED INDEX [ix_DatafieldOrganizationobjectid] ON [dbo].[DataField] ([organizationObjectId]) INCLUDE ([objectId], [fieldType], [systemField], [name], [scorePointsPossible], [scoreType], [locationCategoryTypeObjectId], [version], [defaultGoalObjectId], [encrypted], [enabled], [scriptBindingName], [personalInfo], [labelObjectId], [textObjectId], [formatter], [visibleInDetail], [reversed], [reportHierarchyMapObjectId])
CREATE NONCLUSTERED INDEX [IX_indx_DataField_fieldType_organizationObjectId] ON [dbo].[DataField] ([fieldType], [organizationObjectId]) INCLUDE ([objectId], [systemField], [name], [scorePointsPossible], [scoreType], [locationCategoryTypeObjectId], [version], [defaultGoalObjectId], [encrypted], [enabled], [scriptBindingName], [personalInfo], [labelObjectId], [textObjectId], [formatter], [visibleInDetail], [reversed], [reportHierarchyMapObjectId], [answerType], [upliftModelObjectId], [optionDisplayMode], [periodObjectId], [ordinalOffset])

GO
