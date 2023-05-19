CREATE TABLE [dbo].[patient_reg_db] (
   [pat_reg_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [pincode] [varchar](20) NOT NULL,
   [date_created] [datetime] NOT NULL,
   [src_type] [smallint] NULL,
   [opt_out] [bit] NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL

   ,CONSTRAINT [PK_patient_reg_db] PRIMARY KEY CLUSTERED ([pat_reg_id])
)

CREATE NONCLUSTERED INDEX [IX_patient_reg_db] ON [dbo].[patient_reg_db] ([dr_id], [pa_id], [pincode])
CREATE NONCLUSTERED INDEX [ix_patient_reg_db_pa_id] ON [dbo].[patient_reg_db] ([pa_id])

GO
