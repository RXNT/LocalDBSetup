CREATE TABLE [dbo].[StoreGlobalSettings] (
   [SSID] [int] NOT NULL
      IDENTITY (1,1),
   [HomePageProductListTitle] [varchar](255) NOT NULL

   ,CONSTRAINT [PK_StoreGlobalSettings] PRIMARY KEY CLUSTERED ([SSID])
)


GO
