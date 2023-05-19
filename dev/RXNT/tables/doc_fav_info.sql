CREATE TABLE [dbo].[doc_fav_info] (
   [info_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [dr_fullName] [varchar](100) NOT NULL,
   [appointment_duration] [int] NOT NULL

   ,CONSTRAINT [PK_doc_fav_info] PRIMARY KEY CLUSTERED ([info_id])
)


GO
