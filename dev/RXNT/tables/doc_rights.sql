CREATE TABLE [dbo].[doc_rights] (
   [dr_right_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [right_id] [int] NOT NULL

   ,CONSTRAINT [PK_dr_rights] PRIMARY KEY CLUSTERED ([dr_right_id])
)


GO
