CREATE TABLE [dbo].[StoreSalesReports] (
   [SSRID] [int] NOT NULL
      IDENTITY (1,1),
   [SSRDate] [datetime] NOT NULL,
   [SSRNotes] [varchar](1000) NOT NULL,
   [SSRNTUserName] [varchar](100) NOT NULL,
   [SSRPaid] [bit] NOT NULL

   ,CONSTRAINT [PK_StoreSalesReports] PRIMARY KEY CLUSTERED ([SSRID])
)


GO
