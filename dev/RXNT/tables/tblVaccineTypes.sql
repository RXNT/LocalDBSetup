CREATE TABLE [dbo].[tblVaccineTypes] (
   [record_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dc_id] [bigint] NOT NULL,
   [cvx] [varchar](10) NOT NULL,
   [vac_type] [varchar](100) NOT NULL,
   [vac_type_cvx] [varchar](10) NOT NULL,
   [statement_published_on] [datetime] NULL,
   [statement_presented_on] [datetime] NULL,
   [vis_barcode] [varchar](24) NULL,
   [active] [bit] NULL

   ,CONSTRAINT [PK_tblVaccineTypes] PRIMARY KEY CLUSTERED ([record_id])
)


GO
