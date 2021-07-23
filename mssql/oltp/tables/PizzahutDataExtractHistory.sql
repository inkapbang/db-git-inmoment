CREATE TABLE [dbo].[PizzahutDataExtractHistory] (
   [objectId] [int] NULL,
   [beginDate] [datetime] NULL,
   [runDate] [datetime] NULL,
   [sent] [smallint] NULL

)

CREATE NONCLUSTERED INDEX [idx_1] ON [dbo].[PizzahutDataExtractHistory] ([objectId])
CREATE NONCLUSTERED INDEX [idx_1_beginDate] ON [dbo].[PizzahutDataExtractHistory] ([beginDate])

GO
