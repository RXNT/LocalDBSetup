CREATE TABLE [dbo].[Patient_merge_status] (
   [StatusId] [int] NOT NULL
      IDENTITY (1,1),
   [Status] [varchar](20) NOT NULL,
   [Description] [varchar](50) NULL

   ,CONSTRAINT [PK_Patient_merge_status] PRIMARY KEY CLUSTERED ([StatusId])
)


GO
