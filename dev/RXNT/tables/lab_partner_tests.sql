CREATE TABLE [dbo].[lab_partner_tests] (
   [lab_partner_tests_id] [int] NOT NULL
      IDENTITY (1,1),
   [external_lab_id] [varchar](100) NOT NULL,
   [partner_test_id] [varchar](140) NOT NULL,
   [partner_test_short_name] [varchar](1000) NOT NULL,
   [partner_test_long_name] [varchar](1000) NOT NULL,
   [lab_test_id] [int] NOT NULL,
   [active] [bit] NOT NULL,
   [last_modified_by] [int] NULL,
   [last_modified_date] [datetime] NULL,
   [created_date] [datetime] NOT NULL,
   [created_by] [int] NOT NULL,
   [partner_local_test_id] [varchar](140) NULL

   ,CONSTRAINT [PK_lab_partner_test] PRIMARY KEY CLUSTERED ([lab_partner_tests_id])
)


GO
