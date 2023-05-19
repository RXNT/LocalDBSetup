CREATE TABLE [dbo].[lab_result_place_srv] (
   [labsrv_id] [int] NOT NULL
      IDENTITY (1,1),
   [lab_result_info_id] [int] NOT NULL,
   [fac_mnem] [varchar](500) NOT NULL,
   [fac_name] [varchar](500) NOT NULL,
   [fac_addr] [varchar](500) NOT NULL,
   [fac_city] [varchar](500) NOT NULL,
   [fac_state] [varchar](500) NOT NULL,
   [fac_zip] [varchar](500) NOT NULL,
   [fac_phone] [varchar](500) NOT NULL,
   [fac_dr] [varchar](500) NOT NULL,
   [fac_lab_id] [varchar](500) NULL,
   [fac_clia] [varchar](500) NOT NULL

   ,CONSTRAINT [PK_lab_result_place_srv] PRIMARY KEY CLUSTERED ([labsrv_id])
)

CREATE NONCLUSTERED INDEX [_dta_index_lab_result_place_srv_7_1476304419__K2_1_3_4_5_6_7_8_9_10_11_12] ON [dbo].[lab_result_place_srv] ([lab_result_info_id]) INCLUDE ([fac_addr], [fac_city], [fac_clia], [fac_dr], [fac_lab_id], [fac_mnem], [fac_name], [fac_phone], [fac_state], [fac_zip], [labsrv_id])

GO
