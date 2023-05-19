CREATE TABLE [dbo].[rxnttemprx] (
   [pres_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [dg_id] [int] NOT NULL,
   [pharm_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [pres_entry_date] [datetime] NULL,
   [pres_read_date] [datetime] NULL,
   [only_faxed] [bit] NULL,
   [pharm_viewed] [bit] NOT NULL,
   [off_dr_list] [bit] NOT NULL,
   [opener_user_id] [int] NOT NULL,
   [pres_is_refill] [bit] NOT NULL,
   [rx_number] [varchar](50) NOT NULL,
   [last_pharm_name] [varchar](80) NOT NULL,
   [last_pharm_address] [varchar](50) NOT NULL,
   [last_pharm_city] [varchar](30) NOT NULL,
   [last_pharm_state] [varchar](30) NOT NULL,
   [last_pharm_phone] [varchar](30) NOT NULL,
   [pharm_state_holder] [varchar](50) NOT NULL,
   [pharm_city_holder] [varchar](50) NOT NULL,
   [pharm_id_holder] [varchar](20) NOT NULL,
   [fax_conf_send_date] [datetime] NULL,
   [fax_conf_numb_pages] [int] NULL,
   [fax_conf_remote_fax_id] [varchar](100) NULL,
   [fax_conf_error_string] [varchar](600) NULL,
   [pres_delivery_method] [int] NULL,
   [prim_dr_id] [int] NOT NULL,
   [print_count] [int] NOT NULL,
   [pda_written] [bit] NOT NULL,
   [authorizing_dr_id] [int] NULL,
   [sfi_is_sfi] [bit] NOT NULL,
   [sfi_pres_id] [varchar](50) NULL,
   [field_not_used1] [int] NULL,
   [admin_notes] [varchar](600) NULL,
   [pres_approved_date] [datetime] NULL,
   [pres_void] [bit] NULL,
   [last_edit_date] [datetime] NULL,
   [last_edit_dr_id] [int] NULL,
   [pres_prescription_type] [int] NULL,
   [pres_void_comments] [varchar](255) NULL,
   [eligibility_checked] [bit] NULL,
   [eligibility_trans_id] [int] NULL,
   [off_pharm_list] [bit] NOT NULL,
   [DoPrintAfterPatHistory] [bit] NOT NULL,
   [DoPrintAfterPatOrig] [bit] NOT NULL,
   [DoPrintAfterPatCopy] [bit] NOT NULL,
   [DoPrintAfterPatMonograph] [bit] NOT NULL,
   [PatOrigPrintType] [int] NOT NULL,
   [PrintHistoryBackMonths] [int] NOT NULL,
   [DoPrintAfterScriptGuide] [bit] NOT NULL,
   [approve_source] [varchar](1) NULL,
   [pres_void_code] [smallint] NULL,
   [send_count] [smallint] NOT NULL,
   [print_options] [int] NOT NULL,
   [writing_dr_id] [int] NULL,
   [presc_src] [tinyint] NULL

   ,CONSTRAINT [PK_rxnttemprx] PRIMARY KEY CLUSTERED ([pres_id])
)


GO