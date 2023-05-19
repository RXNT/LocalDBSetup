CREATE TABLE [dbo].[ins_formularies] (
   [if_id] [int] NOT NULL
      IDENTITY (1,1),
   [ic_id] [int] NOT NULL,
   [ddid] [int] NOT NULL

   ,CONSTRAINT [PK_ins_formularies] PRIMARY KEY NONCLUSTERED ([if_id])
)

CREATE UNIQUE NONCLUSTERED INDEX [DDID_IC_No_Dups] ON [dbo].[ins_formularies] ([ic_id], [ddid])

GO
