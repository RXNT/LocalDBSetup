CREATE TABLE [dbo].[patient_active_meds] (
   [pam_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [drug_id] [int] NOT NULL,
   [date_added] [datetime] NOT NULL,
   [added_by_dr_id] [int] NOT NULL,
   [from_pd_id] [int] NOT NULL,
   [compound] [bit] NOT NULL,
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
   [rxnorm_code] [varchar](100) NULL,
   [visibility_hidden_to_patient] [bit] NULL

   ,CONSTRAINT [PK_patient_active_meds] PRIMARY KEY CLUSTERED ([pam_id])
)

CREATE NONCLUSTERED INDEX [_dta_index_patient_active_meds_7_1790017508__K2_K1_K3_K5_4_7] ON [dbo].[patient_active_meds] ([pa_id], [pam_id], [drug_id], [added_by_dr_id]) INCLUDE ([date_added], [compound])
CREATE NONCLUSTERED INDEX [_dta_index_patient_active_meds_7_1790017508__K2_K3_K1_K5_4_6_7_8_13_14_15_16_17_18_19_20_21_22_23_24_27] ON [dbo].[patient_active_meds] ([pa_id], [drug_id], [pam_id], [added_by_dr_id]) INCLUDE ([comments], [compound], [date_added], [date_end], [date_start], [days_supply], [dosage], [drug_comments], [drug_name], [duration_amount], [duration_unit], [from_pd_id], [numb_refills], [prn], [prn_description], [record_source], [use_generic])
CREATE NONCLUSTERED INDEX [idx_Patient_active_med] ON [dbo].[patient_active_meds] ([added_by_dr_id], [date_added]) INCLUDE ([drug_id], [pa_id], [pam_id])
CREATE UNIQUE NONCLUSTERED INDEX [NoDupeMeds] ON [dbo].[patient_active_meds] ([pa_id], [drug_id], [compound], [drug_name])

GO
