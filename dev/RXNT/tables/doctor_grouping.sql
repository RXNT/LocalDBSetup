CREATE TABLE [dbo].[doctor_grouping] (
   [grp_id] [int] NOT NULL
      IDENTITY (1,1),
   [title] [varchar](255) NOT NULL,
   [dg_id] [int] NOT NULL

   ,CONSTRAINT [PK_doctor_grouping] PRIMARY KEY CLUSTERED ([grp_id])
)


GO
