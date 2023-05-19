CREATE TABLE [dbo].[tblVaccineCVXToVaccineNDCMappings] (
   [ndc_map_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [NDCInnerID] [int] NULL,
   [UseUnitLabeler] [bigint] NULL,
   [UseUnitProduct] [bigint] NULL,
   [UseUnitPackage] [bigint] NULL,
   [UseUnitPropName] [varchar](max) NULL,
   [UseUnitGenericName] [varchar](max) NULL,
   [UseUnitLabelerName] [varchar](500) NULL,
   [UseUnitstartDate] [datetime] NULL,
   [UseUnitEndDate] [datetime] NULL,
   [UseUnitPackForm] [varchar](200) NULL,
   [UseUnitGTIN] [varchar](300) NULL,
   [CVXCode] [bigint] NULL,
   [CVXDescription] [varchar](max) NULL,
   [NoInner] [varchar](max) NULL,
   [NDC11] [varchar](max) NULL,
   [last_updated_date] [datetime] NULL,
   [GTIN] [varchar](max) NULL,
   [is_active] [bit] NULL

   ,CONSTRAINT [PK_tblVaccineCVXToVaccineNDCMappings] PRIMARY KEY CLUSTERED ([ndc_map_id])
)


GO
