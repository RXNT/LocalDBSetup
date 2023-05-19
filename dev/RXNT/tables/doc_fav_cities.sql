CREATE TABLE [dbo].[doc_fav_cities] (
   [fc_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [fc_state] [varchar](2) NOT NULL,
   [fc_city] [varchar](50) NOT NULL

   ,CONSTRAINT [PK_dov_fav_cities] PRIMARY KEY NONCLUSTERED ([fc_id])
)

CREATE UNIQUE NONCLUSTERED INDEX [DrCityState_NoDups] ON [dbo].[doc_fav_cities] ([dr_id], [fc_state], [fc_city])

GO
