CREATE TABLE [dbo].[LongRunningCapture] (
   [ID] [int] NOT NULL
      IDENTITY (1,1),
   [ObjectName] [varchar](100) NULL,
   [statement_text] [varchar](max) NULL,
   [DatabaseName] [varchar](50) NULL,
   [CPU_Time] [int] NULL,
   [RunningMinutes] [int] NULL,
   [Percent_Complete] [int] NULL,
   [RunningFrom] [varchar](100) NULL,
   [RunningBy] [varchar](250) NULL,
   [SessionID] [int] NULL,
   [BlockingWith] [int] NULL,
   [reads] [int] NULL,
   [writes] [int] NULL,
   [program_name] [varchar](250) NULL,
   [login_name] [varchar](50) NULL,
   [status] [varchar](25) NULL,
   [last_request_start_time] [datetime] NULL,
   [logical_reads] [bigint] NULL

)

CREATE CLUSTERED INDEX [IDX_LongRunningCapture_ID] ON [dbo].[LongRunningCapture] ([ID])
CREATE NONCLUSTERED INDEX [IDX_LongRunningCapture_last_request_start_time] ON [dbo].[LongRunningCapture] ([last_request_start_time])

GO
