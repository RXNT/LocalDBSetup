CREATE TABLE [dbo].[practice_fee_settings] (
   [Practice_Fee_Settings_Id] [int] NOT NULL
      IDENTITY (1,1),
   [dg_id] [int] NOT NULL,
   [Fee_Type] [char](1) NOT NULL,
   [Fee] [decimal](18,2) NOT NULL,
   [Updated_DateTime] [datetime] NOT NULL,
   [Updated_User] [nvarchar](50) NOT NULL

   ,CONSTRAINT [PK_practice_fee_settings] PRIMARY KEY CLUSTERED ([Practice_Fee_Settings_Id])
)


GO
