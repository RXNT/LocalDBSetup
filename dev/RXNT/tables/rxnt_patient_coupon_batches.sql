CREATE TABLE [dbo].[rxnt_patient_coupon_batches] (
   [cp_bt_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [patient_coupon_id] [bigint] NOT NULL,
   [pa_coupon_batch_id] [bigint] NOT NULL

   ,CONSTRAINT [PK_rxnt_patient_coupon_batches] PRIMARY KEY CLUSTERED ([cp_bt_id])
)


GO
