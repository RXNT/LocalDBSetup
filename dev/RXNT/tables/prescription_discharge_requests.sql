CREATE TABLE [dbo].[prescription_discharge_requests] (
   [discharge_request_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [pres_id] [bigint] NOT NULL,
   [created_by] [bigint] NOT NULL,
   [created_on] [datetime] NOT NULL,
   [approved_by] [bigint] NULL,
   [approved_on] [datetime] NULL,
   [is_active] [bit] NOT NULL,
   [last_modified_by] [bigint] NULL,
   [last_modified_on] [datetime] NULL,
   [voided_by] [bigint] NULL,
   [voided_on] [datetime] NULL,
   [voided_reason] [varchar](255) NULL,
   [discharge_reason] [varchar](255) NULL,
   [requested_to] [int] NULL

   ,CONSTRAINT [PK_prescription_discharge_requests] PRIMARY KEY CLUSTERED ([discharge_request_id])
)

CREATE NONCLUSTERED INDEX [ix_prescription_discharge_requests_approved_by_approved_on_is_active] ON [dbo].[prescription_discharge_requests] ([approved_by], [approved_on], [is_active]) INCLUDE ([discharge_request_id], [pres_id])
CREATE NONCLUSTERED INDEX [ix_prescription_discharge_requests_pres_id_approved_by_includes] ON [dbo].[prescription_discharge_requests] ([pres_id], [approved_by]) INCLUDE ([discharge_request_id])

GO
