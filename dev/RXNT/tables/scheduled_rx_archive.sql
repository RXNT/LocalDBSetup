CREATE TABLE [dbo].[scheduled_rx_archive] (
   [pres_id] [int] NOT NULL,
   [pd_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [pa_first] [varchar](50) NOT NULL,
   [pa_middle] [varchar](50) NOT NULL,
   [pa_last] [varchar](50) NOT NULL,
   [pa_dob] [smalldatetime] NOT NULL,
   [pa_gender] [varchar](1) NOT NULL,
   [pa_address1] [varchar](100) NOT NULL,
   [pa_address2] [varchar](100) NOT NULL,
   [pa_city] [varchar](50) NOT NULL,
   [pa_state] [varchar](2) NOT NULL,
   [pa_zip] [varchar](20) NOT NULL,
   [dr_id] [int] NOT NULL,
   [dg_id] [int] NOT NULL,
   [dr_first_name] [varchar](50) NOT NULL,
   [dr_middle_initial] [varchar](10) NOT NULL,
   [dr_last_name] [varchar](50) NOT NULL,
   [dr_address1] [varchar](100) NOT NULL,
   [dr_address2] [varchar](100) NOT NULL,
   [dr_city] [varchar](30) NOT NULL,
   [dr_state] [varchar](50) NOT NULL,
   [dr_zip] [varchar](20) NOT NULL,
   [dr_dea_numb] [varchar](30) NOT NULL,
   [ddid] [int] NOT NULL,
   [drug_name] [varchar](125) NOT NULL,
   [dosage] [varchar](255) NOT NULL,
   [qty] [varchar](20) NOT NULL,
   [units] [varchar](50) NOT NULL,
   [days_supply] [int] NOT NULL,
   [refills] [int] NOT NULL,
   [approved_date] [smalldatetime] NOT NULL,
   [signature] [varchar](max) NOT NULL,
   [scheduled_rx_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [signature_version] [varchar](10) NULL

   ,CONSTRAINT [IX_scheduled_rx_archive] UNIQUE NONCLUSTERED ([pres_id], [pd_id])
   ,CONSTRAINT [PK_scheduled_rx_archive] PRIMARY KEY NONCLUSTERED ([scheduled_rx_id])
)

CREATE CLUSTERED INDEX [IX_scheduled_rx_archive_1] ON [dbo].[scheduled_rx_archive] ([dg_id])
CREATE NONCLUSTERED INDEX [IX_scheduled_rx_archive_2] ON [dbo].[scheduled_rx_archive] ([pa_id], [dr_id])

GO
