CREATE TABLE [dbo].[MergePatientsXRef] (
   [mergepatxref_id] [int] NOT NULL
      IDENTITY (1,1),
   [deleted_pa_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [merge_date] [smalldatetime] NOT NULL

   ,CONSTRAINT [PK_MergePatientsXRef] PRIMARY KEY CLUSTERED ([mergepatxref_id])
)


GO
