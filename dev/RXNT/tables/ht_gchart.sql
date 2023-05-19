CREATE TABLE [dbo].[ht_gchart] (
   [Sex] [float] NULL,
   [Agemos] [float] NULL,
   [L] [float] NULL,
   [M] [float] NULL,
   [S] [float] NULL,
   [P3] [float] NULL,
   [P5] [float] NULL,
   [P10] [float] NULL,
   [P25] [float] NULL,
   [P50] [float] NULL,
   [P75] [float] NULL,
   [P90] [float] NULL,
   [P95] [float] NULL,
   [P97] [float] NULL,
   [ht_id] [int] NOT NULL
      IDENTITY (1,1)

   ,CONSTRAINT [PK_ht_gchart] PRIMARY KEY CLUSTERED ([ht_id])
)


GO
