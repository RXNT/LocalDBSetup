CREATE TABLE [dbo].[merge_patients_cache] (
   [mg_pat_cache_id] [int] NOT NULL
      IDENTITY (1,1),
   [original_pa_id] [int] NOT NULL,
   [deleted_pa_id] [int] NOT NULL

   ,CONSTRAINT [PK_merge_patients_cache] PRIMARY KEY CLUSTERED ([mg_pat_cache_id])
)


GO
