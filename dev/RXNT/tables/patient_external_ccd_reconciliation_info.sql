CREATE TABLE [dbo].[patient_external_ccd_reconciliation_info] (
   [reconciliation_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [dg_id] [int] NOT NULL,
   [dc_id] [int] NOT NULL,
   [is_medication_reconciled] [bit] NULL,
   [is_allergy_reconciled] [bit] NULL,
   [is_problem_reconciled] [bit] NULL,
   [date_added] [datetime] NOT NULL,
   [added_by_dr_id] [int] NOT NULL

   ,CONSTRAINT [PK_patient_external_ccd_reconciliation_info] PRIMARY KEY CLUSTERED ([reconciliation_id])
)

CREATE NONCLUSTERED INDEX [IX_patient_external_ccd_reconciliation_info] ON [dbo].[patient_external_ccd_reconciliation_info] ([pa_id])

GO
