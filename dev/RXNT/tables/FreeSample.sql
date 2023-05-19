CREATE TABLE [dbo].[FreeSample] (
   [SampleId] [int] NOT NULL,
   [DrugName] [varchar](80) NOT NULL,
   [DrugId] [int] NOT NULL,
   [DrugNameMatchType] [smallint] NOT NULL,
   [StartDate] [datetime] NOT NULL,
   [EndDate] [datetime] NOT NULL,
   [filename_1] [varchar](100) NULL,
   [filename_2] [varchar](100) NULL,
   [xref_tbname] [varchar](125) NULL,
   [ptype] [smallint] NOT NULL

   ,CONSTRAINT [PK__FreeSample__53A33203] PRIMARY KEY CLUSTERED ([SampleId])
)

CREATE NONCLUSTERED INDEX [IX_MAIN] ON [dbo].[FreeSample] ([DrugName], [DrugId], [DrugNameMatchType], [StartDate], [EndDate])

GO
