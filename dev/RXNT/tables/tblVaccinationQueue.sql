CREATE TABLE [dbo].[tblVaccinationQueue] (
   [queue_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dr_id] [bigint] NOT NULL,
   [pat_id] [bigint] NOT NULL,
   [vac_rec_id] [bigint] NOT NULL,
   [isIncluded] [bit] NOT NULL,
   [exportedDate] [date] NULL,
   [FileName] [varchar](100) NULL
)


GO
