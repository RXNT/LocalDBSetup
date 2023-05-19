CREATE TABLE [dbo].[patient_claims_history] (
   [claims_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dg_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [claim_download_date] [datetime] NOT NULL,
   [dr_last_name] [varchar](100) NULL,
   [dr_first_name] [varchar](100) NULL,
   [dr_address1] [varchar](100) NULL,
   [dr_city] [varchar](50) NULL,
   [dr_state] [varchar](2) NULL,
   [dr_zip] [varchar](15) NULL,
   [dr_dea] [varchar](50) NULL,
   [dr_npi] [varchar](50) NULL,
   [dr_phone] [varchar](20) NULL,
   [pharm_name] [varchar](50) NULL,
   [pharm_address1] [varchar](150) NULL,
   [pharm_city] [varchar](50) NULL,
   [pharm_state] [varchar](2) NULL,
   [pharm_zip] [varchar](15) NULL,
   [pharm_ncpdp] [varchar](50) NULL,
   [pharm_fax] [varchar](20) NULL,
   [pharm_phone] [varchar](20) NULL,
   [ddid] [int] NOT NULL,
   [ndc] [varchar](20) NOT NULL,
   [rxnorm] [varchar](50) NULL,
   [drug_name] [varchar](210) NULL,
   [dosage] [varchar](200) NULL,
   [numb_refills] [smallint] NULL,
   [entry_date] [datetime] NULL,
   [start_date] [datetime] NULL,
   [end_date] [datetime] NULL,
   [last_fill_date] [datetime] NULL,
   [days_supply] [smallint] NULL,
   [quantity] [varchar](50) NULL,
   [quantity_units] [varchar](50) NULL,
   [remaining_amount] [varchar](50) NULL,
   [received_amount] [varchar](50) NULL,
   [use_generic] [bit] NULL,
   [comments] [varchar](255) NULL

   ,CONSTRAINT [PK_patient_claims_history] PRIMARY KEY CLUSTERED ([claims_id])
)


GO
