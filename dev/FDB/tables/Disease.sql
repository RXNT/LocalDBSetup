CREATE TABLE [dbo].[Disease] (
   [ICD9] [varchar](6) NULL,
   [Description] [varchar](80) NULL

)

CREATE CLUSTERED INDEX [MAIN_INDX] ON [dbo].[Disease] ([ICD9], [Description])

GO
