CREATE TABLE [dbo].[patient_registration] (
   [pa_reg_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [src_id] [smallint] NOT NULL,
   [pincode] [varchar](20) NOT NULL,
   [dr_id] [int] NOT NULL,
   [token] [varchar](30) NOT NULL,
   [reg_date] [smalldatetime] NOT NULL,
   [exp_date] [smalldatetime] NULL,
   [last_update_date] [datetime] NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL

   ,CONSTRAINT [PK_patient_registration] PRIMARY KEY CLUSTERED ([pa_reg_id])
)

CREATE NONCLUSTERED INDEX [IX_patient_registration] ON [dbo].[patient_registration] ([pa_id], [src_id], [pincode], [exp_date] DESC)

GO
