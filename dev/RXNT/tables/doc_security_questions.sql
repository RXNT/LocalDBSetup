CREATE TABLE [dbo].[doc_security_questions] (
   [doc_sec_question_id] [int] NOT NULL,
   [doc_sec_question] [varchar](1000) NULL,
   [doc_question_index] [smallint] NULL

   ,CONSTRAINT [PK_doc_security_questions] PRIMARY KEY CLUSTERED ([doc_sec_question_id])
)


GO
