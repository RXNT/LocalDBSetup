CREATE TABLE [dbo].[rxnt_experian_log] (
   [rxnt_experian_log_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [date] [datetime] NOT NULL,
   [session_id] [varchar](200) NOT NULL,
   [dr_id] [int] NOT NULL,
   [request] [text] NOT NULL,
   [response] [text] NOT NULL

   ,CONSTRAINT [PK_rxnt_experian_log] PRIMARY KEY CLUSTERED ([rxnt_experian_log_id])
)


GO
