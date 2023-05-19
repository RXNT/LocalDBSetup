CREATE TABLE [dbo].[doc_fav_patients_log] (
   [fpl_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [update_code] [smallint] NOT NULL,
   [update_date] [datetime] NOT NULL

   ,CONSTRAINT [PK_doc_fav_patients_log] PRIMARY KEY CLUSTERED ([fpl_id])
)


GO
