CREATE TABLE [dbo].[messaging_folders] (
   [folder_id] [int] NOT NULL
      IDENTITY (1,1),
   [parent_folder_id] [int] NOT NULL,
   [folder_type_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [folder_name] [varchar](255) NOT NULL

   ,CONSTRAINT [PK_messaging_folders] PRIMARY KEY CLUSTERED ([folder_id])
)


GO
