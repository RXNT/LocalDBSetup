CREATE TABLE [dbo].[prescription_discharge_external_info] (
   [pdei_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [pres_id] [bigint] NOT NULL,
   [pd_id] [bigint] NOT NULL,
   [discharge_request_id] [bigint] NOT NULL,
   [batch_id] [varchar](50) NULL,
   [external_source_syncdate] [datetime] NULL,
   [response_status] [varchar](500) NULL,
   [last_modified_by] [bigint] NULL,
   [last_modified_date] [datetime] NULL

   ,CONSTRAINT [PK_prescription_discharge_external_info] PRIMARY KEY CLUSTERED ([pdei_id])
)

CREATE NONCLUSTERED INDEX [ix_prescription_discharge_external_info_pres_id_includes] ON [dbo].[prescription_discharge_external_info] ([pres_id]) INCLUDE ([pdei_id])

GO
