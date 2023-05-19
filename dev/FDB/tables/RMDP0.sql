CREATE TABLE [dbo].[RMDP0] (
   [NDC] [varchar](11) NOT NULL,
   [MDPT_ID] [varchar](2) NOT NULL,
   [MDPT_TYP] [varchar](2) NOT NULL,
   [MDPT_DATEC] [datetime] NOT NULL,
   [MDPT_PRICE] [numeric](9,5) NULL

   ,CONSTRAINT [RMDP0_PK] PRIMARY KEY CLUSTERED ([NDC], [MDPT_ID], [MDPT_TYP], [MDPT_DATEC])
)


GO
