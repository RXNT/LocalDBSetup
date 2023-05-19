CREATE TABLE [bk].[MUMeasureCounts] (
   [Id] [bigint] NOT NULL,
   [MUMeasuresId] [int] NOT NULL,
   [MeasureCode] [varchar](3) NOT NULL,
   [dc_id] [int] NOT NULL,
   [dg_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [enc_id] [int] NULL,
   [enc_date] [datetime] NULL,
   [DateAdded] [datetime] NOT NULL,
   [IsNumerator] [bit] NOT NULL,
   [IsDenominator] [bit] NOT NULL,
   [RecordCreateUserId] [int] NULL,
   [RecordCreateDateTime] [datetime] NOT NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
