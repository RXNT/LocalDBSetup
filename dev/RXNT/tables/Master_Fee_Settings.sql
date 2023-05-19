CREATE TABLE [dbo].[Master_Fee_Settings] (
   [Master_Fee_Setting_Id] [int] NOT NULL
      IDENTITY (1,1),
   [Fee_Type] [char](1) NOT NULL,
   [Fee] [decimal](18,2) NOT NULL,
   [Updated_DateTime] [datetime] NOT NULL,
   [Updated_User] [nvarchar](50) NOT NULL

   ,CONSTRAINT [PK_Master_Fee_Settings] PRIMARY KEY CLUSTERED ([Master_Fee_Setting_Id])
)


GO
