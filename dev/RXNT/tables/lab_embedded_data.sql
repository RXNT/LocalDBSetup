CREATE TABLE [dbo].[lab_embedded_data] (
   [emb_id] [int] NOT NULL
      IDENTITY (1,1),
   [embedded_data] [varchar](max) NULL,
   [lab_result_id] [int] NOT NULL

   ,CONSTRAINT [PK_lab_embedded_data] PRIMARY KEY CLUSTERED ([emb_id])
)


GO
