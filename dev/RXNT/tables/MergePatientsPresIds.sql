CREATE TABLE [dbo].[MergePatientsPresIds] (
   [mergepatpresid] [int] NOT NULL
      IDENTITY (1,1),
   [deleted_pa_id] [int] NOT NULL,
   [pres_id] [int] NOT NULL,
   [merge_date] [smalldatetime] NOT NULL

   ,CONSTRAINT [PK_MergePatientsPresIds] PRIMARY KEY CLUSTERED ([mergepatpresid])
)


GO
