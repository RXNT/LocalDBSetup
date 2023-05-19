CREATE TABLE [dbo].[scheduler_types] (
   [scheduler_type_id] [smallint] NOT NULL
      IDENTITY (0,1),
   [dc_id] [int] NULL,
   [type_text] [varchar](50) NOT NULL,
   [is_active] [bit] NOT NULL,
   [color] [varchar](10) NULL,
   [duration] [varchar](10) NULL

   ,CONSTRAINT [PK_scheduler_types] PRIMARY KEY CLUSTERED ([scheduler_type_id])
)


GO
