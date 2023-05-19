CREATE TABLE [dbo].[ScriptGuideNPIExclusions] (
   [SGNPIExclusionID] [int] NOT NULL
      IDENTITY (1,1),
   [ForSGID] [int] NOT NULL,
   [NPI] [varchar](50) NOT NULL

   ,CONSTRAINT [PK_ScriptGuideNPIExclusions] PRIMARY KEY CLUSTERED ([SGNPIExclusionID])
)

CREATE NONCLUSTERED INDEX [NC_ScriptGuideNPIExclusions_ForSGID] ON [dbo].[ScriptGuideNPIExclusions] ([ForSGID])

GO
