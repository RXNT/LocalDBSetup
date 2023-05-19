CREATE TABLE [dbo].[lab_test_lists] (
   [lab_test_id] [int] NOT NULL
      IDENTITY (1,1),
   [lab_test_name] [varchar](500) NOT NULL,
   [active] [bit] NOT NULL,
   [test_type] [smallint] NULL,
   [loinc_code] [varchar](10) NULL,
   [CODE_TYPE] [varchar](20) NOT NULL,
   [lab_test_name_long] [varchar](500) NULL

   ,CONSTRAINT [PK_lab_test_lists] PRIMARY KEY CLUSTERED ([lab_test_id])
)


GO
