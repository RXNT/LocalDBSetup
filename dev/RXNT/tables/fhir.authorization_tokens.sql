CREATE TABLE [fhir].[authorization_tokens] (
   [id] [int] NOT NULL
      IDENTITY (1,1),
   [relates_to_message_id] [varchar](30) NULL,
   [authorization_token] [varchar](200) NULL,
   [response] [varchar](2000) NULL,
   [created_on] [datetime] NULL,
   [expires_on] [datetime] NULL

   ,CONSTRAINT [PK_authorization_tokens] PRIMARY KEY CLUSTERED ([id])
)


GO
