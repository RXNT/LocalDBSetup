CREATE TABLE [dbo].[erx_patients] (
   [erx_pa_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [dg_id] [int] NOT NULL,
   [dc_id] [int] NOT NULL,
   [pa_first] [varchar](50) NOT NULL,
   [pa_last] [varchar](50) NOT NULL,
   [pa_middle] [varchar](50) NOT NULL,
   [pa_dob] [smalldatetime] NOT NULL,
   [pa_sex] [char](1) NOT NULL,
   [pa_address1] [varchar](100) NOT NULL,
   [pa_address2] [varchar](100) NOT NULL,
   [pa_city] [varchar](50) NOT NULL,
   [pa_state] [varchar](2) NOT NULL,
   [pa_zip] [varchar](20) NOT NULL,
   [pa_phone] [varchar](20) NOT NULL,
   [pa_ext] [varchar](10) NULL,
   [pa_email] [varchar](50) NULL,
   [ins_code] [varchar](20) NULL

   ,CONSTRAINT [PK_erx_patients] PRIMARY KEY CLUSTERED ([erx_pa_id])
)


GO
