CREATE TABLE [dbo].[PromptEventTriggerParseRuleOptions] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [startCharacter] [int] NULL,
   [numberCharacters] [int] NULL

   ,CONSTRAINT [PK_PromptEventTriggerParseRuleOptions] PRIMARY KEY CLUSTERED ([objectId])
)


GO
