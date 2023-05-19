CREATE TABLE [dbo].[rxhub_eligibility_details_log] (
   [redl_id] [int] NOT NULL
      IDENTITY (1,1),
   [rel_id] [int] NOT NULL,
   [responding_src] [varchar](50) NOT NULL,
   [formulary_id] [varchar](15) NULL,
   [alternative_id] [varchar](15) NULL,
   [response_code] [varchar](15) NOT NULL,
   [response_string] [varchar](255) NULL,
   [comments] [varchar](255) NULL,
   [request_data] [text] NULL,
   [response_data] [text] NULL

   ,CONSTRAINT [PK_rxhub_eligibility_details_log] PRIMARY KEY CLUSTERED ([redl_id])
)


GO
