CREATE TABLE [dbo].[ZipCodes] (
   [zc_id] [int] NOT NULL
      IDENTITY (1,1),
   [zipcode] [varchar](10) NULL,
   [city] [varchar](80) NULL,
   [state] [varchar](80) NULL,
   [add_date] [smalldatetime] NULL

   ,CONSTRAINT [PK_ZipCodes] PRIMARY KEY NONCLUSTERED ([zc_id])
)

CREATE NONCLUSTERED INDEX [_zipcode1] ON [dbo].[ZipCodes] ([zipcode])
CREATE CLUSTERED INDEX [PK_ZipCode] ON [dbo].[ZipCodes] ([zipcode])

GO
