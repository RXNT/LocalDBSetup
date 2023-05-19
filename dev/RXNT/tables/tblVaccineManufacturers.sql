CREATE TABLE [dbo].[tblVaccineManufacturers] (
   [manufacturer_id] [int] NOT NULL
      IDENTITY (1,1),
   [manufacturer_name] [varchar](500) NOT NULL,
   [mvx_code] [varchar](10) NOT NULL,
   [notes] [varchar](max) NULL,
   [manufacturer_status] [bit] NOT NULL,
   [last_updated_date] [datetime] NOT NULL,
   [created_by] [int] NULL,
   [created_date] [datetime] NULL,
   [updated_by] [int] NULL,
   [updated_date] [datetime] NULL

   ,CONSTRAINT [PK_tblVaccineManufacturers] PRIMARY KEY CLUSTERED ([manufacturer_id])
)


GO
