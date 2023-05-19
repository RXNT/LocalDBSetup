CREATE TABLE [dbo].[doctor_grouping_details] (
   [grp_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [grp_details_id] [int] NOT NULL
      IDENTITY (1,1)

   ,CONSTRAINT [PK_doctor_grouping_details] PRIMARY KEY CLUSTERED ([grp_details_id])
)

CREATE NONCLUSTERED INDEX [IX_doctor_grouping_details] ON [dbo].[doctor_grouping_details] ([grp_id], [dr_id])

GO
