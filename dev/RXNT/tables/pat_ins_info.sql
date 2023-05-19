CREATE TABLE [dbo].[pat_ins_info] (
   [pat_ins_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [rxhub_pmb_id] [varchar](15) NOT NULL,
   [ic_group_numb] [varchar](30) NOT NULL,
   [ic_plan_numb] [varchar](30) NOT NULL,
   [formulary_id] [varchar](35) NOT NULL,
   [alternative_id] [varchar](35) NOT NULL,
   [pbm_member_id] [varchar](80) NOT NULL,
   [pa_bin] [varchar](30) NOT NULL,
   [ins_relate_code] [smallint] NOT NULL,
   [ins_person_code] [varchar](30) NOT NULL,
   [card_holder_id] [varchar](30) NOT NULL,
   [card_holder_first] [varchar](50) NOT NULL,
   [card_holder_middle] [varchar](1) NOT NULL,
   [card_holder_last] [varchar](50) NOT NULL

   ,CONSTRAINT [PK_pat_ins_info] PRIMARY KEY CLUSTERED ([pat_ins_id])
)


GO
