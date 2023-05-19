CREATE TABLE [dbo].[PhysicianList] (
   [IMSID] [varchar](255) NOT NULL,
   [MENUM] [varchar](255) NULL,
   [MMDID] [varchar](255) NULL,
   [TITLE] [varchar](255) NULL,
   [LAST_NAME] [varchar](255) NULL,
   [FIRST_NAME] [varchar](255) NULL,
   [MI] [varchar](255) NULL,
   [SPEC] [varchar](255) NULL,
   [ADDR] [varchar](255) NULL,
   [CITY] [varchar](255) NULL,
   [CURR_STT] [varchar](255) NULL,
   [CURR_ZIP] [varchar](255) NULL,
   [PHONE] [varchar](255) NULL,
   [ALLEGRA_DECILE] [varchar](255) NULL

   ,CONSTRAINT [PK_PhysicianList] PRIMARY KEY CLUSTERED ([IMSID])
)


GO
