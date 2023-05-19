CREATE TABLE [dbo].[GeoIPCountryWhois] (
   [IPStart] [varchar](50) NOT NULL,
   [IPEnd] [varchar](50) NOT NULL,
   [IntStart] [bigint] NOT NULL,
   [IntEnd] [bigint] NOT NULL,
   [CountryCode] [varchar](50) NOT NULL,
   [CountryName] [varchar](50) NOT NULL
)


GO
