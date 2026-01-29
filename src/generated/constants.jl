# Auto-generated constants for NIDAQmx
# Do not edit manually - regenerate using gen/generator.jl

# Buffer properties
const DAQmx_Buf_Input_BufSize = 0x186c
const DAQmx_Buf_Input_OnbrdBufSize = 0x230a
const DAQmx_Buf_Output_BufSize = 0x186d
const DAQmx_Buf_Output_OnbrdBufSize = 0x230b

# Calibration properties
const DAQmx_SelfCal_Supported = 0x1860
const DAQmx_SelfCal_LastTemp = 0x1864
const DAQmx_ExtCal_RecommendedInterval = 0x1868
const DAQmx_ExtCal_LastTemp = 0x1867
const DAQmx_Cal_UserDefinedInfo = 0x1861
const DAQmx_Cal_UserDefinedInfo_MaxSize = 0x191c
const DAQmx_Cal_DevTemp = 0x223b

# AI Channel properties
const DAQmx_AI_Max = 0x17dd
const DAQmx_AI_Min = 0x17de
const DAQmx_AI_CustomScaleName = 0x17e0
const DAQmx_AI_MeasType = 0x0695
const DAQmx_AI_Voltage_Units = 0x1094
const DAQmx_AI_Voltage_dBRef = 0x29b0
const DAQmx_AI_Voltage_ACRMS_Units = 0x17e2
const DAQmx_AI_Temp_Units = 0x1033
const DAQmx_AI_Thrmcpl_Type = 0x1050
const DAQmx_AI_Thrmcpl_ScaleType = 0x29d0
const DAQmx_AI_Thrmcpl_CJCSrc = 0x1035
const DAQmx_AI_Thrmcpl_CJCVal = 0x1036
const DAQmx_AI_Thrmcpl_CJCChan = 0x1034
const DAQmx_AI_RTD_Type = 0x1032
const DAQmx_AI_RTD_R0 = 0x1030
const DAQmx_AI_RTD_A = 0x1010
const DAQmx_AI_RTD_B = 0x1011
const DAQmx_AI_RTD_C = 0x1013
const DAQmx_AI_Current_Units = 0x0701
const DAQmx_AI_Strain_Units = 0x0981
const DAQmx_AI_Resistance_Units = 0x0955
const DAQmx_AI_Freq_Units = 0x0806
const DAQmx_AI_Freq_ThreshVoltage = 0x0815
const DAQmx_AI_Freq_Hyst = 0x0814
const DAQmx_AI_Coupling = 0x0064
const DAQmx_AI_Impedance = 0x0062
const DAQmx_AI_TermCfg = 0x1097
const DAQmx_AI_InputSrc = 0x2198
const DAQmx_AI_ResistanceCfg = 0x1881
const DAQmx_AI_LeadWireResistance = 0x17ee
const DAQmx_AI_Atten = 0x1801
const DAQmx_AI_ProbeAtten = 0x2a88
const DAQmx_AI_Lowpass_Enable = 0x1802
const DAQmx_AI_Lowpass_CutoffFreq = 0x1803
const DAQmx_AI_DigFltr_Enable = 0x30bd
const DAQmx_AI_DigFltr_Type = 0x30be
const DAQmx_AI_DigFltr_Response = 0x30bf
const DAQmx_AI_DigFltr_Order = 0x30c0
const DAQmx_AI_Filter_Enable = 0x3173
const DAQmx_AI_Filter_Freq = 0x3174
const DAQmx_AI_Filter_Response = 0x3175
const DAQmx_AI_Filter_Order = 0x3176
const DAQmx_AI_FilterDelay = 0x2fed
const DAQmx_AI_Resolution = 0x1765
const DAQmx_AI_ResolutionUnits = 0x1764
const DAQmx_AI_RawSampSize = 0x22da
const DAQmx_AI_Rng_High = 0x1815
const DAQmx_AI_Rng_Low = 0x1816
const DAQmx_AI_DCOffset = 0x2a89
const DAQmx_AI_Gain = 0x1818
const DAQmx_AI_SampAndHold_Enable = 0x181a
const DAQmx_AI_AutoZeroMode = 0x1760
const DAQmx_AI_ChopEnable = 0x3143
const DAQmx_AI_DataXferMech = 0x1821
const DAQmx_AI_DataXferReqCond = 0x188b
const DAQmx_AI_MemMapEnable = 0x188c
const DAQmx_AI_Dither_Enable = 0x0068
const DAQmx_AI_DevScalingCoeff = 0x1930
const DAQmx_AI_EnhancedAliasRejectionEnable = 0x2294
const DAQmx_AI_OpenChanDetectEnable = 0x30ff
const DAQmx_AI_Accel_Units = 0x0673
const DAQmx_AI_Accel_Sensitivity = 0x0692
const DAQmx_AI_Accel_SensitivityUnits = 0x219c
const DAQmx_AI_Velocity_Units = 0x2ff4
const DAQmx_AI_Force_Units = 0x2f75
const DAQmx_AI_Pressure_Units = 0x2f76
const DAQmx_AI_Torque_Units = 0x2f77
const DAQmx_AI_Bridge_Units = 0x2f92
const DAQmx_AI_Charge_Units = 0x3112
const DAQmx_AI_Excit_Src = 0x17f4
const DAQmx_AI_Excit_Val = 0x17f5
const DAQmx_AI_Excit_UseForScaling = 0x17fc
const DAQmx_AI_Excit_VoltageOrCurrent = 0x17f6
const DAQmx_AI_Excit_DCorAC = 0x17fb
const DAQmx_AI_ACExcit_Freq = 0x0101
const DAQmx_AI_CurrentShunt_Loc = 0x17f2
const DAQmx_AI_CurrentShunt_Resistance = 0x17f3

# AO Channel properties
const DAQmx_AO_Max = 0x1186
const DAQmx_AO_Min = 0x1187
const DAQmx_AO_CustomScaleName = 0x1188
const DAQmx_AO_OutputType = 0x1108
const DAQmx_AO_Voltage_Units = 0x1184
const DAQmx_AO_Voltage_CurrentLimit = 0x2a1d
const DAQmx_AO_Current_Units = 0x1109
const DAQmx_AO_FuncGen_Type = 0x2a18
const DAQmx_AO_FuncGen_Freq = 0x2a19
const DAQmx_AO_FuncGen_Amplitude = 0x2a1a
const DAQmx_AO_FuncGen_Offset = 0x2a1b
const DAQmx_AO_OutputImpedance = 0x1490
const DAQmx_AO_LoadImpedance = 0x0121
const DAQmx_AO_IdleOutputBehavior = 0x2240
const DAQmx_AO_TermCfg = 0x188e
const DAQmx_AO_Resolution = 0x182c
const DAQmx_AO_ResolutionUnits = 0x182b
const DAQmx_AO_DAC_Rng_High = 0x182e
const DAQmx_AO_DAC_Rng_Low = 0x182d
const DAQmx_AO_DAC_Ref_ConnToGnd = 0x0130
const DAQmx_AO_DAC_Ref_Src = 0x0132
const DAQmx_AO_DAC_Ref_Val = 0x1832
const DAQmx_AO_DAC_Offset_Val = 0x2255
const DAQmx_AO_ReglitchEnable = 0x0133
const DAQmx_AO_FilterDelay = 0x3075
const DAQmx_AO_Gain = 0x0118
const DAQmx_AO_UseOnlyOnBrdMem = 0x183a
const DAQmx_AO_DataXferMech = 0x0134
const DAQmx_AO_DataXferReqCond = 0x183c
const DAQmx_AO_MemMapEnable = 0x188f
const DAQmx_AO_DevScalingCoeff = 0x1931
const DAQmx_AO_EnhancedImageRejectionEnable = 0x2241

# DI Channel properties
const DAQmx_DI_InvertLines = 0x0793
const DAQmx_DI_NumLines = 0x2178
const DAQmx_DI_DigFltr_Enable = 0x21d6
const DAQmx_DI_DigFltr_MinPulseWidth = 0x21d7
const DAQmx_DI_DigFltr_EnableBusMode = 0x2efe
const DAQmx_DI_DigFltr_TimebaseSrc = 0x2ed4
const DAQmx_DI_DigFltr_TimebaseRate = 0x2ed5
const DAQmx_DI_DigSync_Enable = 0x2ed6
const DAQmx_DI_Tristate = 0x1890
const DAQmx_DI_LogicFamily = 0x296d
const DAQmx_DI_DataXferMech = 0x2263
const DAQmx_DI_DataXferReqCond = 0x2264
const DAQmx_DI_MemMapEnable = 0x296a
const DAQmx_DI_AcquireOn = 0x2966

# DO Channel properties
const DAQmx_DO_OutputDriveType = 0x1137
const DAQmx_DO_InvertLines = 0x1133
const DAQmx_DO_NumLines = 0x2179
const DAQmx_DO_Tristate = 0x18f3
const DAQmx_DO_LineStates_StartState = 0x2972
const DAQmx_DO_LineStates_PausedState = 0x2967
const DAQmx_DO_LineStates_DoneState = 0x2968
const DAQmx_DO_LogicFamily = 0x296e
const DAQmx_DO_Overcurrent_Limit = 0x2a85
const DAQmx_DO_Overcurrent_AutoReenable = 0x2a86
const DAQmx_DO_Overcurrent_ReenablePeriod = 0x2a87
const DAQmx_DO_UseOnlyOnBrdMem = 0x2265
const DAQmx_DO_DataXferMech = 0x2266
const DAQmx_DO_DataXferReqCond = 0x2267
const DAQmx_DO_MemMapEnable = 0x296b
const DAQmx_DO_GenerateOn = 0x2969

# CI Channel properties
const DAQmx_CI_Max = 0x189c
const DAQmx_CI_Min = 0x189d
const DAQmx_CI_CustomScaleName = 0x189e
const DAQmx_CI_MeasType = 0x18a0
const DAQmx_CI_Freq_Units = 0x18a1
const DAQmx_CI_Freq_Term = 0x18a2
const DAQmx_CI_Freq_StartingEdge = 0x0799
const DAQmx_CI_Freq_MeasMeth = 0x0144
const DAQmx_CI_Period_Units = 0x18a3
const DAQmx_CI_Period_Term = 0x18a4
const DAQmx_CI_Period_StartingEdge = 0x0852
const DAQmx_CI_Period_MeasMeth = 0x192c
const DAQmx_CI_CountEdges_Term = 0x18c7
const DAQmx_CI_CountEdges_Dir = 0x0696
const DAQmx_CI_CountEdges_InitialCnt = 0x0698
const DAQmx_CI_CountEdges_ActiveEdge = 0x0697
const DAQmx_CI_CountEdges_CountReset_Enable = 0x2faf
const DAQmx_CI_CountEdges_CountReset_ResetCount = 0x2fb0
const DAQmx_CI_CountEdges_CountReset_Term = 0x2fb1
const DAQmx_CI_CountEdges_CountReset_ActiveEdge = 0x2fb4
const DAQmx_CI_CountEdges_Gate_Enable = 0x30ed
const DAQmx_CI_CountEdges_Gate_Term = 0x30ee
const DAQmx_CI_CountEdges_Gate_ActiveEdge = 0x30f1
const DAQmx_CI_Pulse_Freq_Units = 0x2f0b
const DAQmx_CI_Pulse_Freq_Term = 0x2f04
const DAQmx_CI_Pulse_Freq_Start_Edge = 0x2f07
const DAQmx_CI_Pulse_Time_Units = 0x2f13
const DAQmx_CI_Pulse_Time_Term = 0x2f0c
const DAQmx_CI_Pulse_Time_StartEdge = 0x2f0f
const DAQmx_CI_Pulse_Ticks_Term = 0x2f14
const DAQmx_CI_Pulse_Ticks_StartEdge = 0x2f17
const DAQmx_CI_Encoder_DecodingType = 0x21e6
const DAQmx_CI_Encoder_AInputTerm = 0x219d
const DAQmx_CI_Encoder_BInputTerm = 0x219e
const DAQmx_CI_Encoder_ZInputTerm = 0x219f
const DAQmx_CI_Encoder_ZIndexEnable = 0x0890
const DAQmx_CI_Encoder_ZIndexVal = 0x0888
const DAQmx_CI_Encoder_ZIndexPhase = 0x0889
const DAQmx_CI_PulseWidth_Units = 0x0823
const DAQmx_CI_PulseWidth_Term = 0x18aa
const DAQmx_CI_PulseWidth_StartingEdge = 0x0825
const DAQmx_CI_TwoEdgeSep_Units = 0x18ac
const DAQmx_CI_TwoEdgeSep_FirstTerm = 0x18ad
const DAQmx_CI_TwoEdgeSep_FirstEdge = 0x0833
const DAQmx_CI_TwoEdgeSep_SecondTerm = 0x18ae
const DAQmx_CI_TwoEdgeSep_SecondEdge = 0x0834
const DAQmx_CI_SemiPeriod_Units = 0x18af
const DAQmx_CI_SemiPeriod_Term = 0x18b0
const DAQmx_CI_SemiPeriod_StartingEdge = 0x22fe
const DAQmx_CI_Timestamp_Units = 0x22b3
const DAQmx_CI_Timestamp_InitialSeconds = 0x22b4
const DAQmx_CI_CtrTimebaseSrc = 0x0143
const DAQmx_CI_CtrTimebaseRate = 0x18b2
const DAQmx_CI_CtrTimebaseActiveEdge = 0x0142
const DAQmx_CI_Count = 0x0148
const DAQmx_CI_OutputState = 0x0149
const DAQmx_CI_TCReached = 0x0150
const DAQmx_CI_DataXferMech = 0x0200
const DAQmx_CI_NumPossiblyInvalidSamps = 0x193c
const DAQmx_CI_DupCountPrevent = 0x21ac
const DAQmx_CI_Prescaler = 0x2239
const DAQmx_CI_MaxMeasPeriod = 0x3095

# CO Channel properties
const DAQmx_CO_OutputType = 0x18b5
const DAQmx_CO_Pulse_IdleState = 0x1170
const DAQmx_CO_Pulse_Term = 0x18e1
const DAQmx_CO_Pulse_Time_Units = 0x18d6
const DAQmx_CO_Pulse_Time_InitialDelay = 0x0115
const DAQmx_CO_Pulse_Time_HighTime = 0x2f86 # Note: This is also DAQmx_AI_Bridge_InitialRatio
const DAQmx_CO_Pulse_Duty_InitialDelay = 0x0116
const DAQmx_CO_Pulse_Freq_Units = 0x18d5
const DAQmx_CO_Pulse_Freq_InitialDelay = 0x0299
const DAQmx_CO_Pulse_Freq = 0x1178
const DAQmx_CO_Pulse_Freq_DutyCycle = 0x1176
const DAQmx_CO_Pulse_Ticks_InitialDelay = 0x0298
const DAQmx_CO_Pulse_Ticks_HighTicks = 0x1169
const DAQmx_CO_Pulse_Ticks_LowTicks = 0x1171
const DAQmx_CO_CtrTimebaseSrc = 0x0339
const DAQmx_CO_CtrTimebaseRate = 0x18c2
const DAQmx_CO_CtrTimebaseActiveEdge = 0x0341
const DAQmx_CO_Count = 0x0293
const DAQmx_CO_OutputState = 0x0294
const DAQmx_CO_AutoIncrCnt = 0x0295
const DAQmx_CO_EnableInitialDelayOnRetrigger = 0x2ec5
const DAQmx_CO_Prescaler = 0x226d
const DAQmx_CO_ConstrainedGenMode = 0x29c4
const DAQmx_CO_UseOnlyOnBrdMem = 0x2ec3
const DAQmx_CO_DataXferMech = 0x2ec1
const DAQmx_CO_DataXferReqCond = 0x2ec2
const DAQmx_CO_MemMapEnable = 0x2ec4

# Timing properties
const DAQmx_SampQuant_SampMode = 0x1300
const DAQmx_SampQuant_SampPerChan = 0x1310
const DAQmx_SampTimingType = 0x1347
const DAQmx_SampClk_Rate = 0x1344
const DAQmx_SampClk_MaxRate = 0x22c8
const DAQmx_SampClk_Src = 0x1852
const DAQmx_SampClk_ActiveEdge = 0x1301
const DAQmx_SampClk_OverrunBehavior = 0x2efc
const DAQmx_SampClk_UnderflowBehavior = 0x2961
const DAQmx_SampClk_Timebase_Div = 0x18eb
const DAQmx_SampClk_Timebase_Rate = 0x1303
const DAQmx_SampClk_Timebase_Src = 0x1308
const DAQmx_SampClk_Timebase_ActiveEdge = 0x18ec
const DAQmx_SampClk_Timebase_MasterTimebaseDiv = 0x1305
const DAQmx_SampClkTimebase_Term = 0x2f5b
const DAQmx_SampClk_DigFltr_Enable = 0x221e
const DAQmx_SampClk_DigFltr_MinPulseWidth = 0x221f
const DAQmx_SampClk_DigFltr_TimebaseSrc = 0x2220
const DAQmx_SampClk_DigFltr_TimebaseRate = 0x2221
const DAQmx_SampClk_DigSync_Enable = 0x2222
const DAQmx_SampClk_WriteWfm_UseInitialWfmDT = 0x30fc
const DAQmx_Hshk_DelayAfterXfer = 0x22c2
const DAQmx_Hshk_StartCond = 0x22c3
const DAQmx_Hshk_SampleInputDataWhen = 0x22c4
const DAQmx_ChangeDetect_DI_RisingEdgePhysicalChans = 0x2195
const DAQmx_ChangeDetect_DI_FallingEdgePhysicalChans = 0x2196
const DAQmx_ChangeDetect_DI_Tristate = 0x2efa
const DAQmx_OnDemand_SimultaneousAOEnable = 0x21a0
const DAQmx_Implicit_UnderflowBehavior = 0x2efd
const DAQmx_AIConv_Rate = 0x1848
const DAQmx_AIConv_MaxRate = 0x22c9
const DAQmx_AIConv_Src = 0x1502
const DAQmx_AIConv_ActiveEdge = 0x1853
const DAQmx_AIConv_TimebaseDiv = 0x1335
const DAQmx_AIConv_Timebase_Src = 0x1339
const DAQmx_DelayFromSampClk_DelayUnits = 0x1304
const DAQmx_DelayFromSampClk_Delay = 0x1306
const DAQmx_MasterTimebase_Rate = 0x1495
const DAQmx_MasterTimebase_Src = 0x1343
const DAQmx_RefClk_Rate = 0x1315
const DAQmx_RefClk_Src = 0x1316
const DAQmx_SyncPulse_Type = 0x3136
const DAQmx_SyncPulse_Src = 0x223d
const DAQmx_SyncPulse_Time_When = 0x3137
const DAQmx_SyncPulse_Time_Timescale = 0x3138
const DAQmx_SyncPulse_SyncTime = 0x223e
const DAQmx_SyncPulse_MinDelayToStart = 0x223f
const DAQmx_SyncPulse_ResetTime = 0x3139
const DAQmx_SyncPulse_ResetDelay = 0x313a
const DAQmx_SyncPulse_Term = 0x313b
const DAQmx_SyncClk_Interval = 0x2f4e
const DAQmx_SampTimingEngine = 0x2a26
const DAQmx_FirstSampTimestamp_Enable = 0x3139
const DAQmx_FirstSampTimestamp_Timescale = 0x313b
const DAQmx_FirstSampTimestamp_Val = 0x313c
const DAQmx_FirstSampClk_When = 0x3170
const DAQmx_FirstSampClk_Timescale = 0x3171
const DAQmx_FirstSampClk_Offset = 0x31aa

# Trigger properties
const DAQmx_StartTrig_Type = 0x1393
const DAQmx_StartTrig_Term = 0x2f1e
const DAQmx_DigEdge_StartTrig_Src = 0x1407
const DAQmx_DigEdge_StartTrig_Edge = 0x1404
const DAQmx_DigEdge_StartTrig_DigFltr_Enable = 0x2223
const DAQmx_DigEdge_StartTrig_DigFltr_MinPulseWidth = 0x2224
const DAQmx_DigEdge_StartTrig_DigFltr_TimebaseSrc = 0x2225
const DAQmx_DigEdge_StartTrig_DigFltr_TimebaseRate = 0x2226
const DAQmx_DigEdge_StartTrig_DigSync_Enable = 0x2227
const DAQmx_DigPattern_StartTrig_Src = 0x1410
const DAQmx_DigPattern_StartTrig_Pattern = 0x2186
const DAQmx_DigPattern_StartTrig_When = 0x1411
const DAQmx_AnlgEdge_StartTrig_Src = 0x1398
const DAQmx_AnlgEdge_StartTrig_Slope = 0x1397
const DAQmx_AnlgEdge_StartTrig_Lvl = 0x1396
const DAQmx_AnlgEdge_StartTrig_Hyst = 0x1395
const DAQmx_AnlgEdge_StartTrig_Coupling = 0x2233
const DAQmx_AnlgEdge_StartTrig_DigFltr_Enable = 0x2ee6
const DAQmx_AnlgEdge_StartTrig_DigFltr_MinPulseWidth = 0x2ee7
const DAQmx_AnlgEdge_StartTrig_DigFltr_TimebaseSrc = 0x2ee8
const DAQmx_AnlgEdge_StartTrig_DigFltr_TimebaseRate = 0x2ee9
const DAQmx_AnlgEdge_StartTrig_DigSync_Enable = 0x2eea
const DAQmx_AnlgMultiEdge_StartTrig_Srcs = 0x3121
const DAQmx_AnlgMultiEdge_StartTrig_Slopes = 0x3122
const DAQmx_AnlgMultiEdge_StartTrig_Lvls = 0x3123
const DAQmx_AnlgMultiEdge_StartTrig_Hysts = 0x3124
const DAQmx_AnlgMultiEdge_StartTrig_Couplings = 0x3125
const DAQmx_AnlgWin_StartTrig_Src = 0x1400
const DAQmx_AnlgWin_StartTrig_When = 0x1401
const DAQmx_AnlgWin_StartTrig_Top = 0x1403
const DAQmx_AnlgWin_StartTrig_Btm = 0x1402
const DAQmx_AnlgWin_StartTrig_Coupling = 0x2234
const DAQmx_AnlgWin_StartTrig_DigFltr_Enable = 0x2eeb
const DAQmx_AnlgWin_StartTrig_DigFltr_MinPulseWidth = 0x2eec
const DAQmx_AnlgWin_StartTrig_DigFltr_TimebaseSrc = 0x2eed
const DAQmx_AnlgWin_StartTrig_DigFltr_TimebaseRate = 0x2eee
const DAQmx_AnlgWin_StartTrig_DigSync_Enable = 0x2eef
const DAQmx_StartTrig_TrigWhen = 0x304d
const DAQmx_StartTrig_Timescale = 0x3036
const DAQmx_StartTrig_TimestampEnable = 0x314b
const DAQmx_StartTrig_TimestampTimescale = 0x312d
const DAQmx_StartTrig_TimestampVal = 0x314c
const DAQmx_StartTrig_Delay = 0x1856
const DAQmx_StartTrig_DelayUnits = 0x18c8
const DAQmx_StartTrig_Retriggerable = 0x190f
const DAQmx_StartTrig_TrigWin = 0x311a
const DAQmx_StartTrig_RetriggerWin = 0x311b
const DAQmx_StartTrig_MaxNumTrigsToDetect = 0x311c
const DAQmx_RefTrig_Type = 0x1419
const DAQmx_RefTrig_PretrigSamples = 0x1445
const DAQmx_RefTrig_Term = 0x2f1f
const DAQmx_DigEdge_RefTrig_Src = 0x1434
const DAQmx_DigEdge_RefTrig_Edge = 0x1430
const DAQmx_DigPattern_RefTrig_Src = 0x1437
const DAQmx_DigPattern_RefTrig_Pattern = 0x2187
const DAQmx_DigPattern_RefTrig_When = 0x1438
const DAQmx_AnlgEdge_RefTrig_Src = 0x1424
const DAQmx_AnlgEdge_RefTrig_Slope = 0x1423
const DAQmx_AnlgEdge_RefTrig_Lvl = 0x1422
const DAQmx_AnlgEdge_RefTrig_Hyst = 0x1421
const DAQmx_AnlgEdge_RefTrig_Coupling = 0x2235
const DAQmx_AnlgMultiEdge_RefTrig_Srcs = 0x3126
const DAQmx_AnlgMultiEdge_RefTrig_Slopes = 0x3127
const DAQmx_AnlgMultiEdge_RefTrig_Lvls = 0x3128
const DAQmx_AnlgMultiEdge_RefTrig_Hysts = 0x3129
const DAQmx_AnlgMultiEdge_RefTrig_Couplings = 0x312a
const DAQmx_AnlgWin_RefTrig_Src = 0x1426
const DAQmx_AnlgWin_RefTrig_When = 0x1427
const DAQmx_AnlgWin_RefTrig_Top = 0x1429
const DAQmx_AnlgWin_RefTrig_Btm = 0x1428
const DAQmx_AnlgWin_RefTrig_Coupling = 0x1857
const DAQmx_RefTrig_AutoTrigEnable = 0x2ec1
const DAQmx_RefTrig_AutoTriggered = 0x2ec2
const DAQmx_RefTrig_TimestampEnable = 0x312e
const DAQmx_RefTrig_TimestampTimescale = 0x3130
const DAQmx_RefTrig_TimestampVal = 0x312f
const DAQmx_RefTrig_Delay = 0x1483
const DAQmx_RefTrig_Retriggerable = 0x311d
const DAQmx_RefTrig_TrigWin = 0x311e
const DAQmx_RefTrig_RetriggerWin = 0x311f
const DAQmx_RefTrig_MaxNumTrigsToDetect = 0x3120
const DAQmx_AdvTrig_Type = 0x1365
const DAQmx_DigEdge_AdvTrig_Src = 0x1362
const DAQmx_DigEdge_AdvTrig_Edge = 0x1360
const DAQmx_HshkTrig_Type = 0x22b7
const DAQmx_Interlocked_HshkTrig_Src = 0x22b8
const DAQmx_Interlocked_HshkTrig_AssertedLvl = 0x22b9
const DAQmx_PauseTrig_Type = 0x1366
const DAQmx_PauseTrig_Term = 0x2f20
const DAQmx_AnlgLvl_PauseTrig_Src = 0x1370
const DAQmx_AnlgLvl_PauseTrig_When = 0x1371
const DAQmx_AnlgLvl_PauseTrig_Lvl = 0x1369
const DAQmx_AnlgLvl_PauseTrig_Hyst = 0x1368
const DAQmx_AnlgLvl_PauseTrig_Coupling = 0x2236
const DAQmx_AnlgWin_PauseTrig_Src = 0x1373
const DAQmx_AnlgWin_PauseTrig_When = 0x1374
const DAQmx_AnlgWin_PauseTrig_Top = 0x1376
const DAQmx_AnlgWin_PauseTrig_Btm = 0x1375
const DAQmx_AnlgWin_PauseTrig_Coupling = 0x2237
const DAQmx_DigLvl_PauseTrig_Src = 0x1379
const DAQmx_DigLvl_PauseTrig_When = 0x1380
const DAQmx_DigPattern_PauseTrig_Src = 0x216f
const DAQmx_DigPattern_PauseTrig_Pattern = 0x2188
const DAQmx_DigPattern_PauseTrig_When = 0x2170
const DAQmx_ArmStartTrig_Type = 0x1414
const DAQmx_ArmStartTrig_Term = 0x2f7f
const DAQmx_DigEdge_ArmStartTrig_Src = 0x1417
const DAQmx_DigEdge_ArmStartTrig_Edge = 0x1415
const DAQmx_ArmStartTrig_TrigWhen = 0x3131
const DAQmx_ArmStartTrig_Timescale = 0x3132
const DAQmx_ArmStartTrig_TimestampEnable = 0x3133
const DAQmx_ArmStartTrig_TimestampTimescale = 0x3135
const DAQmx_ArmStartTrig_TimestampVal = 0x3134

# Read properties
const DAQmx_Read_RelativeTo = 0x190a
const DAQmx_Read_Offset = 0x190b
const DAQmx_Read_ChannelsToRead = 0x1823
const DAQmx_Read_ReadAllAvailSamp = 0x1215
const DAQmx_Read_AutoStart = 0x1826
const DAQmx_Read_OverWrite = 0x1211
const DAQmx_Read_CurrReadPos = 0x1221
const DAQmx_Read_AvailSampPerChan = 0x1223
const DAQmx_Read_TotalSampPerChanAcquired = 0x192a
const DAQmx_Read_CommonModeRangeErrorChansExist = 0x2a98
const DAQmx_Read_CommonModeRangeErrorChans = 0x2a99
const DAQmx_Read_ExcitFaultChansExist = 0x3088
const DAQmx_Read_ExcitFaultChans = 0x3089
const DAQmx_Read_OpenChansExist = 0x3100
const DAQmx_Read_OpenChans = 0x3101
const DAQmx_Read_OpenChansDetails = 0x3102
const DAQmx_Read_OpenCurrentLoopChansExist = 0x2a09
const DAQmx_Read_OpenCurrentLoopChans = 0x2a0a
const DAQmx_Read_OpenThrmcplChansExist = 0x2a96
const DAQmx_Read_OpenThrmcplChans = 0x2a97
const DAQmx_Read_OvercurrentChansExist = 0x29e6
const DAQmx_Read_OvercurrentChans = 0x29e7
const DAQmx_Read_OvertemperatureChansExist = 0x3082
const DAQmx_Read_OvertemperatureChans = 0x3083
const DAQmx_Read_OverloadedChansExist = 0x2174
const DAQmx_Read_OverloadedChans = 0x2175
const DAQmx_Read_AccessoryInsertionOrRemovalDetected = 0x3104
const DAQmx_Read_DevsWithInsertedOrRemovedAccessories = 0x3105
const DAQmx_Read_ChangeDetect_HasOverflowed = 0x2194
const DAQmx_Read_RawDataWidth = 0x217a
const DAQmx_Read_NumChans = 0x217b
const DAQmx_Read_DigitalLines_BytesPerChan = 0x217c
const DAQmx_Read_WaitMode = 0x2232
const DAQmx_Read_SleepTime = 0x22b0

# Write properties
const DAQmx_Write_RelativeTo = 0x190c
const DAQmx_Write_Offset = 0x190d
const DAQmx_Write_RegenMode = 0x1453
const DAQmx_Write_CurrWritePos = 0x1458
const DAQmx_Write_OvercurrentChansExist = 0x29e8
const DAQmx_Write_OvercurrentChans = 0x29e9
const DAQmx_Write_OvertemperatureChansExist = 0x2a84
const DAQmx_Write_OvertemperatureChans = 0x3084
const DAQmx_Write_ExternalOvervoltageChansExist = 0x30bb
const DAQmx_Write_ExternalOvervoltageChans = 0x30bc
const DAQmx_Write_OpenCurrentLoopChansExist = 0x29ea
const DAQmx_Write_OpenCurrentLoopChans = 0x29eb
const DAQmx_Write_PowerSupplyFaultChansExist = 0x29ec
const DAQmx_Write_PowerSupplyFaultChans = 0x29ed
const DAQmx_Write_SpaceAvail = 0x1460
const DAQmx_Write_TotalSampPerChanGenerated = 0x192b
const DAQmx_Write_AccessoryInsertionOrRemovalDetected = 0x3106
const DAQmx_Write_DevsWithInsertedOrRemovedAccessories = 0x3107
const DAQmx_Write_RawDataWidth = 0x217d
const DAQmx_Write_NumChans = 0x217e
const DAQmx_Write_WaitMode = 0x22b1
const DAQmx_Write_SleepTime = 0x22b2
const DAQmx_Write_DigitalLines_BytesPerChan = 0x228f

# Task properties
const DAQmx_Task_Name = 0x1276
const DAQmx_Task_Channels = 0x1273
const DAQmx_Task_NumChans = 0x2181
const DAQmx_Task_Devices = 0x230e
const DAQmx_Task_NumDevices = 0x29ba
const DAQmx_Task_Complete = 0x1274

# Device properties
const DAQmx_Dev_IsSimulated = 0x22ca
const DAQmx_Dev_ProductCategory = 0x0237
const DAQmx_Dev_ProductType = 0x0631
const DAQmx_Dev_ProductNum = 0x231d
const DAQmx_Dev_SerialNum = 0x0632
const DAQmx_Dev_Accessory_ProductTypes = 0x2f6d
const DAQmx_Dev_Accessory_ProductNums = 0x2f6e
const DAQmx_Dev_Accessory_SerialNums = 0x2f6f
const DAQmx_Dev_Chassis_ModuleDevNames = 0x29b6
const DAQmx_Dev_AnlgTrigSupported = 0x2984
const DAQmx_Dev_DigTrigSupported = 0x2985
const DAQmx_Dev_TimeTrigSupported = 0x301f
const DAQmx_Dev_AI_PhysicalChans = 0x231e
const DAQmx_Dev_AI_SupportedMeasTypes = 0x2fd2
const DAQmx_Dev_AI_MaxSingleChanRate = 0x298c
const DAQmx_Dev_AI_MaxMultiChanRate = 0x298d
const DAQmx_Dev_AI_MinRate = 0x298e
const DAQmx_Dev_AI_SimultaneousSamplingSupported = 0x298f
const DAQmx_Dev_AI_NumSampTimingEngines = 0x3163
const DAQmx_Dev_AI_SampModes = 0x2fdc
const DAQmx_Dev_AI_NumSyncPulseSrcs = 0x3164
const DAQmx_Dev_AI_TrigUsage = 0x2986
const DAQmx_Dev_AI_VoltageRngs = 0x2990
const DAQmx_Dev_AI_VoltageIntExcitDiscreteVals = 0x29c9
const DAQmx_Dev_AI_VoltageIntExcitRangeVals = 0x29ca
const DAQmx_Dev_AI_ChargeRngs = 0x3111
const DAQmx_Dev_AI_CurrentRngs = 0x2991
const DAQmx_Dev_AI_CurrentIntExcitDiscreteVals = 0x29cb
const DAQmx_Dev_AI_BridgeRngs = 0x2f93
const DAQmx_Dev_AI_ResistanceRngs = 0x2a15
const DAQmx_Dev_AI_FreqRngs = 0x2992
const DAQmx_Dev_AI_Gains = 0x2993
const DAQmx_Dev_AI_Couplings = 0x2994
const DAQmx_Dev_AI_LowpassCutoffFreqDiscreteVals = 0x2995
const DAQmx_Dev_AI_LowpassCutoffFreqRangeVals = 0x29cf
const DAQmx_Dev_AI_DigFltr_Types = 0x30c8
const DAQmx_Dev_AI_DigFltr_LowpassCutoffFreqDiscreteVals = 0x30c9
const DAQmx_Dev_AI_DigFltr_LowpassCutoffFreqRangeVals = 0x30cb
const DAQmx_Dev_AO_PhysicalChans = 0x231f
const DAQmx_Dev_AO_SupportedOutputTypes = 0x2fd3
const DAQmx_Dev_AO_MaxRate = 0x2997
const DAQmx_Dev_AO_MinRate = 0x2998
const DAQmx_Dev_AO_SampClkSupported = 0x2996
const DAQmx_Dev_AO_NumSampTimingEngines = 0x3165
const DAQmx_Dev_AO_SampModes = 0x2fdd
const DAQmx_Dev_AO_NumSyncPulseSrcs = 0x3166
const DAQmx_Dev_AO_TrigUsage = 0x2987
const DAQmx_Dev_AO_VoltageRngs = 0x299b
const DAQmx_Dev_AO_CurrentRngs = 0x299c
const DAQmx_Dev_AO_Gains = 0x299d
const DAQmx_Dev_DI_Lines = 0x2320
const DAQmx_Dev_DI_Ports = 0x2321
const DAQmx_Dev_DI_MaxRate = 0x2999
const DAQmx_Dev_DI_NumSampTimingEngines = 0x3167
const DAQmx_Dev_DI_TrigUsage = 0x2988
const DAQmx_Dev_DO_Lines = 0x2322
const DAQmx_Dev_DO_Ports = 0x2323
const DAQmx_Dev_DO_MaxRate = 0x299a
const DAQmx_Dev_DO_NumSampTimingEngines = 0x3168
const DAQmx_Dev_DO_TrigUsage = 0x2989
const DAQmx_Dev_CI_PhysicalChans = 0x2324
const DAQmx_Dev_CI_SupportedMeasTypes = 0x2fd4
const DAQmx_Dev_CI_TrigUsage = 0x298a
const DAQmx_Dev_CI_SampClkSupported = 0x299e
const DAQmx_Dev_CI_SampModes = 0x2fde
const DAQmx_Dev_CI_MaxSize = 0x299f
const DAQmx_Dev_CI_MaxTimebase = 0x29a0
const DAQmx_Dev_CO_PhysicalChans = 0x2325
const DAQmx_Dev_CO_SupportedOutputTypes = 0x2fd5
const DAQmx_Dev_CO_SampClkSupported = 0x2f5b
const DAQmx_Dev_CO_SampModes = 0x2fdf
const DAQmx_Dev_CO_TrigUsage = 0x298b
const DAQmx_Dev_CO_MaxSize = 0x29a1
const DAQmx_Dev_CO_MaxTimebase = 0x29a2
const DAQmx_Dev_TEDS_HWTEDSSupported = 0x2fda
const DAQmx_Dev_NumDMAChans = 0x233c
const DAQmx_Dev_BusType = 0x2326
const DAQmx_Dev_PCI_BusNum = 0x2327
const DAQmx_Dev_PCI_DevNum = 0x2328
const DAQmx_Dev_PXI_ChassisNum = 0x2329
const DAQmx_Dev_PXI_SlotNum = 0x232a
const DAQmx_Dev_CompactDAQ_ChassisDevName = 0x29b7
const DAQmx_Dev_CompactDAQ_SlotNum = 0x29b8
const DAQmx_Dev_CompactRIO_ChassisDevName = 0x3161
const DAQmx_Dev_CompactRIO_SlotNum = 0x3162
const DAQmx_Dev_TCPIP_Hostname = 0x2a8b
const DAQmx_Dev_TCPIP_EthernetIP = 0x2a8c
const DAQmx_Dev_TCPIP_WirelessIP = 0x2a8d
const DAQmx_Dev_Terminals = 0x2a40
const DAQmx_Dev_NumTimeTrigs = 0x3141
const DAQmx_Dev_NumTimestampEngines = 0x3142

# System properties
const DAQmx_Sys_GlobalChans = 0x1265
const DAQmx_Sys_Scales = 0x1266
const DAQmx_Sys_Tasks = 0x1267
const DAQmx_Sys_DevNames = 0x0632
const DAQmx_Sys_NIDAQMajorVersion = 0x1272
const DAQmx_Sys_NIDAQMinorVersion = 0x1923
const DAQmx_Sys_NIDAQUpdateVersion = 0x2f22

# Scale properties
const DAQmx_Scale_Descr = 0x1226
const DAQmx_Scale_ScaledUnits = 0x191b
const DAQmx_Scale_PreScaledUnits = 0x18f7
const DAQmx_Scale_Type = 0x1929
const DAQmx_Scale_Lin_Slope = 0x1227
const DAQmx_Scale_Lin_YIntercept = 0x1228
const DAQmx_Scale_Map_ScaledMax = 0x1229
const DAQmx_Scale_Map_PreScaledMax = 0x1231
const DAQmx_Scale_Map_ScaledMin = 0x1230
const DAQmx_Scale_Map_PreScaledMin = 0x1232
const DAQmx_Scale_Poly_ForwardCoeff = 0x1234
const DAQmx_Scale_Poly_ReverseCoeff = 0x1235
const DAQmx_Scale_Table_ScaledVals = 0x1236
const DAQmx_Scale_Table_PreScaledVals = 0x1237

# Values for enumerations (Val_*)

# Edge values
const DAQmx_Val_Rising = 10280
const DAQmx_Val_Falling = 10171

# Terminal configurations
const DAQmx_Val_Cfg_Default = -1
const DAQmx_Val_RSE = 10083
const DAQmx_Val_NRSE = 10078
const DAQmx_Val_Diff = 10106
const DAQmx_Val_PseudoDiff = 12529

# Units
const DAQmx_Val_Volts = 10348
const DAQmx_Val_Amps = 10342
const DAQmx_Val_DegC = 10143
const DAQmx_Val_DegF = 10144
const DAQmx_Val_Kelvins = 10325
const DAQmx_Val_DegR = 10145
const DAQmx_Val_Seconds = 10364
const DAQmx_Val_Ticks = 10304
const DAQmx_Val_Hz = 10373
const DAQmx_Val_Strain = 10299
const DAQmx_Val_Ohms = 10384
const DAQmx_Val_Meters = 10219
const DAQmx_Val_Inches = 10379
const DAQmx_Val_Degrees = 10146
const DAQmx_Val_Radians = 10273
const DAQmx_Val_g = 10186
const DAQmx_Val_MetersPerSecondSquared = 12470
const DAQmx_Val_Newtons = 15875
const DAQmx_Val_Pounds = 15876
const DAQmx_Val_KilogramForce = 15877
const DAQmx_Val_PoundsPerSquareInch = 15879
const DAQmx_Val_Bar = 15880
const DAQmx_Val_Pascals = 10081
const DAQmx_Val_VoltsPerVolt = 15896
const DAQmx_Val_mVoltsPerVolt = 15897
const DAQmx_Val_NewtonMeters = 15881
const DAQmx_Val_InchOunces = 15882
const DAQmx_Val_InchPounds = 15883
const DAQmx_Val_FootPounds = 15884
const DAQmx_Val_FromCustomScale = 10065

# Channel types
const DAQmx_Val_AI = 10100
const DAQmx_Val_AO = 10102
const DAQmx_Val_DI = 10151
const DAQmx_Val_DO = 10153
const DAQmx_Val_CI = 10131
const DAQmx_Val_CO = 10132

# AI measurement types
const DAQmx_Val_Voltage = 10322
const DAQmx_Val_VoltageRMS = 10350
const DAQmx_Val_Current = 10134
const DAQmx_Val_CurrentRMS = 10351
const DAQmx_Val_Voltage_CustomWithExcitation = 10323
const DAQmx_Val_Bridge = 15908
const DAQmx_Val_Freq_Voltage = 10181
const DAQmx_Val_Resistance = 10278
const DAQmx_Val_Temp_TC = 10303
const DAQmx_Val_Temp_Thrmstr = 10302
const DAQmx_Val_Temp_RTD = 10301
const DAQmx_Val_Temp_BuiltInSensor = 10311
const DAQmx_Val_Strain_Gage = 10300
const DAQmx_Val_Rosette_Strain_Gage = 15980
const DAQmx_Val_Position_LVDT = 10352
const DAQmx_Val_Position_RVDT = 10353
const DAQmx_Val_Position_EddyCurrentProximityProbe = 14835
const DAQmx_Val_Accelerometer = 10356
const DAQmx_Val_AccelCharge = 16104
const DAQmx_Val_Accel4WireDCVoltage = 16106
const DAQmx_Val_Velocity_IEPESensor = 15966
const DAQmx_Val_Force_Bridge = 15899
const DAQmx_Val_Force_IEPESensor = 15895
const DAQmx_Val_Pressure_Bridge = 15902
const DAQmx_Val_SoundPressure_Microphone = 10354
const DAQmx_Val_Torque_Bridge = 15905
const DAQmx_Val_TEDS_Sensor = 12531
const DAQmx_Val_Charge = 16105
const DAQmx_Val_Power = 16201

# AO output types
const DAQmx_Val_ChannelVoltage = 10322
const DAQmx_Val_ChannelCurrent = 10134
const DAQmx_Val_FuncGen = 14750

# CI measurement types
const DAQmx_Val_CountEdges = 10125
const DAQmx_Val_Freq = 10179
const DAQmx_Val_Period = 10256
const DAQmx_Val_PulseWidth = 10359
const DAQmx_Val_SemiPeriod = 10289
const DAQmx_Val_PulseFrequency = 15864
const DAQmx_Val_PulseTime = 15865
const DAQmx_Val_PulseTicks = 15866
const DAQmx_Val_DutyCycle = 16070
const DAQmx_Val_Position_AngEncoder = 10360
const DAQmx_Val_Position_LinEncoder = 10361
const DAQmx_Val_Velocity_AngEncoder = 16078
const DAQmx_Val_Velocity_LinEncoder = 16079
const DAQmx_Val_TwoEdgeSep = 10267
const DAQmx_Val_GPS_Timestamp = 10362

# CO output types
const DAQmx_Val_Pulse_Time = 10269
const DAQmx_Val_Pulse_Freq = 10119
const DAQmx_Val_Pulse_Ticks = 10268

# Timing modes
const DAQmx_Val_FiniteSamps = 10178
const DAQmx_Val_ContSamps = 10123
const DAQmx_Val_HWTimedSinglePoint = 12522

# Sample timing types
const DAQmx_Val_SampClk = 10388
const DAQmx_Val_BurstHandshake = 12548
const DAQmx_Val_Handshake = 10389
const DAQmx_Val_Implicit = 10451
const DAQmx_Val_OnDemand = 10390
const DAQmx_Val_ChangeDetection = 12504
const DAQmx_Val_PipelinedSampClk = 14668

# Fill modes
const DAQmx_Val_GroupByChannel = 0
const DAQmx_Val_GroupByScanNumber = 1

# Line grouping
const DAQmx_Val_ChanPerLine = 0
const DAQmx_Val_ChanForAllLines = 1

# Trigger types
const DAQmx_Val_None = 10230
const DAQmx_Val_AnlgEdge = 10099
const DAQmx_Val_AnlgMultiEdge = 16108
const DAQmx_Val_DigEdge = 10150
const DAQmx_Val_DigPattern = 10398
const DAQmx_Val_AnlgWin = 10103
const DAQmx_Val_Time = 15996
const DAQmx_Val_AnlgLvl = 10101

# Slope
const DAQmx_Val_RisingSlope = 10280
const DAQmx_Val_FallingSlope = 10171

# Count direction
const DAQmx_Val_CountUp = 10128
const DAQmx_Val_CountDown = 10124
const DAQmx_Val_ExtControlled = 10326

# Level
const DAQmx_Val_High = 10192
const DAQmx_Val_Low = 10214

# Coupling
const DAQmx_Val_AC = 10045
const DAQmx_Val_DC = 10050
const DAQmx_Val_GND = 10066

# Idle state
const DAQmx_Val_IdleStateLow = 10214
const DAQmx_Val_IdleStateHigh = 10192

# Logic family
const DAQmx_Val_2point5V = 14620
const DAQmx_Val_3point3V = 14621
const DAQmx_Val_5V = 14619

# Data transfer mechanisms
const DAQmx_Val_DMA = 10054
const DAQmx_Val_Interrupts = 10204
const DAQmx_Val_ProgrammedIO = 10264
const DAQmx_Val_USBbulk = 12590

# Overwrite modes
const DAQmx_Val_OverwriteUnreadSamps = 10252
const DAQmx_Val_DoNotOverwriteUnreadSamps = 10159

# Regeneration modes
const DAQmx_Val_AllowRegen = 10097
const DAQmx_Val_DoNotAllowRegen = 10158

# Read position relative to
const DAQmx_Val_FirstSample = 10424
const DAQmx_Val_CurrReadPos = 10425
const DAQmx_Val_RefTrig = 10426
const DAQmx_Val_FirstPretrigSamp = 10427
const DAQmx_Val_MostRecentSamp = 10428

# Write position relative to
const DAQmx_Val_FirstSampleWrite = 10424
const DAQmx_Val_CurrWritePos = 10430

# Wait mode
const DAQmx_Val_WaitForInterrupt = 12523
const DAQmx_Val_Poll = 12524
const DAQmx_Val_Yield = 12525
const DAQmx_Val_Sleep = 12547

# Encoding types
const DAQmx_Val_X1 = 10090
const DAQmx_Val_X2 = 10091
const DAQmx_Val_X4 = 10092
const DAQmx_Val_TwoPulseCounting = 10313

# Z-index phase
const DAQmx_Val_AHighBHigh = 10040
const DAQmx_Val_AHighBLow = 10041
const DAQmx_Val_ALowBHigh = 10042
const DAQmx_Val_ALowBLow = 10043

# Digital output drive type
const DAQmx_Val_ActiveDrive = 12573
const DAQmx_Val_OpenCollector = 12574

# Frequency measurement methods
const DAQmx_Val_LowFreq1Ctr = 10105
const DAQmx_Val_HighFreq2Ctr = 10157
const DAQmx_Val_LargeRng2Ctr = 10205

# Action types
const DAQmx_Val_Task_Start = 0
const DAQmx_Val_Task_Stop = 1
const DAQmx_Val_Task_Verify = 2
const DAQmx_Val_Task_Commit = 3
const DAQmx_Val_Task_Reserve = 4
const DAQmx_Val_Task_Unreserve = 5
const DAQmx_Val_Task_Abort = 6

# Excitation sources
const DAQmx_Val_Internal = 10200
const DAQmx_Val_External = 10167
const DAQmx_Val_Default = -1

# Shunt resistor location
const DAQmx_Val_Default = -1
const DAQmx_Val_Internal = 10200
const DAQmx_Val_External = 10167

# Bridge configurations
const DAQmx_Val_FullBridge = 10182
const DAQmx_Val_HalfBridge = 10187
const DAQmx_Val_QuarterBridge = 10270
const DAQmx_Val_NoBridge = 10228

# Strain gauge configurations
const DAQmx_Val_FullBridgeI = 10183
const DAQmx_Val_FullBridgeII = 10184
const DAQmx_Val_FullBridgeIII = 10185
const DAQmx_Val_HalfBridgeI = 10188
const DAQmx_Val_HalfBridgeII = 10189
const DAQmx_Val_QuarterBridgeI = 10271
const DAQmx_Val_QuarterBridgeII = 10272

# Thermocouple types
const DAQmx_Val_J_Type_TC = 10072
const DAQmx_Val_K_Type_TC = 10073
const DAQmx_Val_N_Type_TC = 10077
const DAQmx_Val_R_Type_TC = 10082
const DAQmx_Val_S_Type_TC = 10085
const DAQmx_Val_T_Type_TC = 10086
const DAQmx_Val_B_Type_TC = 10047
const DAQmx_Val_E_Type_TC = 10055

# RTD types
const DAQmx_Val_Pt3750 = 12481
const DAQmx_Val_Pt3851 = 10071
const DAQmx_Val_Pt3911 = 12482
const DAQmx_Val_Pt3916 = 10069
const DAQmx_Val_Pt3920 = 10053
const DAQmx_Val_Pt3928 = 12483
const DAQmx_Val_Custom = 10137

# Resistance configurations
const DAQmx_Val_2Wire = 2
const DAQmx_Val_3Wire = 3
const DAQmx_Val_4Wire = 4

# Sensitivity units
const DAQmx_Val_mVoltsPerG = 12509
const DAQmx_Val_VoltsPerG = 12510

# Accelerometer units
const DAQmx_Val_AccelUnit_g = 10186
const DAQmx_Val_AccelUnit_MetersPerSecondSquared = 12470

# Device types/bus types
const DAQmx_Val_PCI = 12582
const DAQmx_Val_PCIe = 13612
const DAQmx_Val_PXI = 12583
const DAQmx_Val_PXIe = 14706
const DAQmx_Val_SCXI = 12584
const DAQmx_Val_SCC = 14707
const DAQmx_Val_PCCard = 12585
const DAQmx_Val_USB = 12586
const DAQmx_Val_CompactDAQ = 14637
const DAQmx_Val_CompactRIO = 16143
const DAQmx_Val_TCPIP = 14828
const DAQmx_Val_Unknown = 12588
const DAQmx_Val_SwitchBlock = 15870

# Product categories
const DAQmx_Val_MSeriesDAQ = 14643
const DAQmx_Val_XSeriesDAQ = 15858
const DAQmx_Val_ESeriesDAQ = 14642
const DAQmx_Val_SSeriesDAQ = 14644
const DAQmx_Val_BSeriesDAQ = 14662
const DAQmx_Val_SCSeriesDAQ = 14645
const DAQmx_Val_USBDAQ = 14646
const DAQmx_Val_AOSeries = 14647
const DAQmx_Val_DigitalIO = 14648
const DAQmx_Val_TIOSeries = 14661
const DAQmx_Val_DynamicSignalAcquisition = 14649
const DAQmx_Val_Switches = 14650
const DAQmx_Val_CompactDAQChassis = 14658
const DAQmx_Val_CompactRIOChassis = 16144
const DAQmx_Val_CSeriesModule = 14659
const DAQmx_Val_SCXIModule = 14660
const DAQmx_Val_SCCConnectorBlock = 14704
const DAQmx_Val_SCCModule = 14705
const DAQmx_Val_NIELVIS = 14755
const DAQmx_Val_NetworkDAQ = 14829
const DAQmx_Val_SCExpress = 15886
const DAQmx_Val_FieldDAQ = 16151
const DAQmx_Val_TestScaleChassis = 16180
const DAQmx_Val_TestScaleModule = 16181
const DAQmx_Val_Unknown = 12588
