CREATE TABLE [dbo].[tblHealthGuidelines_Ex1] (
   [rule_id] [bigint] NULL,
   [RuleFilterConditions] [xml] NULL,
   [rule_message] [varchar](max) NULL,
   [email_template_id] [bigint] NULL,
   [mail_template_id] [bigint] NULL,
   [telephone_template_id] [bigint] NULL,
   [sms_template_id] [bigint] NULL,
   [caller_phone_id] [bigint] NULL,
   [RuleLastExecutedOn] [datetime] NULL,
   [RuleNextExecutionOn] [datetime] NULL
)


GO
