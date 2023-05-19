CREATE TABLE [dbo].[AppSettings] (
   [ID] [int] NOT NULL
      IDENTITY (1,1),
   [Category] [varchar](100) NOT NULL,
   [Key] [varchar](100) NOT NULL,
   [Value] [varchar](100) NOT NULL
)


GO
