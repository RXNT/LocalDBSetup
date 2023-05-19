CREATE TABLE [dbo].[lab_partner_tests_xref] (
   [lab_partner_test_xrefid] [int] NOT NULL,
   [lab_test_id] [int] NOT NULL,
   [partner_id] [int] NOT NULL,
   [partner_test_id] [varchar](50) NOT NULL

   ,CONSTRAINT [PK_lab_partner_tests_xref] PRIMARY KEY CLUSTERED ([lab_partner_test_xrefid])
)


GO
