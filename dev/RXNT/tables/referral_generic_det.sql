CREATE TABLE [dbo].[referral_generic_det] (
   [ref_det_id] [int] NOT NULL
      IDENTITY (1,1),
   [ref_reason] [varchar](255) NOT NULL,
   [ref_description] [varchar](2000) NOT NULL,
   [numb_visits] [smallint] NOT NULL,
   [icd9] [varchar](15) NULL,
   [description] [varchar](255) NULL,
   [icd10] [varchar](20) NULL

   ,CONSTRAINT [PK_referral_generic_det] PRIMARY KEY CLUSTERED ([ref_det_id])
)


GO
