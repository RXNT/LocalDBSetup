CREATE TABLE [dbo].[RefTracking] (
   [RTID] [int] NOT NULL
      IDENTITY (1,1),
   [REF] [varchar](2000) NOT NULL,
   [IP] [varchar](255) NOT NULL,
   [PG] [varchar](2000) NOT NULL,
   [DT] [datetime] NOT NULL

   ,CONSTRAINT [PK_RefTracking] PRIMARY KEY CLUSTERED ([RTID])
)


GO
