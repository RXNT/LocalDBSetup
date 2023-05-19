CREATE TABLE [dbo].[CustomerNotes] (
   [CustNoteID] [int] NOT NULL
      IDENTITY (1,1),
   [CustID] [int] NOT NULL,
   [CustNoteDate] [datetime] NOT NULL,
   [lEmpID] [int] NOT NULL,
   [bVoid] [bit] NOT NULL,
   [CustNote] [text] NOT NULL

   ,CONSTRAINT [PK_CustomerNotes] PRIMARY KEY NONCLUSTERED ([CustNoteID])
)


GO
