CREATE TABLE [dbo].[temp_drug] (
   [med_name_id] [numeric](18,0) NOT NULL,
   [rxtype] [varchar](1) NOT NULL,
   [DRUGTYPE] [varchar](1) NOT NULL,
   [medid] [numeric](18,0) NOT NULL,
   [MED_MEDID_DESC] [varchar](210) NOT NULL,
   [drug_class] [varchar](1) NOT NULL,
   [ETC_ID] [numeric](18,0) NOT NULL,
   [ETC_NAME] [varchar](70) NOT NULL,
   [status] [int] NULL,
   [PriorAuth] [numeric](18,0) NOT NULL,
   [DrugExclusion] [numeric](18,0) NOT NULL
)


GO
