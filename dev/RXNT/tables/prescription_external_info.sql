CREATE TABLE [dbo].[prescription_external_info] (
   [pres_external_info_id] [int] NOT NULL
      IDENTITY (1,1),
   [pres_id] [int] NOT NULL,
   [pd_id] [int] NOT NULL,
   [external_order_id] [varchar](255) NOT NULL,
   [comments] [varchar](1000) NULL,
   [active] [bit] NULL,
   [created_date] [datetime] NULL,
   [created_by] [int] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [external_source_syncdate] [datetime] NULL,
   [dc_id] [int] NULL,
   [dg_id] [int] NULL,
   [response_status] [varchar](500) NULL,
   [batch_id] [varchar](50) NULL

   ,CONSTRAINT [PK_prescription_external_info] PRIMARY KEY CLUSTERED ([pres_external_info_id])
)

CREATE NONCLUSTERED INDEX [ix_prescription_external_info_dc_id_includes] ON [dbo].[prescription_external_info] ([dc_id]) INCLUDE ([batch_id], [external_source_syncdate], [pres_external_info_id], [pres_id], [response_status])
CREATE NONCLUSTERED INDEX [ix_prescription_external_info_pres_id] ON [dbo].[prescription_external_info] ([pres_id])

GO
