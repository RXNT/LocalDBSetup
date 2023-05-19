CREATE TABLE [dbo].[fav_patients] (
   [dfp_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [update_code] [int] NOT NULL,
   [notes_update_code] [int] NOT NULL,
   [drugs_update_code] [int] NOT NULL,
   [pharm_update_code] [int] NOT NULL

   ,CONSTRAINT [PK_fav_patients] PRIMARY KEY NONCLUSTERED ([dfp_id])
)

CREATE CLUSTERED INDEX [fav_patients1] ON [dbo].[fav_patients] ([pa_id])
CREATE NONCLUSTERED INDEX [fav_patients3] ON [dbo].[fav_patients] ([dr_id], [pa_id], [update_code])

GO
