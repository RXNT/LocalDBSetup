CREATE TABLE [dbo].[prescription_details_change_log] (
   [pd_id] [int] NOT NULL,
   [pd_change_date] [smalldatetime] NOT NULL,
   [pres_id] [int] NOT NULL,
   [ddid] [int] NOT NULL,
   [drug_name] [varchar](125) NOT NULL,
   [ndc] [varchar](11) NULL,
   [actual] [int] NULL,
   [dosage] [varchar](255) NOT NULL,
   [use_generic] [bit] NOT NULL,
   [numb_refills] [int] NOT NULL,
   [duration_amount] [varchar](10) NULL,
   [duration_unit] [varchar](80) NULL,
   [comments] [varchar](255) NOT NULL,
   [prn] [bit] NOT NULL,
   [as_directed] [bit] NOT NULL,
   [drug_version] [varchar](10) NOT NULL,
   [history_enabled] [bit] NOT NULL,
   [patient_delivery_method] [smallint] NULL,
   [vps_pres_id] [varchar](10) NULL,
   [fax_conf_send_date] [datetime] NULL,
   [fax_conf_numb_pages] [int] NULL,
   [fax_conf_remote_fax_id] [varchar](100) NULL,
   [fax_conf_error_string] [varchar](600) NULL,
   [include_in_print] [bit] NULL,
   [include_in_pharm_deliver] [bit] NULL,
   [pres_read_date] [datetime] NULL,
   [fill_date] [datetime] NULL

   ,CONSTRAINT [PK_prescription_details_change_log] PRIMARY KEY CLUSTERED ([pd_id])
)


GO
