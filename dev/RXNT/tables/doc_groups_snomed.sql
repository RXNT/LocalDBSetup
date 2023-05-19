CREATE TABLE [dbo].[doc_groups_snomed] (
   [snom_id] [int] NOT NULL
      IDENTITY (1,1),
   [Name] [nvarchar](500) NOT NULL,
   [SnomedCode] [nvarchar](50) NOT NULL,
   [Category] [varchar](100) NULL,
   [dg_id] [int] NULL

   ,CONSTRAINT [PK__doc_grou__9519E6C2002334C4] PRIMARY KEY CLUSTERED ([snom_id])
)


GO
