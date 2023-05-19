CREATE TABLE [dbo].[doc_group_taper_sigs] (
   [dcts_id] [int] NOT NULL
      IDENTITY (1,1),
   [dg_id] [bigint] NOT NULL,
   [med_id] [bigint] NOT NULL,
   [sig] [varchar](210) NOT NULL,
   [CreatedBy] [bigint] NULL,
   [CreatedDate] [smalldatetime] NULL,
   [LastModifiedBy] [bigint] NULL,
   [LastModifiedDate] [smalldatetime] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK_doc_group_taper_sigs] PRIMARY KEY CLUSTERED ([dcts_id])
)


GO
