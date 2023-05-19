CREATE TABLE [dbo].[doc_token_info] (
   [doc_token_track_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [stage] [smallint] NOT NULL,
   [comments] [varchar](4000) NOT NULL,
   [ups_tracking_id] [varchar](500) NOT NULL,
   [ups_label_file] [varchar](50) NOT NULL,
   [shipping_fee] [float] NOT NULL,
   [shipping_address1] [varchar](255) NOT NULL,
   [shipping_city] [varchar](50) NOT NULL,
   [shipping_state] [varchar](2) NOT NULL,
   [shipping_zip] [varchar](50) NOT NULL,
   [shipping_to_name] [varchar](100) NOT NULL,
   [ship_submit_date] [datetime] NULL,
   [shipment_identification] [varchar](100) NULL,
   [email] [varchar](100) NULL,
   [idretries] [smallint] NULL,
   [maxidretries] [smallint] NULL,
   [token_serial_no] [varchar](20) NULL,
   [token_type] [int] NULL,
   [is_activated] [int] NULL,
   [IsSigRequired] [bit] NOT NULL,
   [created_by] [bigint] NULL,
   [created_on] [datetime] NULL,
   [last_edited_by] [bigint] NULL,
   [last_edited_on] [datetime] NULL,
   [shipping_address2] [varchar](255) NULL,
   [ups_file_id] [bigint] NULL

   ,CONSTRAINT [PK_doc_token_info] PRIMARY KEY CLUSTERED ([doc_token_track_id])
)


GO
