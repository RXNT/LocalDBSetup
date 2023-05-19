CREATE TABLE [dbo].[doc_fav_pages] (
   [fav_page_indx] [int] NOT NULL
      IDENTITY (1,1),
   [fav_page_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL

   ,CONSTRAINT [PK_doc_fav_pages] PRIMARY KEY CLUSTERED ([fav_page_indx])
)


GO
