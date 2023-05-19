CREATE TABLE [dbo].[lab_result_specimen] (
   [spm_info_id] [int] NOT NULL
      IDENTITY (1,1),
   [lab_id] [int] NOT NULL,
   [lab_order_id] [int] NOT NULL,
   [spm_id] [varchar](500) NOT NULL,
   [spm_text] [varchar](500) NOT NULL,
   [spm_rcv_dt] [datetime] NULL,
   [spm_src] [varchar](500) NOT NULL,
   [srp_reject_reason] [varchar](1000) NOT NULL,
   [spm_condition] [varchar](1000) NULL,
   [spm_collection_time_start] [datetime] NULL

   ,CONSTRAINT [PK__lab_result_speci__5B451F22] PRIMARY KEY CLUSTERED ([spm_info_id])
)


GO
