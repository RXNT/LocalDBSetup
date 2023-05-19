CREATE TABLE [dbo].[ScriptGuideProgramSpecifications] (
   [sg_id] [int] NOT NULL
      IDENTITY (1,1),
   [drug_name] [varchar](70) NOT NULL,
   [drug_id] [int] NOT NULL,
   [start_date] [smalldatetime] NOT NULL,
   [end_date] [smalldatetime] NOT NULL,
   [drug_id_type] [tinyint] NOT NULL,
   [trigger_type] [tinyint] NULL,
   [trigger_age_min] [int] NULL,
   [trigger_age_max] [int] NULL,
   [trigger_sex] [varchar](10) NULL,
   [control_factor] [float] NOT NULL,
   [scriptguide_file] [varchar](100) NULL,
   [test_count] [int] NULL,
   [control_count] [int] NULL,
   [total_count] AS ([test_count]+[control_count]),
   [sg_desc_text] [varchar](100) NOT NULL,
   [exclude_states] [varchar](255) NULL,
   [CODE] [varchar](5) NULL,
   [bRequireCoupon] [bit] NOT NULL,
   [bIsActive] [bit] NOT NULL,
   [rxbin] [varchar](100) NULL,
   [rxpcn] [varchar](100) NULL,
   [rxgrp] [varchar](100) NULL,
   [rxsuf] [varchar](100) NULL

   ,CONSTRAINT [PK_ScriptGuideProgramSpecifications] PRIMARY KEY CLUSTERED ([sg_id])
)


GO
