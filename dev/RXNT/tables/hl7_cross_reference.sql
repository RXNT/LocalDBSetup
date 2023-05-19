CREATE TABLE [dbo].[hl7_cross_reference] (
   [hl7_cr_id] [int] NOT NULL
      IDENTITY (1,1),
   [application] [varchar](50) NOT NULL,
   [hl7_prac_id] [varchar](255) NOT NULL,
   [dc_id] [int] NOT NULL,
   [uid] [varchar](10) NOT NULL,
   [pwd] [varchar](10) NOT NULL,
   [allergy_upload] [bit] NOT NULL,
   [enabled] [bit] NOT NULL,
   [diagnosis_upload] [bit] NOT NULL,
   [sched_upload] [bit] NOT NULL,
   [chart_no] [bit] NOT NULL,
   [recvFacility] [varchar](50) NULL,
   [recvApp] [varchar](50) NULL,
   [IsAlternativeID] [bit] NULL

   ,CONSTRAINT [PK_hl7_cross_reference] PRIMARY KEY NONCLUSTERED ([hl7_cr_id])
)

CREATE UNIQUE CLUSTERED INDEX [UniqueApplicationHL7Id] ON [dbo].[hl7_cross_reference] ([application], [hl7_prac_id])
CREATE UNIQUE NONCLUSTERED INDEX [UniquePracIDs] ON [dbo].[hl7_cross_reference] ([dc_id], [application], [hl7_prac_id])

GO
