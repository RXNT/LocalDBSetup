CREATE TABLE [epa].[epa_token_log] (
   [epa_token_log_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dc_id] [int] NOT NULL,
   [provider_spi] [varchar](100) NOT NULL,
   [end_user_id] [int] NOT NULL,
   [pa_auth_request_json] [varchar](max) NOT NULL,
   [pa_auth_response_json] [varchar](max) NULL,
   [pa_auth_api_response_json] [varchar](max) NULL,
   [created_date] [datetime2] NOT NULL,
   [created_by] [int] NULL,
   [modified_date] [datetime2] NULL,
   [modified_by] [int] NULL,
   [inactivated_date] [datetime2] NULL,
   [inactivated_by] [int] NULL

   ,CONSTRAINT [PK_epa_token_log] PRIMARY KEY CLUSTERED ([epa_token_log_id])
)


GO
