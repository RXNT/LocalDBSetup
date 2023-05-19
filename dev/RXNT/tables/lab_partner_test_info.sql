CREATE TABLE [dbo].[lab_partner_test_info] (
   [test_info_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [property_name] [varchar](100) NULL,
   [external_lab_id] [varchar](100) NULL,
   [partner_test_id] [varchar](100) NULL,
   [comments] [varchar](max) NULL,
   [active] [bit] NOT NULL,
   [last_modified_by] [int] NOT NULL,
   [last_modified_date] [datetime] NOT NULL,
   [created_date] [datetime] NOT NULL,
   [created_by] [int] NOT NULL

   ,CONSTRAINT [PK_lab_partner_test_info] PRIMARY KEY CLUSTERED ([test_info_id])
)


GO
