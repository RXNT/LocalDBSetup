CREATE TABLE [dbo].[rxnt_patient_coupons] (
   [patient_coupon_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [med_id] [int] NOT NULL,
   [med_name] [varchar](125) NOT NULL,
   [filename] [varchar](1024) NULL,
   [coupon_id_coords] [varchar](50) NULL,
   [brochure_url] [varchar](100) NULL,
   [title] [varchar](30) NOT NULL,
   [disclaimer] [varchar](255) NULL

   ,CONSTRAINT [PK_rxnt_patient_coupons] PRIMARY KEY CLUSTERED ([patient_coupon_id])
)


GO
