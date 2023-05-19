CREATE TABLE [dbo].[MUMeasureCounts] (
   [Id] [bigint] NOT NULL
      IDENTITY (1,1),
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
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL

   ,CONSTRAINT [PK_MUMeasureCounts] PRIMARY KEY CLUSTERED ([Id])
)

CREATE NONCLUSTERED INDEX [_dta_index_MUMeasureCounts_7_1584880863__K7_K3_K10_K12_K11] ON [dbo].[MUMeasureCounts] ([pa_id], [MeasureCode], [DateAdded], [IsDenominator], [IsNumerator])
CREATE NONCLUSTERED INDEX [idx_MUMeasureCounts_MeasureCode_dr_id_DateAdded] ON [dbo].[MUMeasureCounts] ([MeasureCode], [dr_id], [DateAdded])
CREATE NONCLUSTERED INDEX [IDX_MUMeasureCounts_pa_id] ON [dbo].[MUMeasureCounts] ([pa_id]) INCLUDE ([active], [DateAdded], [dc_id], [dg_id], [dr_id], [enc_date], [enc_id], [Id], [IsDenominator], [IsNumerator], [last_modified_by], [last_modified_date], [MeasureCode], [MUMeasuresId], [RecordCreateDateTime], [RecordCreateUserId])
CREATE NONCLUSTERED INDEX [ix_MUMeasureCounts_enc_id_IsNumerator_includes] ON [dbo].[MUMeasureCounts] ([enc_id], [IsNumerator]) INCLUDE ([Id], [MeasureCode])

GO
