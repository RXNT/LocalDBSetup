CREATE TABLE [dbo].[LOINC] (
   [LN_ID] [int] NOT NULL
      IDENTITY (1,1),
   [LOINC_NUM] [nvarchar](7) NOT NULL,
   [COMPONENT] [nvarchar](255) NOT NULL,
   [PROPERTY] [nvarchar](30) NULL,
   [TIME_ASPCT] [nvarchar](15) NULL,
   [SYSTEM] [nvarchar](100) NULL,
   [SCALE_TYP] [nvarchar](30) NULL,
   [METHOD_TYP] [nvarchar](50) NULL,
   [RELAT_NMS] [nvarchar](254) NULL,
   [CLASS] [nvarchar](20) NULL,
   [SOURCE] [nvarchar](8) NULL,
   [DT_LAST_CH] [nvarchar](8) NULL,
   [CHNG_TYPE] [nvarchar](3) NULL,
   [COMMENTS] [ntext] NULL,
   [ANSWERLIST] [ntext] NULL,
   [STATUS] [nvarchar](3) NULL,
   [MAP_TO] [nvarchar](7) NULL,
   [SCOPE] [nvarchar](20) NULL,
   [NORM_RANGE] [nvarchar](30) NULL,
   [IPCC_UNITS] [nvarchar](30) NULL,
   [REFERENCE] [ntext] NULL,
   [EXACT_CMP_SY] [nvarchar](50) NULL,
   [MOLAR_MASS] [nvarchar](13) NULL,
   [CLASSTYPE] [int] NULL,
   [FORMULA] [nvarchar](255) NULL,
   [SPECIES] [nvarchar](20) NULL,
   [EXMPL_ANSWERS] [ntext] NULL,
   [ACSSYM] [ntext] NULL,
   [BASE_NAME] [nvarchar](50) NULL,
   [FINAL] [nvarchar](1) NOT NULL,
   [NAACCR_ID] [nvarchar](20) NULL,
   [CODE_TABLE] [nvarchar](10) NULL,
   [SetRoot] [bit] NOT NULL,
   [PanelElements] [ntext] NULL,
   [SURVEY_QUEST_TEXT] [nvarchar](255) NULL,
   [SURVEY_QUEST_SRC] [nvarchar](50) NULL,
   [UnitsRequired] [nvarchar](1) NULL,
   [SUBMITTED_UNITS] [nvarchar](30) NULL,
   [RelatedNames2] [ntext] NULL,
   [SHORTNAME] [nvarchar](40) NULL,
   [ORDER_OBS] [nvarchar](15) NULL,
   [CDISC_COMMON_TESTS] [nvarchar](1) NULL,
   [HL7_FIELD_SUBFIELD_ID] [nvarchar](50) NULL,
   [EXTERNAL_COPYRIGHT_NOTICE] [ntext] NULL

   ,CONSTRAINT [PK_LOINC] PRIMARY KEY CLUSTERED ([LN_ID])
)

CREATE NONCLUSTERED INDEX [IX_MAIN] ON [dbo].[LOINC] ([LOINC_NUM], [COMPONENT])
CREATE NONCLUSTERED INDEX [IX_SUB] ON [dbo].[LOINC] ([SYSTEM], [METHOD_TYP], [CLASS], [CLASSTYPE])

GO
