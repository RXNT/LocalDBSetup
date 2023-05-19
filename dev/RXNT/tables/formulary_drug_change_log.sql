CREATE TABLE [dbo].[formulary_drug_change_log] (
   [fm_log_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [orig_drug_id] [int] NOT NULL,
   [new_drug_id] [int] NOT NULL,
   [new_drug_form_stat] [int] NOT NULL,
   [date] [datetime] NOT NULL,
   [pa_id] [int] NOT NULL,
   [orig_drug_form_stat] [int] NOT NULL

   ,CONSTRAINT [PK_formulary_drug_change_log] PRIMARY KEY CLUSTERED ([fm_log_id])
)

CREATE NONCLUSTERED INDEX [_dta_index_formulary_drug_change_log_7_359060415__K6_K2_3_4] ON [dbo].[formulary_drug_change_log] ([date], [dr_id]) INCLUDE ([orig_drug_id], [new_drug_id])

GO
