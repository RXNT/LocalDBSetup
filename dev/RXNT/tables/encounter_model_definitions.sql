CREATE TABLE [dbo].[encounter_model_definitions] (
   [model_defn_id] [int] NOT NULL
      IDENTITY (1,1),
   [type] [varchar](225) NOT NULL,
   [definition] [xml] NULL,
   [json_definition] [nvarchar](max) NULL,
   [json_modified] [bit] NULL

   ,CONSTRAINT [PK_encounter_model_definitions] PRIMARY KEY CLUSTERED ([model_defn_id])
)


GO
