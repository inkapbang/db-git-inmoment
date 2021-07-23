CREATE TABLE [dbo].[UserAccountLocationSnapshot] (
   [userAccountObjectId] [int] NOT NULL,
   [locationObjectId] [int] NOT NULL,
   [hierarchySnapshotObjectId] [int] NOT NULL

)

CREATE NONCLUSTERED INDEX [I_FK_UserAccountLocationSnapshot_hierarchySnapshotObjectId] ON [dbo].[UserAccountLocationSnapshot] ([hierarchySnapshotObjectId])
CREATE NONCLUSTERED INDEX [I_FK_UserAccountLocationSnapshot_Location] ON [dbo].[UserAccountLocationSnapshot] ([locationObjectId])
CREATE NONCLUSTERED INDEX [I_FK_UserAccountLocationSnapshot_UserAccountObjectId] ON [dbo].[UserAccountLocationSnapshot] ([userAccountObjectId])

GO
