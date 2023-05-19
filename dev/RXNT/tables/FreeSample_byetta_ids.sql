CREATE TABLE [dbo].[FreeSample_byetta_ids] (
   [ID] [varchar](100) NOT NULL,
   [is_valid] [bit] NULL,
   [SampleId] [int] NOT NULL

   ,CONSTRAINT [PK_FreeSample_byetta_ids] PRIMARY KEY CLUSTERED ([ID])
)

CREATE NONCLUSTERED INDEX [IX_FreeSample_byetta_ids] ON [dbo].[FreeSample_byetta_ids] ([is_valid])

GO
