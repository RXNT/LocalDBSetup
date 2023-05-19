CREATE TABLE [bk].[lab_main] (
   [lab_id] [int] NOT NULL,
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
   [lab_order_master_id] [bigint] NULL,
   [type] [varchar](10) NOT NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
