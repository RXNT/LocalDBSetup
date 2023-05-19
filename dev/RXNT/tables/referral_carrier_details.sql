CREATE TABLE [dbo].[referral_carrier_details] (
   [carrier_id] [int] NOT NULL
      IDENTITY (1,1),
   [carrier_name] [varchar](50) NOT NULL,
   [address1] [varchar](50) NOT NULL,
   [city] [varchar](50) NOT NULL,
   [state] [varchar](10) NOT NULL,
   [zip] [varchar](10) NOT NULL,
   [phone] [varchar](20) NOT NULL

   ,CONSTRAINT [PK_referral_carrier_details] PRIMARY KEY CLUSTERED ([carrier_id])
)


GO
