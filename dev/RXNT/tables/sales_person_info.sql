CREATE TABLE [dbo].[sales_person_info] (
   [sale_person_id] [smallint] NOT NULL
      IDENTITY (1,1),
   [sale_person_fname] [varchar](50) NOT NULL,
   [sale_person_mi] [varchar](10) NOT NULL,
   [sale_person_lname] [varchar](50) NOT NULL,
   [ACTIVE] [bit] NOT NULL,
   [admin_company_id] [int] NOT NULL,
   [email] [varchar](100) NOT NULL

   ,CONSTRAINT [PK_sales_person_info] PRIMARY KEY CLUSTERED ([sale_person_id])
)


GO
