CREATE TABLE [dbo].[TempExternalPatientActiveMeds_26753] (
   [id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NULL,
   [drug_id] [int] NULL,
   [patient_chart_no] [varchar](50) NULL,
   [dosage] [varchar](255) NULL,
   [rxnorm_code] [varchar](15) NULL,
   [drug_name] [varchar](200) NULL,
   [duration_amount] [varchar](15) NULL,
   [duration_unit] [varchar](80) NULL,
   [numb_refills] [int] NULL,
   [comments] [varchar](255) NULL,
   [prn] [bit] NULL,
   [prn_description] [varchar](50) NULL,
   [use_generic] [int] NULL,
   [dr_npi] [varchar](25) NULL

   ,CONSTRAINT [PK_TempExternalPatientActiveMeds_26753] PRIMARY KEY CLUSTERED ([id])
)


GO
