CREATE TABLE [dbo].[patient_measure_compliance] (
   [rec_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [src_dr_id] [int] NOT NULL,
   [rec_type] [smallint] NOT NULL,
   [rec_date] [smalldatetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL

   ,CONSTRAINT [PK_patient_measure_compliance] PRIMARY KEY CLUSTERED ([rec_id])
)

CREATE NONCLUSTERED INDEX [_dta_index_patient_measure_compliance_7_1714925281__K2_K5_K6_1] ON [dbo].[patient_measure_compliance] ([pa_id], [rec_type], [rec_date]) INCLUDE ([rec_id])
CREATE NONCLUSTERED INDEX [IX_patient_measure_compliance] ON [dbo].[patient_measure_compliance] ([pa_id], [dr_id], [rec_date])
CREATE NONCLUSTERED INDEX [IX_patient_measure_compliance-dr_id-rec_type-rec_date] ON [dbo].[patient_measure_compliance] ([dr_id], [rec_type], [rec_date]) INCLUDE ([pa_id])

GO
