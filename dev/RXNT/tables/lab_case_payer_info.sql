CREATE TABLE [dbo].[lab_case_payer_info] (
   [case_payer_id] [int] NOT NULL,
   [insurance_type] [int] NULL,
   [workers_comp] [bit] NULL,
   [pa_id] [bigint] NOT NULL,
   [ApplicationId] [int] NOT NULL

   ,CONSTRAINT [PK_lab_case_payer_info] PRIMARY KEY CLUSTERED ([case_payer_id])
)


GO
