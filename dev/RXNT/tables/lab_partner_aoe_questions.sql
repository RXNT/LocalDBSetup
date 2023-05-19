CREATE TABLE [dbo].[lab_partner_aoe_questions] (
   [aoe_question_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [partner_id] [int] NULL,
   [lab_partner_test_xrefid] [int] NULL,
   [partner_test_id] [varchar](50) NULL,
   [partner_aoe_id] [varchar](50) NULL,
   [partner_aoe_type] [varchar](50) NULL,
   [aoe_label] [varchar](255) NULL,
   [menu] [varchar](4000) NULL,
   [radios] [varchar](4000) NULL

   ,CONSTRAINT [PK_lab_partner_aoe_questions] PRIMARY KEY CLUSTERED ([aoe_question_id])
)


GO
