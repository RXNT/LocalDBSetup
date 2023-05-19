CREATE TABLE [dbo].[patient_medications_hx] (
   [pam_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [drug_id] [int] NOT NULL,
   [date_added] [datetime] NOT NULL,
   [added_by_dr_id] [int] NOT NULL,
   [from_pd_id] [int] NULL,
   [compound] [bit] NULL,
   [comments] [varchar](255) NULL,
   [status] [tinyint] NULL,
   [dt_status_change] [datetime] NULL,
   [change_dr_id] [int] NULL,
   [reason] [varchar](150) NULL,
   [drug_name] [varchar](200) NULL,
   [dosage] [varchar](255) NULL,
   [duration_amount] [varchar](15) NULL,
   [duration_unit] [varchar](80) NULL,
   [drug_comments] [varchar](255) NULL,
   [numb_refills] [int] NULL,
   [use_generic] [int] NULL,
   [days_supply] [smallint] NULL,
   [prn] [bit] NULL,
   [prn_description] [varchar](50) NULL,
   [date_start] [datetime] NULL,
   [date_end] [datetime] NULL,
   [for_dr_id] [int] NULL,
   [source_type] [varchar](3) NULL,
   [record_source] [varchar](500) NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [order_reason] [varchar](500) NULL,
   [externalId] [varchar](50) NULL

   ,CONSTRAINT [PK_patient_medications_hx] PRIMARY KEY CLUSTERED ([pam_id])
)


GO
