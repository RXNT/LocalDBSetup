CREATE TABLE [dbo].[rxnt_patient_coupon_identifiers] (
   [coupon_identifier_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [pa_coupon_batch_id] [bigint] NOT NULL,
   [client_provided_id] [varchar](50) NOT NULL,
   [expiry_date] [datetime] NULL,
   [taken_date] [datetime] NULL,
   [taken_by_pa_id] [bigint] NULL,
   [taken_batch_id] [varchar](50) NULL,
   [is_used] [bit] NOT NULL,
   [used_by_pa_id] [bigint] NULL,
   [used_date] [datetime] NULL

   ,CONSTRAINT [PK_rxnt_patient_coupon_identifiers] PRIMARY KEY CLUSTERED ([coupon_identifier_id])
)


GO
