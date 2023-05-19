CREATE TABLE [dbo].[CustomerEmailMessageText] (
   [CEMMTID] [int] NOT NULL
      IDENTITY (1,1),
   [CEMMTYPEID] [int] NOT NULL,
   [PricerRegionID] [int] NOT NULL,
   [strSubject] [varchar](400) NOT NULL,
   [strBody] [text] NOT NULL

   ,CONSTRAINT [PK_CustomerEmailMessageText] PRIMARY KEY CLUSTERED ([CEMMTID])
)


GO
