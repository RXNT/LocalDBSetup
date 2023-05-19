CREATE TABLE [dbo].[prescription_sig_details] (
   [pd_sig_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [pd_id] [bigint] NULL,
   [sig_sequence_number] [int] NULL,
   [sig_action] [varchar](50) NULL,
   [sig_qty] [varchar](50) NULL,
   [sig_form] [varchar](50) NULL,
   [sig_route] [varchar](50) NULL,
   [sig_time_qty] [varchar](50) NULL,
   [sig_time_option] [varchar](100) NULL,
   [drug_indication] [varchar](50) NULL

   ,CONSTRAINT [PK_prescription_sig_details] PRIMARY KEY CLUSTERED ([pd_sig_id])
)

CREATE NONCLUSTERED INDEX [NonClusteredIndex-20170620-133738] ON [dbo].[prescription_sig_details] ([pd_id])

GO
