CREATE TABLE [dbo].[Holidays] (
   [Dg_Id] [bigint] NOT NULL,
   [Date] [smalldatetime] NOT NULL

   ,CONSTRAINT [PK_Holidays] PRIMARY KEY CLUSTERED ([Dg_Id], [Date])
)


GO
