CREATE TABLE [dbo].[patient_next_of_kin] (
   [pa_id] [bigint] NULL,
   [kin_relation_code] [varchar](3) NULL,
   [kin_first] [varchar](35) NULL,
   [kin_middle] [varchar](35) NULL,
   [kin_last] [varchar](35) NULL,
   [kin_address1] [varchar](35) NULL,
   [kin_city] [varchar](35) NULL,
   [kin_state] [varchar](2) NULL,
   [kin_zip] [varchar](20) NULL,
   [kin_country] [varchar](10) NULL,
   [kin_phone] [varchar](20) NULL,
   [kin_email] [varchar](50) NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [kin_pref_phone] [varchar](10) NULL,
   [kin_id] [int] NOT NULL
      IDENTITY (1,1)

   ,CONSTRAINT [pk_patient_next_of_kin_kin_id] PRIMARY KEY CLUSTERED ([kin_id])
)

CREATE NONCLUSTERED INDEX [IDX_patient_next_of_kin_pa_id] ON [dbo].[patient_next_of_kin] ([pa_id])

GO
