CREATE TABLE [dbo].[referral_maryland_details] (
   [referral_md_det_id] [int] NOT NULL
      IDENTITY (1,1),
   [referral_reason] [varchar](225) NOT NULL,
   [brief_history_text] [varchar](1000) NOT NULL,
   [bInitConsult] [bit] NOT NULL,
   [bConsultAndTreat] [bit] NOT NULL,
   [bDiagnosticTest] [bit] NOT NULL,
   [bSpecificConsult] [bit] NOT NULL,
   [specific_consult_text] [varchar](225) NOT NULL,
   [bSpecificTreatement] [bit] NOT NULL,
   [specific_treatement_text] [varchar](225) NOT NULL,
   [bGlobalOB] [bit] NOT NULL,
   [global_ob_text] [varchar](50) NOT NULL,
   [bOther] [bit] NOT NULL,
   [other_text] [varchar](50) NOT NULL,
   [visit_numb] [smallint] NOT NULL,
   [auth_id] [varchar](20) NOT NULL,
   [bOfficeService] [bit] NOT NULL,
   [bAllSites] [bit] NOT NULL,
   [bOutpatientCenter] [bit] NOT NULL,
   [bRadiology] [bit] NOT NULL,
   [bLab] [bit] NOT NULL,
   [bInpatientHospital] [bit] NOT NULL,
   [bExtendedCare] [bit] NOT NULL,
   [bOtherServicePlace] [bit] NOT NULL,
   [other_place_text] [varchar](50) NOT NULL,
   [diag_text] [varchar](255) NOT NULL

   ,CONSTRAINT [PK_referral_maryland_details] PRIMARY KEY CLUSTERED ([referral_md_det_id])
)


GO
