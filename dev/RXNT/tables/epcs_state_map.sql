CREATE TABLE [dbo].[epcs_state_map] (
   [state] [varchar](2) NOT NULL,
   [min_drug_schedule] [tinyint] NOT NULL

   ,CONSTRAINT [PK_epcs_state_map] PRIMARY KEY CLUSTERED ([state])
)


GO
