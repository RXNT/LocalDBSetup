CREATE TABLE [dbo].[patients_fav_pharms] (
   [pa_id] [int] NOT NULL,
   [pharm_id] [int] NOT NULL,
   [pharm_use_date] [datetime] NOT NULL

   ,CONSTRAINT [PK_patients_fav_pharms] PRIMARY KEY NONCLUSTERED ([pa_id], [pharm_id])
   ,CONSTRAINT [uq_patients_fav_pharms] UNIQUE NONCLUSTERED ([pa_id], [pharm_id])
)

CREATE CLUSTERED INDEX [patients_fav_pharms2] ON [dbo].[patients_fav_pharms] ([pharm_use_date])

GO
