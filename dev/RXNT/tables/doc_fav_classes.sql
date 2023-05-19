CREATE TABLE [dbo].[doc_fav_classes] (
   [dfc_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [etc_id] [int] NOT NULL

   ,CONSTRAINT [PK_doc_fav_classes] PRIMARY KEY CLUSTERED ([dfc_id])
)


GO
