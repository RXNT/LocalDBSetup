CREATE TABLE [dbo].[doctor_app_info] (
   [dr_id] [int] NOT NULL,
   [PM] [bit] NOT NULL,
   [EHR] [bit] NOT NULL,
   [ERX] [bit] NOT NULL,
   [EPCS] [bit] NOT NULL,
   [SCHEDULER] [bit] NOT NULL

   ,CONSTRAINT [PK_doctor_app_info] PRIMARY KEY CLUSTERED ([dr_id])
)


GO
