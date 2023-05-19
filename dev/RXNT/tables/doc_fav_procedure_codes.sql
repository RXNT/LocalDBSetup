CREATE TABLE [dbo].[doc_fav_procedure_codes] (
   [dr_id] [int] NOT NULL,
   [cpt_code] [varchar](50) NOT NULL,
   [created_date] [datetime] NOT NULL

   ,CONSTRAINT [PK_doc_fav_procedure_codes] PRIMARY KEY CLUSTERED ([dr_id], [cpt_code])
)


GO
