CREATE TABLE [dbo].[sponsor_types] (
   [sponsor_type_id] [int] NOT NULL
      IDENTITY (1,1),
   [sponsor_type] [varchar](50) NOT NULL

   ,CONSTRAINT [PK_sponsor_types] PRIMARY KEY CLUSTERED ([sponsor_type_id])
)


GO
