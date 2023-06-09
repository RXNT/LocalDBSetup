CREATE TABLE [dbo].[refill_requests_archive] (
   [refreq_id] [int] NOT NULL,
   [dg_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [pharm_id] [int] NOT NULL,
   [pharm_ncpdp] [varchar](15) NULL,
   [refreq_date] [datetime] NOT NULL,
   [trc_number] [varchar](50) NULL,
   [ctrl_number] [varchar](50) NULL,
   [recverVector] [varchar](50) NULL,
   [senderVector] [varchar](50) NULL,
   [pres_id] [int] NULL,
   [response_type] [int] NULL,
   [init_date] [datetime] NULL,
   [msg_date] [datetime] NULL,
   [response_id] [varchar](15) NULL,
   [status_code] [varchar](15) NULL,
   [status_code_qualifier] [varchar](15) NULL,
   [status_msg] [varchar](255) NULL,
   [response_conf_date] [smalldatetime] NULL,
   [error_string] [varchar](255) NULL,
   [pres_fill_time] [datetime] NULL,
   [msg_ref_number] [varchar](35) NOT NULL,
   [drug_name] [varchar](125) NULL,
   [drug_ndc] [varchar](11) NULL,
   [drug_form] [varchar](3) NULL,
   [drug_strength] [varchar](70) NULL,
   [drug_strength_units] [varchar](3) NULL,
   [qty1] [varchar](35) NULL,
   [qty1_units] [varchar](3) NULL,
   [qty1_enum] [tinyint] NULL,
   [qty2] [varchar](35) NULL,
   [qty2_units] [varchar](3) NULL,
   [qty2_enum] [tinyint] NULL,
   [dosage1] [varchar](70) NULL,
   [dosage2] [varchar](70) NULL,
   [days_supply] [int] NULL,
   [date1] [smalldatetime] NULL,
   [date1_enum] [tinyint] NULL,
   [date2] [smalldatetime] NULL,
   [date2_enum] [tinyint] NULL,
   [date3] [smalldatetime] NULL,
   [date3_enum] [tinyint] NULL,
   [substitution_code] [tinyint] NULL,
   [refills] [varchar](35) NULL,
   [refills_enum] [tinyint] NULL,
   [void_comments] [varchar](255) NULL,
   [void_code] [smallint] NULL,
   [comments1] [varchar](70) NULL,
   [comments2] [varchar](70) NULL,
   [comments3] [varchar](70) NULL,
   [disp_drug_info] [bit] NOT NULL,
   [supervisor] [varchar](100) NULL,
   [SupervisorSeg] [varchar](500) NULL,
   [PharmSeg] [varchar](500) NULL,
   [PatientSeg] [varchar](500) NULL,
   [DoctorSeg] [varchar](500) NULL,
   [DispDRUSeg] [varchar](5000) NULL,
   [PrescDRUSeg] [varchar](7999) NULL

   ,CONSTRAINT [PK_refill_requests_archive] PRIMARY KEY CLUSTERED ([refreq_id])
)


GO
