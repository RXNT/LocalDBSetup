CREATE TABLE [dbo].[RFFP0] (
   [NDC] [varchar](11) NOT NULL,
   [FFP_TYP] [varchar](2) NOT NULL,
   [FFP_DATEC] [datetime] NOT NULL,
   [FFP_IND] [varchar](1) NULL

   ,CONSTRAINT [RFFP0_PK] PRIMARY KEY CLUSTERED ([NDC], [FFP_TYP], [FFP_DATEC])
)


GO
