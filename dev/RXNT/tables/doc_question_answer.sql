CREATE TABLE [dbo].[doc_question_answer] (
   [doc_question_answer_id] [int] NOT NULL
      IDENTITY (1,1),
   [doc_question_id] [int] NOT NULL,
   [doc_answer] [varchar](1000) NOT NULL,
   [dr_id] [int] NOT NULL

   ,CONSTRAINT [PK_doc_question_answer] PRIMARY KEY CLUSTERED ([doc_question_answer_id])
)

CREATE NONCLUSTERED INDEX [IDX_dq_drid] ON [dbo].[doc_question_answer] ([dr_id])

GO
