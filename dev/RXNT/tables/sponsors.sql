CREATE TABLE [dbo].[sponsors] (
   [sponsor_id] [int] NOT NULL
      IDENTITY (1,1),
   [sponsor_name] [varchar](100) NOT NULL,
   [sponsor_lbl] [varchar](50) NOT NULL,
   [sponsor_type_id] [int] NOT NULL,
   [sponsor_msg] [varchar](255) NOT NULL

   ,CONSTRAINT [PK_sponsors] PRIMARY KEY CLUSTERED ([sponsor_id])
)


GO
