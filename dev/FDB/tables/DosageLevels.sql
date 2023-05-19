CREATE TABLE [dbo].[DosageLevels] (
   [MEDID] [decimal](8,0) NOT NULL,
   [MED_MEDID_DESC] [varchar](70) NOT NULL,
   [MED_STRENGTH] [varchar](15) NULL,
   [MED_STRENGTH_UOM] [varchar](15) NULL,
   [drc_code] [varchar](10) NULL,
   [drug_name] [varchar](35) NULL,
   [route] [varchar](5) NULL,
   [low_age] [int] NULL,
   [high_age] [int] NULL,
   [max_daily] [int] NULL,
   [max_daily_un] [varchar](10) NULL,
   [high_freq] [int] NULL,
   [max_Dosage] [varchar](30) NULL,
   [max_dosage_un] [varchar](10) NULL,
   [NDC] [varchar](15) NULL
)


GO
