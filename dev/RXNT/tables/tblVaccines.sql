CREATE TABLE [dbo].[tblVaccines] (
   [vac_id] [int] NOT NULL
      IDENTITY (1,1),
   [vac_name] [nvarchar](150) NOT NULL,
   [vac_base_name] [nvarchar](150) NOT NULL,
   [manufacturer] [nvarchar](100) NOT NULL,
   [type] [nvarchar](50) NOT NULL,
   [comments] [nvarchar](250) NULL,
   [route] [nvarchar](50) NULL,
   [info_link] [nvarchar](200) NULL,
   [dc_id] [int] NOT NULL,
   [vac_exp_code] [varchar](10) NOT NULL,
   [vis_link] [varchar](200) NULL,
   [CVX_CODE] [varchar](10) NOT NULL,
   [mvx_code] [varchar](10) NOT NULL,
   [route_code] [varchar](3) NULL,
   [eligibility_category_code] [varchar](15) NULL,
   [Expiration_Date] [datetime] NULL,
   [is_active] [bit] NULL,
   [last_updated_date] [datetime] NULL,
   [cvx_id] [int] NULL,
   [manufacturer_id] [int] NULL,
   [is_CDC_Active] [bit] NULL

   ,CONSTRAINT [PK__tblVaccines__3B0D59BA] PRIMARY KEY CLUSTERED ([vac_id])
)

CREATE NONCLUSTERED INDEX [IX_tblVaccines] ON [dbo].[tblVaccines] ([dc_id])
CREATE UNIQUE NONCLUSTERED INDEX [UQ__tblVaccines__0000000000000014] ON [dbo].[tblVaccines] ([vac_id])

GO
