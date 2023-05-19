CREATE TABLE [dbo].[DoctorGroupUsageFlags] (
   [DoctorGroupId] [bigint] NOT NULL,
   [UsageFlags] [tinyint] NOT NULL,
   [CreatedBy] [bigint] NULL,
   [CreatedDate] [datetime] NULL

   ,CONSTRAINT [PK_DoctorGroupUsageFlags] PRIMARY KEY CLUSTERED ([DoctorGroupId])
)


GO
