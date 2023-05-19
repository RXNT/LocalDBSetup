CREATE TABLE [dbo].[prescription_coverage_info] (
   [pd_id] [int] NOT NULL,
   [ic_group_numb] [varchar](35) NOT NULL,
   [formulary_id] [varchar](30) NOT NULL,
   [pbm_id] [varchar](15) NULL,
   [pbm_member_id] [varchar](80) NULL,
   [formulary_type] [tinyint] NOT NULL,
   [copay_id] [varchar](40) NULL,
   [coverage_id] [varchar](40) NULL,
   [alternative_id] [varchar](30) NULL,
   [PLAN_ID] [varchar](50) NULL,
   [transaction_message_id] [varchar](50) NULL

   ,CONSTRAINT [PK__prescrip__F7562CCF367E7A1E] PRIMARY KEY CLUSTERED ([pd_id])
)


GO
