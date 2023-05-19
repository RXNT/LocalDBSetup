CREATE TABLE [dbo].[doc_company_site_fav_pharms] (
   [dcfp_id] [int] NOT NULL
      IDENTITY (1,1),
   [dc_id] [int] NOT NULL,
   [pharm_id] [int] NOT NULL

   ,CONSTRAINT [PK_doc_company_site_fav_pharms] PRIMARY KEY CLUSTERED ([dcfp_id])
)


GO
