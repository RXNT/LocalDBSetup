CREATE TABLE [dbo].[patient_lab_orders_master] (
   [lab_master_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [pa_id] [bigint] NOT NULL,
   [added_date] [datetime] NOT NULL,
   [added_by] [bigint] NOT NULL,
   [order_date] [datetime] NOT NULL,
   [order_status] [smallint] NOT NULL,
   [comments] [varchar](500) NOT NULL,
   [last_edit_by] [bigint] NOT NULL,
   [last_edit_date] [datetime] NOT NULL,
   [dr_id] [bigint] NULL,
   [isActive] [bit] NULL,
   [external_lab_order_id] [varchar](50) NULL,
   [doc_group_lab_xref_id] [int] NULL,
   [abn_file_path] [varchar](255) NULL,
   [requisition_file_path] [varchar](255) NULL,
   [label_file_path] [varchar](255) NULL,
   [lab_id] [int] NULL,
   [order_sent_date] [datetime] NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [ScalabullLogId] [int] NULL

   ,CONSTRAINT [PK_patient_lab_orders_master] PRIMARY KEY CLUSTERED ([lab_master_id])
)


GO
