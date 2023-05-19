CREATE TABLE [dbo].[patient_lab_orders] (
   [pa_lab_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [pa_id] [bigint] NOT NULL,
   [lab_test_id] [int] NOT NULL,
   [lab_test_name] [varchar](500) NOT NULL,
   [added_date] [datetime] NOT NULL,
   [added_by] [bigint] NOT NULL,
   [order_date] [datetime] NOT NULL,
   [order_status] [smallint] NOT NULL,
   [comments] [varchar](500) NOT NULL,
   [last_edit_by] [bigint] NOT NULL,
   [last_edit_date] [datetime] NOT NULL,
   [from_main_lab_id] [bigint] NOT NULL,
   [recurringinformation] [varchar](500) NULL,
   [diagnosis] [varchar](5000) NULL,
   [urgency] [smallint] NOT NULL,
   [dr_id] [bigint] NULL,
   [isActive] [bit] NULL,
   [sendElectronically] [bit] NULL,
   [external_lab_order_id] [varchar](50) NULL,
   [doc_group_lab_xref_id] [int] NULL,
   [abn_file_path] [varchar](255) NULL,
   [requisition_file_path] [varchar](255) NULL,
   [label_file_path] [varchar](255) NULL,
   [enc_id] [bigint] NULL,
   [lab_master_id] [bigint] NULL,
   [lab_id] [int] NULL,
   [lab_result_info_id] [int] NULL,
   [specimen_time] [datetime] NULL,
   [test_type] [smallint] NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [ScalabullLogId] [bigint] NULL,
   [loinc_code] [varchar](10) NULL,
   [snomed_codes] [varchar](255) NULL,
   [VisibilityHiddenToPatient] [bit] NULL

   ,CONSTRAINT [PK_patient_lab_orders] PRIMARY KEY CLUSTERED ([pa_lab_id])
)

CREATE NONCLUSTERED INDEX [ix_patient_lab_orders_lab_master_id] ON [dbo].[patient_lab_orders] ([lab_master_id])
CREATE NONCLUSTERED INDEX [ix_patient_lab_orders_pa_id_isActive] ON [dbo].[patient_lab_orders] ([pa_id], [isActive])

GO
