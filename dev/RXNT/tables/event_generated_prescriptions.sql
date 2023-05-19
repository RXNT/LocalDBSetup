CREATE TABLE [dbo].[event_generated_prescriptions] (
   [egp_id] [int] NOT NULL
      IDENTITY (1,1),
   [pd_id] [int] NOT NULL,
   [parent_pd_id] [int] NOT NULL,
   [fire_date] [datetime] NOT NULL,
   [se_id] [int] NOT NULL

   ,CONSTRAINT [PK_event_generated_prescriptions] PRIMARY KEY CLUSTERED ([egp_id])
)


GO
