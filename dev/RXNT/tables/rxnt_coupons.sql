CREATE TABLE [dbo].[rxnt_coupons] (
   [coupon_id] [int] NOT NULL
      IDENTITY (1,1),
   [med_id] [int] NOT NULL,
   [offer_id] [varchar](50) NULL,
   [med_name] [varchar](125) NOT NULL,
   [med_resolution_type] [tinyint] NOT NULL,
   [start_date] [smalldatetime] NOT NULL,
   [end_date] [smalldatetime] NOT NULL,
   [sponsor_id] [smallint] NOT NULL,
   [is_complete] [bit] NOT NULL,
   [filename] [varchar](1024) NULL,
   [sex_filter] [varchar](1) NULL,
   [age_filter] [bit] NOT NULL,
   [min_age] [smallint] NOT NULL,
   [max_age] [smallint] NOT NULL,
   [state_exclusion] [varchar](1024) NULL,
   [zip_codes] [varchar](1024) NULL,
   [speciality_codes] [varchar](1024) NULL,
   [rx_bin] [varchar](50) NULL,
   [rx_grp] [varchar](50) NULL,
   [rx_pcn] [varchar](50) NULL,
   [rx_bin_coords] [varchar](50) NULL,
   [rx_grp_coords] [varchar](50) NULL,
   [rx_pcn_coords] [varchar](50) NULL,
   [rx_id_coords] [varchar](50) NULL,
   [pharmacy_comments] [varchar](500) NULL,
   [is_pharm_comment] [bit] NOT NULL,
   [is_new_pat] [bit] NOT NULL,
   [rx_payer_id] [varchar](50) NULL,
   [rx_payer_name] [varchar](50) NULL,
   [rx_payer_type] [varchar](50) NULL,
   [title] [varchar](30) NOT NULL,
   [disclaimer] [varchar](255) NULL

   ,CONSTRAINT [PK_rxnt_coupons] PRIMARY KEY CLUSTERED ([coupon_id])
)

CREATE NONCLUSTERED INDEX [IX_rxnt_coupons] ON [dbo].[rxnt_coupons] ([start_date], [end_date], [med_id])

GO
