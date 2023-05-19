CREATE TABLE [epa].[epa_transaction_log] (
   [epa_transaction_log_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [dc_id] [int] NOT NULL,
   [pa_reference_id] [varchar](100) NOT NULL,
   [epa_response_status_code] [varchar](10) NULL,
   [epa_response_description_code] [varchar](10) NULL,
   [epa_response_description] [varchar](1000) NULL,
   [pa_init_request_xml] [varchar](max) NOT NULL,
   [pa_init_request_json] [varchar](max) NOT NULL,
   [pa_init_response_xml] [varchar](max) NULL,
   [pa_init_api_response_json] [varchar](max) NULL,
   [created_date] [datetime2] NOT NULL,
   [created_by] [int] NULL,
   [modified_date] [datetime2] NULL,
   [modified_by] [int] NULL,
   [inactivated_date] [datetime2] NULL,
   [inactivated_by] [int] NULL

   ,CONSTRAINT [PK_epa_transaction_log] PRIMARY KEY CLUSTERED ([epa_transaction_log_id])
)


GO
