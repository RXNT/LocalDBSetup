CREATE TABLE [dbo].[merge_patients_search_cache] (
   [mg_pat_search_cache_id] [int] NOT NULL
      IDENTITY (1,1),
   [deleted_pa_id] [int] NOT NULL,
   [ultimate_pa_id] [int] NOT NULL

   ,CONSTRAINT [PK_merge_patients_search_cache] PRIMARY KEY NONCLUSTERED ([mg_pat_search_cache_id])
)

CREATE CLUSTERED INDEX [merge_patients_search_cache1] ON [dbo].[merge_patients_search_cache] ([deleted_pa_id])
CREATE NONCLUSTERED INDEX [merge_patients_search_cache2] ON [dbo].[merge_patients_search_cache] ([ultimate_pa_id])

GO
