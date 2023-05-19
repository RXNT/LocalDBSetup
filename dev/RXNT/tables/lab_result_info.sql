CREATE TABLE [dbo].[lab_result_info] (
   [lab_result_info_id] [int] NOT NULL
      IDENTITY (1,1),
   [lab_id] [int] NOT NULL,
   [lab_order_id] [int] NOT NULL,
   [spm_id] [varchar](500) NOT NULL,
   [filler_acc_id] [varchar](500) NOT NULL,
   [obs_bat_ident] [varchar](500) NOT NULL,
   [obs_ba_test] [varchar](500) NOT NULL,
   [obs_cod_sys] [varchar](500) NOT NULL,
   [obs_date] [datetime] NOT NULL,
   [coll_vol] [varchar](500) NULL,
   [act_code] [tinyint] NOT NULL,
   [rel_cl_info] [varchar](500) NULL,
   [dt_spm_rcv] [datetime] NOT NULL,
   [spm_src] [varchar](500) NULL,
   [ord_prv_id] [varchar](500) NULL,
   [ord_prv_first] [varchar](500) NULL,
   [ord_prv_last] [varchar](500) NULL,
   [ord_prv_mi] [varchar](500) NULL,
   [ord_prv_id_src] [varchar](500) NULL,
   [ord_prv_id_typ] [varchar](500) NULL,
   [prod_fld] [varchar](500) NULL,
   [obs_rel_dt] [datetime] NOT NULL,
   [prod_sec_id] [varchar](500) NULL,
   [ord_result_status] [tinyint] NULL,
   [parent_result] [varchar](500) NULL,
   [parent_result_sub_id] [varchar](500) NULL,
   [priority] [nchar](10) NULL,
   [parent_ord_numb] [varchar](500) NULL,
   [notes] [varchar](max) NULL,
   [callbackno] [varchar](500) NULL,
   [fon_namespace_id] [varchar](20) NULL,
   [fon_uid] [varchar](20) NULL,
   [fon_uid_type] [varchar](20) NULL,
   [ord_prv_prefix] [varchar](10) NULL,
   [ord_prv_suffix] [varchar](10) NULL,
   [ord_prv_id_namespace_id] [varchar](35) NULL,
   [ord_prv_id_uid] [varchar](20) NULL,
   [ord_prv_id_uid_type] [varchar](20) NULL,
   [ord_prv_name_type] [varchar](10) NULL

   ,CONSTRAINT [PK_lab_result_info] PRIMARY KEY CLUSTERED ([lab_result_info_id])
)

CREATE NONCLUSTERED INDEX [_dta_index_lab_result_info_7_2139258776__K3_K1_2_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_30] ON [dbo].[lab_result_info] ([lab_order_id], [lab_result_info_id]) INCLUDE ([act_code], [callbackno], [coll_vol], [dt_spm_rcv], [filler_acc_id], [lab_id], [obs_ba_test], [obs_bat_ident], [obs_cod_sys], [obs_date], [obs_rel_dt], [ord_prv_first], [ord_prv_id], [ord_prv_id_src], [ord_prv_id_typ], [ord_prv_last], [ord_prv_mi], [ord_result_status], [parent_ord_numb], [parent_result], [parent_result_sub_id], [priority], [prod_fld], [prod_sec_id], [rel_cl_info], [spm_id], [spm_src])
CREATE NONCLUSTERED INDEX [IX_lab_result_info-lab_id-lab_result_info_id] ON [dbo].[lab_result_info] ([lab_id]) INCLUDE ([lab_result_info_id])

GO
