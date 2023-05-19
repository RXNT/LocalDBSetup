CREATE TABLE [dbo].[tblCountries] (
   [lngCountryID] [int] NOT NULL,
   [strCountryName] [varchar](100) NOT NULL,
   [strUPSCountryCode] [varchar](3) NOT NULL,
   [bUPSZipRequired] [bit] NOT NULL,
   [strUPSWgtUnitMsr] [varchar](5) NOT NULL,
   [bEuroAllowed] [bit] NULL,
   [strUPSCurrencyCode] [varchar](50) NULL,
   [iMaxWeightLB] [int] NULL,
   [iMaxWeightKG] [int] NULL,
   [bHasUPSDelivery] [bit] NULL,
   [bStoreEnabled] [bit] NOT NULL

   ,CONSTRAINT [PK_tblCountries] PRIMARY KEY CLUSTERED ([lngCountryID])
)


GO
