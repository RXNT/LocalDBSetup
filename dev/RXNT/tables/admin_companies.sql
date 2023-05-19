CREATE TABLE [dbo].[admin_companies] (
   [admin_company_id] [int] NOT NULL
      IDENTITY (1,1),
   [admin_company_name] [varchar](100) NOT NULL,
   [admin_company_rights] [int] NOT NULL,
   [enabled] [bit] NOT NULL

   ,CONSTRAINT [PK_admin_companies] PRIMARY KEY CLUSTERED ([admin_company_id])
)


GO
