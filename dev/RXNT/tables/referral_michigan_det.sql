CREATE TABLE [dbo].[referral_michigan_det] (
   [ref_mich_det_id] [int] NOT NULL
      IDENTITY (1,1),
   [bProviderOffice] [bit] NOT NULL,
   [bOutpatient] [bit] NOT NULL,
   [bERUCC] [bit] NOT NULL,
   [facility_numb] [varchar](50) NOT NULL,
   [facility_name] [varchar](80) NOT NULL,
   [service_date] [datetime] NOT NULL,
   [bConsult] [bit] NOT NULL,
   [numb_visits] [smallint] NOT NULL,
   [bdiagnosticlab] [bit] NOT NULL,
   [baudiology] [bit] NOT NULL,
   [bopthamalogy] [bit] NOT NULL,
   [bradiology] [bit] NOT NULL,
   [bcast] [bit] NOT NULL,
   [bsurgery] [bit] NOT NULL,
   [surgery_cpt] [varchar](50) NOT NULL,
   [bdiagstudy] [bit] NOT NULL,
   [boncology] [bit] NOT NULL,
   [binjection] [bit] NOT NULL,
   [bdialysis] [bit] NOT NULL,
   [bpain] [bit] NOT NULL,
   [ballergy] [bit] NOT NULL,
   [bob] [bit] NOT NULL,
   [btherapy] [bit] NOT NULL,
   [phy_cnt] [smallint] NOT NULL,
   [occu_cnt] [smallint] NOT NULL,
   [speech_cnt] [smallint] NOT NULL,
   [cardaic_cnt] [smallint] NOT NULL,
   [other1] [varchar](10) NOT NULL,
   [other2] [varchar](10) NOT NULL,
   [other3] [varchar](10) NOT NULL,
   [other4] [varchar](10) NOT NULL,
   [other5] [varchar](10) NOT NULL,
   [other6] [varchar](10) NOT NULL,
   [bWorkerComp] [bit] NOT NULL,
   [bautoacc] [bit] NOT NULL,
   [icd9] [varchar](10) NOT NULL,
   [comments] [varchar](225) NOT NULL

   ,CONSTRAINT [PK_referral_michigan_det] PRIMARY KEY CLUSTERED ([ref_mich_det_id])
)


GO
