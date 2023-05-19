CREATE TABLE [fdb_b].[ROBCD0] (
   [OBC] [varchar](2) NOT NULL,
   [OBC_SN] [numeric](2,0) NOT NULL,
   [OBC_DESC] [varchar](60) NULL

   ,CONSTRAINT [ROBCD0_PK] PRIMARY KEY CLUSTERED ([OBC], [OBC_SN])
)


GO
