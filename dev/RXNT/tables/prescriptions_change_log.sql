CREATE TABLE [dbo].[prescriptions_change_log] (
   [pres_id] [int] NOT NULL,
   [pres_change_date] [smalldatetime] NOT NULL,
   [dr_id] [int] NOT NULL,
   [dg_id] [int] NOT NULL,
   [pharm_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [pres_entry_date] [datetime] NULL,
   [pres_read_date] [datetime] NULL,
   [only_faxed] [bit] NULL,
   [pharm_viewed] [bit] NOT NULL,
   [opener_user_id] [int] NOT NULL,
   [rx_number] [varchar](50) NOT NULL,
   [fax_conf_send_date] [datetime] NULL,
   [fax_conf_numb_pages] [int] NULL,
   [fax_conf_remote_fax_id] [varchar](100) NULL,
   [fax_conf_error_string] [varchar](600) NULL,
   [pres_delivery_method] [int] NULL,
   [prim_dr_id] [int] NOT NULL,
   [print_count] [int] NOT NULL,
   [pda_written] [bit] NOT NULL,
   [authorizing_dr_id] [int] NULL,
   [admin_notes] [varchar](600) NULL,
   [pres_approved_date] [datetime] NULL,
   [pres_void] [bit] NULL,
   [last_edit_date] [datetime] NULL,
   [last_edit_dr_id] [int] NULL,
   [pres_prescription_type] [int] NULL,
   [pres_void_comments] [varchar](255) NULL

   ,CONSTRAINT [PK_prescriptions_change_log] PRIMARY KEY CLUSTERED ([pres_id])
)


GO
