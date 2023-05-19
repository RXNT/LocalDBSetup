CREATE TABLE [dbo].[messaging_folder_types] (
   [folder_type_id] [int] NOT NULL
      IDENTITY (1,1),
   [folder_type] [varchar](50) NOT NULL,
   [icon_image] [varchar](50) NOT NULL

   ,CONSTRAINT [PK_messaging_folder_types] PRIMARY KEY CLUSTERED ([folder_type_id])
)


GO
