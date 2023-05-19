CREATE TABLE [dbo].[rxnt_sg_promotions] (
   [ad_id] [int] NOT NULL
      IDENTITY (1,1),
   [medid] [int] NOT NULL,
   [med_name] [varchar](255) NOT NULL,
   [dtStart] [smalldatetime] NULL,
   [dtEnd] [smalldatetime] NULL,
   [state_exclusion] [varchar](225) NULL,
   [min_age] [int] NOT NULL,
   [iscomplete] [bit] NOT NULL,
   [max_age] [int] NOT NULL,
   [gender] [varchar](2) NULL,
   [ctrl_fac] [float] NOT NULL,
   [message] [varchar](max) NULL,
   [name] [varchar](100) NULL,
   [session_count] [bigint] NULL,
   [current_count] [bigint] NULL,
   [type] [smallint] NOT NULL,
   [speciality_1] [tinyint] NOT NULL,
   [speciality_2] [tinyint] NOT NULL,
   [speciality_3] [tinyint] NOT NULL,
   [url] [varchar](255) NOT NULL,
   [clickthroughs] [int] NOT NULL,
   [sponsor_id] [int] NOT NULL,
   [increments] [bigint] NULL,
   [message_2] [varchar](100) NULL,
   [previous_count] [int] NULL,
   [Active] [bit] NULL,
   [CreatedDate] [datetime2] NULL,
   [CreatedBy] [bigint] NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [resource_path] [varchar](200) NULL,
   [TargetedPlatform] [varchar](64) NULL,
   [Drugs] [varchar](5000) NULL,
   [ICD10] [varchar](5000) NULL,
   [Speciality] [varchar](5000) NULL,
   [CampaignId] [varchar](20) NULL

   ,CONSTRAINT [PK_rxnt_sg_promotions] PRIMARY KEY CLUSTERED ([ad_id])
)

CREATE NONCLUSTERED INDEX [IX_rxnt_sg_promotions] ON [dbo].[rxnt_sg_promotions] ([dtStart], [dtEnd], [iscomplete], [medid])

GO
