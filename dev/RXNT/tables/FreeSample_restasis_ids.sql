CREATE TABLE [dbo].[FreeSample_restasis_ids] (
   [ID] [varchar](100) NOT NULL,
   [is_valid] [bit] NULL,
   [SampleIdXref] [int] NOT NULL

   ,CONSTRAINT [PK_FreeSample_restasis_ids] PRIMARY KEY NONCLUSTERED ([ID])
)


GO
