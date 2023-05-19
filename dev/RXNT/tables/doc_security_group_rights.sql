CREATE TABLE [dbo].[doc_security_group_rights] (
   [dsgr_id] [int] NOT NULL
      IDENTITY (1,1),
   [dsg_id] [int] NOT NULL,
   [right_id] [int] NOT NULL

   ,CONSTRAINT [PK_doc_security_group_rights] PRIMARY KEY CLUSTERED ([dsgr_id])
)


GO
