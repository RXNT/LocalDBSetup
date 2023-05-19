CREATE TABLE [dbo].[referral_dr_carrier_ids] (
   [ref_car_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [dr_local] [bit] NOT NULL,
   [provider_id1] [varchar](20) NOT NULL,
   [provider_id2] [varchar](20) NOT NULL,
   [CARRIER_XREF_ID] [int] NOT NULL

   ,CONSTRAINT [PK_referral_dr_carrier_ids] PRIMARY KEY CLUSTERED ([ref_car_id])
)


GO
