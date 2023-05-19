CREATE TABLE [dbo].[StoreProductAttributes] (
   [PAID] [int] NOT NULL
      IDENTITY (1,1),
   [ProductID] [int] NOT NULL,
   [PADesc] [varchar](50) NOT NULL,
   [PASortID] [int] NOT NULL,
   [PACostPlus] [money] NOT NULL,
   [PAOptionIndex] [int] NOT NULL,
   [PAColorHEX] [varchar](50) NOT NULL

   ,CONSTRAINT [PK_StoreProductAttributes] PRIMARY KEY CLUSTERED ([PAID])
)


GO
