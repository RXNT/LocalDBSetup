CREATE TABLE [dbo].[doc_fav_pharms_log] (
   [fpl_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [pharm_id] [int] NOT NULL,
   [update_code] [smallint] NOT NULL,
   [update_date] [datetime] NOT NULL

   ,CONSTRAINT [PK_doc_fav_pharms_log] PRIMARY KEY CLUSTERED ([fpl_id])
)


GO
