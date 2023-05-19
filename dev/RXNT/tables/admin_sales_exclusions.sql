CREATE TABLE [dbo].[admin_sales_exclusions] (
   [admiinuser_sales_xrefid] [int] NOT NULL
      IDENTITY (1,1),
   [admin_user_id] [int] NOT NULL,
   [SALES_PERSON_ID] [int] NOT NULL

   ,CONSTRAINT [PK_admin_sales_exclusions] PRIMARY KEY CLUSTERED ([admiinuser_sales_xrefid])
)


GO
