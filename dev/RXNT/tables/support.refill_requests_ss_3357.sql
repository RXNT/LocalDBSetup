CREATE TABLE [support].[refill_requests_ss_3357] (
   [refreq_id] [int] NOT NULL,
   [pres_id] [int] NULL,
   [pd_id] [int] NULL,
   [old_drug_id] [int] NULL,
   [old_drug_name] [varchar](150) NULL,
   [old_drug_ndc] [varchar](30) NULL,
   [old_drug_level] [int] NULL,
   [is_incorrect] [bit] NULL,
   [created_on] [datetime] NULL,
   [is_corrected] [bit] NULL,
   [corrected_on] [datetime] NULL,
   [p_drug_id] [int] NULL,
   [p_drug_ndc] [varchar](30) NULL,
   [p_drug_name] [varchar](150) NULL,
   [p_drug_level] [int] NULL,
   [p_fdb_drug_name] [varchar](150) NULL,
   [d_drug_id] [int] NULL,
   [d_drug_ndc] [varchar](30) NULL,
   [d_drug_name] [varchar](150) NULL,
   [d_drug_level] [int] NULL,
   [d_fdb_drug_name] [varchar](150) NULL,
   [is_p_dugname_matches] [bit] NULL

   ,CONSTRAINT [PK_refill_requests_ss_3357] PRIMARY KEY NONCLUSTERED ([refreq_id])
)


GO
