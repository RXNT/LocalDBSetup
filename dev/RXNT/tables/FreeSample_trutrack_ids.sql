CREATE TABLE [dbo].[FreeSample_trutrack_ids] (
   [ID] [varchar](100) NOT NULL,
   [is_valid] [bit] NULL,
   [SampleIdXref] [int] NOT NULL

   ,CONSTRAINT [PK_FreeSample_trutrack_ids] PRIMARY KEY NONCLUSTERED ([ID])
)

CREATE CLUSTERED INDEX [IX_MAIN] ON [dbo].[FreeSample_trutrack_ids] ([ID], [is_valid])

GO
