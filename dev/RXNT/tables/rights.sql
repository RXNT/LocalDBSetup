CREATE TABLE [dbo].[rights] (
   [right_id] [int] NOT NULL
      IDENTITY (1,1),
   [right_desc] [varchar](255) NOT NULL,
   [right_code] [varchar](50) NOT NULL,
   [right_val] [int] NULL

   ,CONSTRAINT [PK_rights] PRIMARY KEY CLUSTERED ([right_id])
)

CREATE UNIQUE NONCLUSTERED INDEX [RightCodeNoDupes] ON [dbo].[rights] ([right_code])

GO
