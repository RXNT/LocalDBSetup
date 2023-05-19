CREATE TABLE [dbo].[patients_coverage_info_external] (
   [pci_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [ic_group_numb] [varchar](60) NULL,
   [card_holder_id] [varchar](30) NOT NULL,
   [card_holder_first] [varchar](100) NULL,
   [card_holder_mi] [varchar](50) NULL,
   [card_holder_last] [varchar](100) NULL,
   [ic_plan_numb] [varchar](30) NOT NULL,
   [ins_relate_code] [varchar](4) NOT NULL,
   [ins_person_code] [varchar](4) NOT NULL,
   [formulary_id] [varchar](30) NOT NULL,
   [alternative_id] [varchar](30) NOT NULL,
   [pa_bin] [varchar](60) NULL,
   [pa_notes] [varchar](255) NULL,
   [rxhub_pbm_id] [varchar](15) NULL,
   [pbm_member_id] [varchar](80) NULL,
   [def_ins_id] [int] NOT NULL,
   [mail_order_coverage] [varchar](5) NULL,
   [retail_pharmacy_coverage] [varchar](5) NULL,
   [formulary_type] [tinyint] NOT NULL,
   [add_date] [smalldatetime] NULL,
   [copay_id] [varchar](40) NOT NULL,
   [coverage_id] [varchar](40) NOT NULL,
   [ic_plan_name] [varchar](100) NULL,
   [PA_ADDRESS1] [varchar](100) NULL,
   [PA_ADDRESS2] [varchar](100) NULL,
   [PA_CITY] [varchar](50) NULL,
   [PA_STATE] [varchar](50) NULL,
   [PA_ZIP] [varchar](50) NULL,
   [PA_DOB] [smalldatetime] NULL,
   [PA_SEX] [varchar](1) NULL,
   [card_suffix] [varchar](10) NULL,
   [pa_diff_info] [bit] NULL,
   [longterm_pharmacy_coverage] [varchar](5) NULL,
   [specialty_pharmacy_coverage] [varchar](5) NULL,
   [prim_payer] [varchar](50) NULL,
   [sec_payer] [varchar](50) NULL,
   [ter_payer] [varchar](50) NULL,
   [ss_pbm_name] [varchar](100) NULL,
   [transaction_message_id] [varchar](50) NULL,
   [ic_group_name] [varchar](100) NULL

   ,CONSTRAINT [PK_patients_coverage_info_external] PRIMARY KEY CLUSTERED ([pci_id])
)

CREATE NONCLUSTERED INDEX [ix_patients_coverage_info_external_pa_id] ON [dbo].[patients_coverage_info_external] ([pa_id])

GO
