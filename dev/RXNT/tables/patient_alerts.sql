CREATE TABLE [dbo].[patient_alerts] (
   [rule_prf_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [rule_id] [int] NOT NULL,
   [dt_performed] [smalldatetime] NULL,
   [dr_performed_by] [int] NULL,
   [alert_response] [smallint] NULL,
   [notes] [varchar](max) NULL,
   [Status] [varchar](50) NULL

   ,CONSTRAINT [PK_patient_alerts] PRIMARY KEY CLUSTERED ([rule_prf_id])
)

CREATE NONCLUSTERED INDEX [_dta_index_patient_alerts_7_756301854__K4_K1_K2] ON [dbo].[patient_alerts] ([dt_performed], [rule_prf_id], [pa_id])
CREATE NONCLUSTERED INDEX [IX_patient_alerts] ON [dbo].[patient_alerts] ([pa_id])
CREATE NONCLUSTERED INDEX [IX_Patient_Alerts-Rule_id] ON [dbo].[patient_alerts] ([rule_id]) INCLUDE ([dt_performed], [pa_id])

GO
