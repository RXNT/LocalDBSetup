CREATE TABLE [dbo].[doc_group_fav_scripts_sig_details] (
   [script_sig_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [script_id] [int] NOT NULL,
   [sig_sequence_number] [int] NULL,
   [sig_action] [varchar](50) NULL,
   [sig_qty] [varchar](50) NULL,
   [sig_form] [varchar](50) NULL,
   [sig_route] [varchar](50) NULL,
   [sig_time_qty] [varchar](50) NULL,
   [sig_time_option] [varchar](100) NULL

   ,CONSTRAINT [PK_doc_group_fav_scripts_sig_details] PRIMARY KEY CLUSTERED ([script_sig_id])
)


GO
