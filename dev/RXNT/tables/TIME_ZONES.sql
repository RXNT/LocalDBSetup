CREATE TABLE [dbo].[TIME_ZONES] (
   [TIMEZONE_CD] [varchar](6) NOT NULL,
   [TIMEZONE_NAME] [varchar](60) NOT NULL,
   [OFFSET_HR] [int] NOT NULL,
   [OFFSET_MI] [int] NOT NULL,
   [DST_OFFSET_HR] [int] NOT NULL,
   [DST_OFFSET_MI] [int] NOT NULL,
   [DST_EFF_DT] [varchar](10) NOT NULL,
   [DST_END_DT] [varchar](10) NOT NULL,
   [EFF_DT] [datetime] NOT NULL,
   [END_DT] [datetime] NOT NULL

   ,CONSTRAINT [PK_TIME_ZONES] PRIMARY KEY CLUSTERED ([TIMEZONE_CD], [EFF_DT])
)


GO
