CREATE TABLE [dbo].[DoctorIssues] (
   [IssueId] [int] NOT NULL
      IDENTITY (1,1),
   [DrId] [int] NOT NULL,
   [IssueDate] [datetime] NOT NULL,
   [Issue] [text] NOT NULL,
   [ContactName] [varchar](50) NOT NULL,
   [Contact] [varchar](50) NOT NULL,
   [resolution_status] [bit] NOT NULL,
   [Response] [text] NOT NULL

   ,CONSTRAINT [PK_DoctorIssues] PRIMARY KEY CLUSTERED ([IssueId])
)


GO
