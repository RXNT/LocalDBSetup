CREATE TABLE [dbo].[doc_company_hosts] (
   [dc_host_id] [int] NOT NULL
      IDENTITY (1,1),
   [dc_host_name] [varchar](255) NOT NULL,
   [dc_host_login_proto] [varchar](10) NOT NULL

   ,CONSTRAINT [PK_doc_company_hosts] PRIMARY KEY CLUSTERED ([dc_host_id])
)


GO
