CREATE TABLE [dbo].[phone_numbers] (
   [PhoneId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PhoneNo] [varchar](30) NULL,
   [Dg_Id] [bigint] NULL

   ,CONSTRAINT [PK_phone_numbers] PRIMARY KEY CLUSTERED ([PhoneId])
)


GO
