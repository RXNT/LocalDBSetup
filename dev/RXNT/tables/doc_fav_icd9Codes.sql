CREATE TABLE [dbo].[doc_fav_icd9Codes] (
   [fICD9Codes_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [icd9Code] [varchar](50) NOT NULL,
   [icd9Descriptor] [varchar](1000) NOT NULL,
   [Icd10Code] [varchar](50) NULL,
   [Icd10Descriptor] [varchar](1000) NULL

   ,CONSTRAINT [PK_doc_fav_icd9Codes] PRIMARY KEY CLUSTERED ([fICD9Codes_id])
)

CREATE NONCLUSTERED INDEX [uq_doc_fav_icd9Codes] ON [dbo].[doc_fav_icd9Codes] ([dr_id], [icd9Code])

GO
