CREATE TABLE [dbo].[enchanced_encounter_log] (
   [transaction_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [enc_id] [bigint] NOT NULL,
   [type] [varchar](1024) NOT NULL,
   [dr_id] [bigint] NOT NULL,
   [patient_id] [bigint] NOT NULL,
   [enc_xml] [ntext] NULL,
   [enc_json] [nvarchar](max) NULL,
   [created_on] [datetime] NULL,
   [created_by] [bigint] NULL,
   [enc_date] [datetime] NULL,
   [action_dr_id] [bigint] NULL,
   [action_id] [bigint] NULL,
   [action_date] [datetime] NULL,
   [comments] [varchar](100) NULL,
   [external_encounter_id] [varchar](250) NULL,
   [is_signed] [bit] NULL,
   [smart_form_id] [varchar](50) NULL

   ,CONSTRAINT [PK_enchanced_encounter_log] PRIMARY KEY CLUSTERED ([transaction_id])
)


GO
