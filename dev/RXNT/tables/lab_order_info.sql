CREATE TABLE [dbo].[lab_order_info] (
   [lab_report_id] [int] NOT NULL
      IDENTITY (1,1),
   [lab_id] [int] NOT NULL,
   [spm_id] [varchar](1000) NOT NULL,
   [filler_acc_id] [varchar](1000) NOT NULL,
   [order_date] [datetime] NOT NULL,
   [ord_prv_id] [varchar](1000) NOT NULL,
   [ord_prv_first] [varchar](100) NULL,
   [ord_prv_last] [varchar](100) NULL,
   [ord_prv_mi] [varchar](100) NULL,
   [ord_prv_id_src] [varchar](100) NULL,
   [ord_prv_id_typ] [varchar](100) NULL,
   [priority] [varchar](100) NULL,
   [callback_no] [varchar](100) NULL,
   [pon_namespace_id] [varchar](200) NULL,
   [pon_uid] [varchar](200) NULL,
   [pon_uid_type] [varchar](200) NULL,
   [placer_group_number] [varchar](300) NULL,
   [pgn_namespace_id] [varchar](300) NULL,
   [pgn_uid] [varchar](200) NULL,
   [pgn_uid_type] [varchar](200) NULL

   ,CONSTRAINT [PK_lab_order_info] PRIMARY KEY CLUSTERED ([lab_report_id])
)

CREATE NONCLUSTERED INDEX [_dta_index_lab_order_info_7_139251651__K2_K1_3_4_5_6_7_8_9_10_11_12_13] ON [dbo].[lab_order_info] ([lab_id], [lab_report_id]) INCLUDE ([callback_no], [filler_acc_id], [ord_prv_first], [ord_prv_id], [ord_prv_id_src], [ord_prv_id_typ], [ord_prv_last], [ord_prv_mi], [order_date], [priority], [spm_id])

GO
