CREATE TABLE [dbo].[HMrules] (
   [rule_id] [int] NOT NULL
      IDENTITY (1,1),
   [HmRuleID] [int] NULL,
   [RuleName] [nvarchar](255) NOT NULL,
   [RecommendedAge] [nvarchar](10) NULL,
   [MinAge] [nvarchar](10) NULL,
   [MaxAge] [nvarchar](10) NULL,
   [RecommendedInterval] [nvarchar](10) NULL,
   [MinInterval] [nvarchar](10) NULL,
   [MaxInterval] [nvarchar](10) NULL,
   [RuleText] [ntext] NULL,
   [FrequencyOfService] [ntext] NULL,
   [RuleRationale] [ntext] NULL,
   [Footnote] [nvarchar](255) NULL,
   [Source] [nvarchar](255) NULL,
   [Type] [nvarchar](6) NULL,
   [Grade] [nvarchar](1) NULL,
   [DoseNumber] [int] NULL,
   [ApplicableGender] [nvarchar](1) NULL,
   [ApplicableICDs] [nvarchar](255) NULL,
   [RestrictedICDs] [nvarchar](255) NULL,
   [LiveVaccine] [bit] NULL,
   [EggComponent] [bit] NULL,
   [GelatinComponent] [bit] NULL,
   [RiskCategory] [nvarchar](10) NULL,
   [RiskFactors] [nvarchar](255) NULL,
   [ApplicableAgeGroup] [nvarchar](12) NULL,
   [CPT] [nvarchar](255) NULL,
   [VaccineID] [int] NULL,
   [Comment] [nvarchar](255) NULL,
   [Inactive] [bit] NOT NULL,
   [DateLastTouched] [datetime] NULL,
   [LastTouchedBy] [nchar](50) NULL,
   [DateRowAdded] [datetime] NULL,
   [AgeSpecific] [bit] NOT NULL

   ,CONSTRAINT [PK_HMrules] PRIMARY KEY CLUSTERED ([rule_id])
)


GO
