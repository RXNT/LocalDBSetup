CREATE TABLE [dbo].[lab_main] (
   [lab_id] [int] NOT NULL
      IDENTITY (1,1),
   [send_appl] [varchar](1000) NOT NULL,
   [send_facility] [varchar](1000) NULL,
   [rcv_appl] [varchar](1000) NOT NULL,
   [rcv_facility] [varchar](1000) NOT NULL,
   [message_date] [datetime] NOT NULL,
   [message_type] [varchar](50) NOT NULL,
   [message_ctrl_id] [varchar](100) NULL,
   [version] [varchar](10) NOT NULL,
   [component_sep] [varchar](1) NOT NULL,
   [subcomponent_sep] [varchar](1) NOT NULL,
   [escape_delim] [varchar](1) NOT NULL,
   [filename] [varchar](500) NULL,
   [dr_id] [int] NOT NULL,
   [pat_id] [int] NOT NULL,
   [dg_id] [int] NOT NULL,
   [is_read] [bit] NOT NULL,
   [read_by] [int] NULL,
   [PROV_NAME] [varchar](500) NOT NULL,
   [comments] [varchar](7000) NULL,
   [result_file_path] [varchar](255) NULL,
   [type] [varchar](10) NOT NULL,
   [lab_order_master_id] [bigint] NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [InformationBlockingReasonId] [int] NULL,
   [visibility_hidden_to_patient] [bit] NULL

   ,CONSTRAINT [PK_lab_main] PRIMARY KEY CLUSTERED ([lab_id])
)

CREATE NONCLUSTERED INDEX [_dta_index_lab_main_7_59251366__K6_K17_K16_K1_2_3_4_5_7_8_9_10_11_12_13_14_15_18_19_20] ON [dbo].[lab_main] ([message_date], [is_read], [dg_id], [lab_id]) INCLUDE ([comments], [component_sep], [dr_id], [escape_delim], [filename], [message_ctrl_id], [message_type], [pat_id], [PROV_NAME], [rcv_appl], [rcv_facility], [read_by], [send_appl], [send_facility], [subcomponent_sep], [version])
CREATE NONCLUSTERED INDEX [IX_lab_main] ON [dbo].[lab_main] ([pat_id], [dg_id], [dr_id], [message_date] DESC)
CREATE NONCLUSTERED INDEX [ix_lab_main_dg_id_is_read] ON [dbo].[lab_main] ([dg_id], [is_read])
CREATE NONCLUSTERED INDEX [ix_lab_main_dr_id_is_read] ON [dbo].[lab_main] ([dr_id], [is_read])

GO
