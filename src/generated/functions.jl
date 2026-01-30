# Auto-generated function bindings for NI-DAQmx
# Do not edit manually - regenerate using gen/generator.jl

# Task management
function DAQmxLoadTask(taskName::Ptr{Cchar}, taskHandle::Ptr{TaskHandle})
    ccall((:DAQmxLoadTask, libnidaq), int32, (Ptr{Cchar}, Ptr{TaskHandle}), taskName, taskHandle)
end

function DAQmxCreateTask(taskName::Ptr{Cchar}, taskHandle::Ptr{TaskHandle})
    ccall((:DAQmxCreateTask, libnidaq), int32, (Ptr{Cchar}, Ptr{TaskHandle}), taskName, taskHandle)
end

function DAQmxStartTask(taskHandle::TaskHandle)
    ccall((:DAQmxStartTask, libnidaq), int32, (TaskHandle,), taskHandle)
end

function DAQmxStopTask(taskHandle::TaskHandle)
    ccall((:DAQmxStopTask, libnidaq), int32, (TaskHandle,), taskHandle)
end

function DAQmxClearTask(taskHandle::TaskHandle)
    ccall((:DAQmxClearTask, libnidaq), int32, (TaskHandle,), taskHandle)
end

function DAQmxWaitUntilTaskDone(taskHandle::TaskHandle, timeToWait::float64)
    ccall((:DAQmxWaitUntilTaskDone, libnidaq), int32, (TaskHandle, float64), taskHandle, timeToWait)
end

function DAQmxIsTaskDone(taskHandle::TaskHandle, isTaskDone::Ptr{bool32})
    ccall((:DAQmxIsTaskDone, libnidaq), int32, (TaskHandle, Ptr{bool32}), taskHandle, isTaskDone)
end

function DAQmxTaskControl(taskHandle::TaskHandle, action::int32)
    ccall((:DAQmxTaskControl, libnidaq), int32, (TaskHandle, int32), taskHandle, action)
end

function DAQmxGetTaskNumChans(taskHandle::TaskHandle, data::Ref{uInt32})
    ccall((:DAQmxGetTaskNumChans, libnidaq), int32, (TaskHandle, Ptr{uInt32}), taskHandle, data)
end

function DAQmxGetTaskName(taskHandle::TaskHandle, data::Ptr{Cchar}, bufferSize::uInt32)
    ccall((:DAQmxGetTaskName, libnidaq), int32, (TaskHandle, Ptr{Cchar}, uInt32), taskHandle, data, bufferSize)
end

function DAQmxGetTaskChannels(taskHandle::TaskHandle, data::Ptr{Cchar}, bufferSize::uInt32)
    ccall((:DAQmxGetTaskChannels, libnidaq), int32, (TaskHandle, Ptr{Cchar}, uInt32), taskHandle, data, bufferSize)
end

function DAQmxGetTaskDevices(taskHandle::TaskHandle, data::Ptr{Cchar}, bufferSize::uInt32)
    ccall((:DAQmxGetTaskDevices, libnidaq), int32, (TaskHandle, Ptr{Cchar}, uInt32), taskHandle, data, bufferSize)
end

function DAQmxAddGlobalChansToTask(taskHandle::TaskHandle, channelNames::Ptr{Cchar})
    ccall((:DAQmxAddGlobalChansToTask, libnidaq), int32, (TaskHandle, Ptr{Cchar}), taskHandle, channelNames)
end

# AI Channel creation
function DAQmxCreateAIVoltageChan(taskHandle::TaskHandle, physicalChannel::Ptr{Cchar}, nameToAssignToChannel::Ptr{Cchar}, terminalConfig::int32, minVal::float64, maxVal::float64, units::int32, customScaleName::Ptr{Cchar})
    ccall((:DAQmxCreateAIVoltageChan, libnidaq), int32, (TaskHandle, Ptr{Cchar}, Ptr{Cchar}, int32, float64, float64, int32, Ptr{Cchar}), taskHandle, physicalChannel, nameToAssignToChannel, terminalConfig, minVal, maxVal, units, customScaleName)
end

function DAQmxCreateAICurrentChan(taskHandle::TaskHandle, physicalChannel::Ptr{Cchar}, nameToAssignToChannel::Ptr{Cchar}, terminalConfig::int32, minVal::float64, maxVal::float64, units::int32, shuntResistorLoc::int32, extShuntResistorVal::float64, customScaleName::Ptr{Cchar})
    ccall((:DAQmxCreateAICurrentChan, libnidaq), int32, (TaskHandle, Ptr{Cchar}, Ptr{Cchar}, int32, float64, float64, int32, int32, float64, Ptr{Cchar}), taskHandle, physicalChannel, nameToAssignToChannel, terminalConfig, minVal, maxVal, units, shuntResistorLoc, extShuntResistorVal, customScaleName)
end

function DAQmxCreateAIThrmcplChan(taskHandle::TaskHandle, physicalChannel::Ptr{Cchar}, nameToAssignToChannel::Ptr{Cchar}, minVal::float64, maxVal::float64, units::int32, thermocoupleType::int32, cjcSource::int32, cjcVal::float64, cjcChannel::Ptr{Cchar})
    ccall((:DAQmxCreateAIThrmcplChan, libnidaq), int32, (TaskHandle, Ptr{Cchar}, Ptr{Cchar}, float64, float64, int32, int32, int32, float64, Ptr{Cchar}), taskHandle, physicalChannel, nameToAssignToChannel, minVal, maxVal, units, thermocoupleType, cjcSource, cjcVal, cjcChannel)
end

function DAQmxCreateAIRTDChan(taskHandle::TaskHandle, physicalChannel::Ptr{Cchar}, nameToAssignToChannel::Ptr{Cchar}, minVal::float64, maxVal::float64, units::int32, rtdType::int32, resistanceConfig::int32, currentExcitSource::int32, currentExcitVal::float64, r0::float64)
    ccall((:DAQmxCreateAIRTDChan, libnidaq), int32, (TaskHandle, Ptr{Cchar}, Ptr{Cchar}, float64, float64, int32, int32, int32, int32, float64, float64), taskHandle, physicalChannel, nameToAssignToChannel, minVal, maxVal, units, rtdType, resistanceConfig, currentExcitSource, currentExcitVal, r0)
end

function DAQmxCreateAIResistanceChan(taskHandle::TaskHandle, physicalChannel::Ptr{Cchar}, nameToAssignToChannel::Ptr{Cchar}, minVal::float64, maxVal::float64, units::int32, resistanceConfig::int32, currentExcitSource::int32, currentExcitVal::float64, customScaleName::Ptr{Cchar})
    ccall((:DAQmxCreateAIResistanceChan, libnidaq), int32, (TaskHandle, Ptr{Cchar}, Ptr{Cchar}, float64, float64, int32, int32, int32, float64, Ptr{Cchar}), taskHandle, physicalChannel, nameToAssignToChannel, minVal, maxVal, units, resistanceConfig, currentExcitSource, currentExcitVal, customScaleName)
end

function DAQmxCreateAIAccelChan(taskHandle::TaskHandle, physicalChannel::Ptr{Cchar}, nameToAssignToChannel::Ptr{Cchar}, terminalConfig::int32, minVal::float64, maxVal::float64, units::int32, sensitivity::float64, sensitivityUnits::int32, currentExcitSource::int32, currentExcitVal::float64, customScaleName::Ptr{Cchar})
    ccall((:DAQmxCreateAIAccelChan, libnidaq), int32, (TaskHandle, Ptr{Cchar}, Ptr{Cchar}, int32, float64, float64, int32, float64, int32, int32, float64, Ptr{Cchar}), taskHandle, physicalChannel, nameToAssignToChannel, terminalConfig, minVal, maxVal, units, sensitivity, sensitivityUnits, currentExcitSource, currentExcitVal, customScaleName)
end

function DAQmxCreateAIBridgeChan(taskHandle::TaskHandle, physicalChannel::Ptr{Cchar}, nameToAssignToChannel::Ptr{Cchar}, minVal::float64, maxVal::float64, units::int32, bridgeConfig::int32, voltageExcitSource::int32, voltageExcitVal::float64, nominalBridgeResistance::float64, customScaleName::Ptr{Cchar})
    ccall((:DAQmxCreateAIBridgeChan, libnidaq), int32, (TaskHandle, Ptr{Cchar}, Ptr{Cchar}, float64, float64, int32, int32, int32, float64, float64, Ptr{Cchar}), taskHandle, physicalChannel, nameToAssignToChannel, minVal, maxVal, units, bridgeConfig, voltageExcitSource, voltageExcitVal, nominalBridgeResistance, customScaleName)
end

# AO Channel creation
function DAQmxCreateAOVoltageChan(taskHandle::TaskHandle, physicalChannel::Ptr{Cchar}, nameToAssignToChannel::Ptr{Cchar}, minVal::float64, maxVal::float64, units::int32, customScaleName::Ptr{Cchar})
    ccall((:DAQmxCreateAOVoltageChan, libnidaq), int32, (TaskHandle, Ptr{Cchar}, Ptr{Cchar}, float64, float64, int32, Ptr{Cchar}), taskHandle, physicalChannel, nameToAssignToChannel, minVal, maxVal, units, customScaleName)
end

function DAQmxCreateAOCurrentChan(taskHandle::TaskHandle, physicalChannel::Ptr{Cchar}, nameToAssignToChannel::Ptr{Cchar}, minVal::float64, maxVal::float64, units::int32, customScaleName::Ptr{Cchar})
    ccall((:DAQmxCreateAOCurrentChan, libnidaq), int32, (TaskHandle, Ptr{Cchar}, Ptr{Cchar}, float64, float64, int32, Ptr{Cchar}), taskHandle, physicalChannel, nameToAssignToChannel, minVal, maxVal, units, customScaleName)
end

function DAQmxCreateAOFuncGenChan(taskHandle::TaskHandle, physicalChannel::Ptr{Cchar}, nameToAssignToChannel::Ptr{Cchar}, type::int32, freq::float64, amplitude::float64, offset::float64)
    ccall((:DAQmxCreateAOFuncGenChan, libnidaq), int32, (TaskHandle, Ptr{Cchar}, Ptr{Cchar}, int32, float64, float64, float64), taskHandle, physicalChannel, nameToAssignToChannel, type, freq, amplitude, offset)
end

# DI Channel creation
function DAQmxCreateDIChan(taskHandle::TaskHandle, lines::Ptr{Cchar}, nameToAssignToLines::Ptr{Cchar}, lineGrouping::int32)
    ccall((:DAQmxCreateDIChan, libnidaq), int32, (TaskHandle, Ptr{Cchar}, Ptr{Cchar}, int32), taskHandle, lines, nameToAssignToLines, lineGrouping)
end

# DO Channel creation
function DAQmxCreateDOChan(taskHandle::TaskHandle, lines::Ptr{Cchar}, nameToAssignToLines::Ptr{Cchar}, lineGrouping::int32)
    ccall((:DAQmxCreateDOChan, libnidaq), int32, (TaskHandle, Ptr{Cchar}, Ptr{Cchar}, int32), taskHandle, lines, nameToAssignToLines, lineGrouping)
end

# CI Channel creation
function DAQmxCreateCICountEdgesChan(taskHandle::TaskHandle, counter::Ptr{Cchar}, nameToAssignToChannel::Ptr{Cchar}, edge::int32, initialCount::uInt32, countDirection::int32)
    ccall((:DAQmxCreateCICountEdgesChan, libnidaq), int32, (TaskHandle, Ptr{Cchar}, Ptr{Cchar}, int32, uInt32, int32), taskHandle, counter, nameToAssignToChannel, edge, initialCount, countDirection)
end

function DAQmxCreateCIFreqChan(taskHandle::TaskHandle, counter::Ptr{Cchar}, nameToAssignToChannel::Ptr{Cchar}, minVal::float64, maxVal::float64, units::int32, edge::int32, measMethod::int32, measTime::float64, divisor::uInt32, customScaleName::Ptr{Cchar})
    ccall((:DAQmxCreateCIFreqChan, libnidaq), int32, (TaskHandle, Ptr{Cchar}, Ptr{Cchar}, float64, float64, int32, int32, int32, float64, uInt32, Ptr{Cchar}), taskHandle, counter, nameToAssignToChannel, minVal, maxVal, units, edge, measMethod, measTime, divisor, customScaleName)
end

function DAQmxCreateCIPeriodChan(taskHandle::TaskHandle, counter::Ptr{Cchar}, nameToAssignToChannel::Ptr{Cchar}, minVal::float64, maxVal::float64, units::int32, edge::int32, measMethod::int32, measTime::float64, divisor::uInt32, customScaleName::Ptr{Cchar})
    ccall((:DAQmxCreateCIPeriodChan, libnidaq), int32, (TaskHandle, Ptr{Cchar}, Ptr{Cchar}, float64, float64, int32, int32, int32, float64, uInt32, Ptr{Cchar}), taskHandle, counter, nameToAssignToChannel, minVal, maxVal, units, edge, measMethod, measTime, divisor, customScaleName)
end

function DAQmxCreateCIPulseWidthChan(taskHandle::TaskHandle, counter::Ptr{Cchar}, nameToAssignToChannel::Ptr{Cchar}, minVal::float64, maxVal::float64, units::int32, startingEdge::int32, customScaleName::Ptr{Cchar})
    ccall((:DAQmxCreateCIPulseWidthChan, libnidaq), int32, (TaskHandle, Ptr{Cchar}, Ptr{Cchar}, float64, float64, int32, int32, Ptr{Cchar}), taskHandle, counter, nameToAssignToChannel, minVal, maxVal, units, startingEdge, customScaleName)
end

function DAQmxCreateCISemiPeriodChan(taskHandle::TaskHandle, counter::Ptr{Cchar}, nameToAssignToChannel::Ptr{Cchar}, minVal::float64, maxVal::float64, units::int32, customScaleName::Ptr{Cchar})
    ccall((:DAQmxCreateCISemiPeriodChan, libnidaq), int32, (TaskHandle, Ptr{Cchar}, Ptr{Cchar}, float64, float64, int32, Ptr{Cchar}), taskHandle, counter, nameToAssignToChannel, minVal, maxVal, units, customScaleName)
end

function DAQmxCreateCITwoEdgeSepChan(taskHandle::TaskHandle, counter::Ptr{Cchar}, nameToAssignToChannel::Ptr{Cchar}, minVal::float64, maxVal::float64, units::int32, firstEdge::int32, secondEdge::int32, customScaleName::Ptr{Cchar})
    ccall((:DAQmxCreateCITwoEdgeSepChan, libnidaq), int32, (TaskHandle, Ptr{Cchar}, Ptr{Cchar}, float64, float64, int32, int32, int32, Ptr{Cchar}), taskHandle, counter, nameToAssignToChannel, minVal, maxVal, units, firstEdge, secondEdge, customScaleName)
end

function DAQmxCreateCIAngEncoderChan(taskHandle::TaskHandle, counter::Ptr{Cchar}, nameToAssignToChannel::Ptr{Cchar}, decodingType::int32, ZidxEnable::bool32, ZidxVal::float64, ZidxPhase::int32, units::int32, pulsesPerRev::uInt32, initialAngle::float64, customScaleName::Ptr{Cchar})
    ccall((:DAQmxCreateCIAngEncoderChan, libnidaq), int32, (TaskHandle, Ptr{Cchar}, Ptr{Cchar}, int32, bool32, float64, int32, int32, uInt32, float64, Ptr{Cchar}), taskHandle, counter, nameToAssignToChannel, decodingType, ZidxEnable, ZidxVal, ZidxPhase, units, pulsesPerRev, initialAngle, customScaleName)
end

function DAQmxCreateCILinEncoderChan(taskHandle::TaskHandle, counter::Ptr{Cchar}, nameToAssignToChannel::Ptr{Cchar}, decodingType::int32, ZidxEnable::bool32, ZidxVal::float64, ZidxPhase::int32, units::int32, distPerPulse::float64, initialPos::float64, customScaleName::Ptr{Cchar})
    ccall((:DAQmxCreateCILinEncoderChan, libnidaq), int32, (TaskHandle, Ptr{Cchar}, Ptr{Cchar}, int32, bool32, float64, int32, int32, float64, float64, Ptr{Cchar}), taskHandle, counter, nameToAssignToChannel, decodingType, ZidxEnable, ZidxVal, ZidxPhase, units, distPerPulse, initialPos, customScaleName)
end

# CO Channel creation
function DAQmxCreateCOPulseChanFreq(taskHandle::TaskHandle, counter::Ptr{Cchar}, nameToAssignToChannel::Ptr{Cchar}, units::int32, idleState::int32, initialDelay::float64, freq::float64, dutyCycle::float64)
    ccall((:DAQmxCreateCOPulseChanFreq, libnidaq), int32, (TaskHandle, Ptr{Cchar}, Ptr{Cchar}, int32, int32, float64, float64, float64), taskHandle, counter, nameToAssignToChannel, units, idleState, initialDelay, freq, dutyCycle)
end

function DAQmxCreateCOPulseChanTime(taskHandle::TaskHandle, counter::Ptr{Cchar}, nameToAssignToChannel::Ptr{Cchar}, units::int32, idleState::int32, initialDelay::float64, lowTime::float64, highTime::float64)
    ccall((:DAQmxCreateCOPulseChanTime, libnidaq), int32, (TaskHandle, Ptr{Cchar}, Ptr{Cchar}, int32, int32, float64, float64, float64), taskHandle, counter, nameToAssignToChannel, units, idleState, initialDelay, lowTime, highTime)
end

function DAQmxCreateCOPulseChanTicks(taskHandle::TaskHandle, counter::Ptr{Cchar}, nameToAssignToChannel::Ptr{Cchar}, sourceTerminal::Ptr{Cchar}, idleState::int32, initialDelay::int32, lowTicks::int32, highTicks::int32)
    ccall((:DAQmxCreateCOPulseChanTicks, libnidaq), int32, (TaskHandle, Ptr{Cchar}, Ptr{Cchar}, Ptr{Cchar}, int32, int32, int32, int32), taskHandle, counter, nameToAssignToChannel, sourceTerminal, idleState, initialDelay, lowTicks, highTicks)
end

# Timing functions
function DAQmxCfgSampClkTiming(taskHandle::TaskHandle, source::Ptr{Cchar}, rate::float64, activeEdge::int32, sampleMode::int32, sampsPerChan::uInt64)
    ccall((:DAQmxCfgSampClkTiming, libnidaq), int32, (TaskHandle, Ptr{Cchar}, float64, int32, int32, Culonglong), taskHandle, source, rate, activeEdge, sampleMode, sampsPerChan)
end

function DAQmxCfgHandshakingTiming(taskHandle::TaskHandle, sampleMode::int32, sampsPerChan::uInt64)
    ccall((:DAQmxCfgHandshakingTiming, libnidaq), int32, (TaskHandle, int32, Culonglong), taskHandle, sampleMode, sampsPerChan)
end

function DAQmxCfgBurstHandshakingTimingImportClock(taskHandle::TaskHandle, sampleMode::int32, sampsPerChan::uInt64, sampleClkRate::float64, sampleClkSrc::Ptr{Cchar}, sampleClkActiveEdge::int32, pauseWhen::int32, readyEventActiveLevel::int32)
    ccall((:DAQmxCfgBurstHandshakingTimingImportClock, libnidaq), int32, (TaskHandle, int32, Culonglong, float64, Ptr{Cchar}, int32, int32, int32), taskHandle, sampleMode, sampsPerChan, sampleClkRate, sampleClkSrc, sampleClkActiveEdge, pauseWhen, readyEventActiveLevel)
end

function DAQmxCfgBurstHandshakingTimingExportClock(taskHandle::TaskHandle, sampleMode::int32, sampsPerChan::uInt64, sampleClkRate::float64, sampleClkOutpTerm::Ptr{Cchar}, sampleClkPulsePolarity::int32, pauseWhen::int32, readyEventActiveLevel::int32)
    ccall((:DAQmxCfgBurstHandshakingTimingExportClock, libnidaq), int32, (TaskHandle, int32, Culonglong, float64, Ptr{Cchar}, int32, int32, int32), taskHandle, sampleMode, sampsPerChan, sampleClkRate, sampleClkOutpTerm, sampleClkPulsePolarity, pauseWhen, readyEventActiveLevel)
end

function DAQmxCfgImplicitTiming(taskHandle::TaskHandle, sampleMode::int32, sampsPerChan::uInt64)
    ccall((:DAQmxCfgImplicitTiming, libnidaq), int32, (TaskHandle, int32, Culonglong), taskHandle, sampleMode, sampsPerChan)
end

function DAQmxCfgChangeDetectionTiming(taskHandle::TaskHandle, risingEdgeChan::Ptr{Cchar}, fallingEdgeChan::Ptr{Cchar}, sampleMode::int32, sampsPerChan::uInt64)
    ccall((:DAQmxCfgChangeDetectionTiming, libnidaq), int32, (TaskHandle, Ptr{Cchar}, Ptr{Cchar}, int32, Culonglong), taskHandle, risingEdgeChan, fallingEdgeChan, sampleMode, sampsPerChan)
end

# Trigger functions
function DAQmxCfgDigEdgeStartTrig(taskHandle::TaskHandle, triggerSource::Ptr{Cchar}, triggerEdge::int32)
    ccall((:DAQmxCfgDigEdgeStartTrig, libnidaq), int32, (TaskHandle, Ptr{Cchar}, int32), taskHandle, triggerSource, triggerEdge)
end

function DAQmxCfgAnlgEdgeStartTrig(taskHandle::TaskHandle, triggerSource::Ptr{Cchar}, triggerSlope::int32, triggerLevel::float64)
    ccall((:DAQmxCfgAnlgEdgeStartTrig, libnidaq), int32, (TaskHandle, Ptr{Cchar}, int32, float64), taskHandle, triggerSource, triggerSlope, triggerLevel)
end

function DAQmxCfgAnlgWindowStartTrig(taskHandle::TaskHandle, triggerSource::Ptr{Cchar}, triggerWhen::int32, windowTop::float64, windowBottom::float64)
    ccall((:DAQmxCfgAnlgWindowStartTrig, libnidaq), int32, (TaskHandle, Ptr{Cchar}, int32, float64, float64), taskHandle, triggerSource, triggerWhen, windowTop, windowBottom)
end

function DAQmxCfgDigPatternStartTrig(taskHandle::TaskHandle, triggerSource::Ptr{Cchar}, triggerPattern::Ptr{Cchar}, triggerWhen::int32)
    ccall((:DAQmxCfgDigPatternStartTrig, libnidaq), int32, (TaskHandle, Ptr{Cchar}, Ptr{Cchar}, int32), taskHandle, triggerSource, triggerPattern, triggerWhen)
end

function DAQmxDisableStartTrig(taskHandle::TaskHandle)
    ccall((:DAQmxDisableStartTrig, libnidaq), int32, (TaskHandle,), taskHandle)
end

function DAQmxCfgDigEdgeRefTrig(taskHandle::TaskHandle, triggerSource::Ptr{Cchar}, triggerEdge::int32, pretriggerSamples::uInt32)
    ccall((:DAQmxCfgDigEdgeRefTrig, libnidaq), int32, (TaskHandle, Ptr{Cchar}, int32, uInt32), taskHandle, triggerSource, triggerEdge, pretriggerSamples)
end

function DAQmxCfgAnlgEdgeRefTrig(taskHandle::TaskHandle, triggerSource::Ptr{Cchar}, triggerSlope::int32, triggerLevel::float64, pretriggerSamples::uInt32)
    ccall((:DAQmxCfgAnlgEdgeRefTrig, libnidaq), int32, (TaskHandle, Ptr{Cchar}, int32, float64, uInt32), taskHandle, triggerSource, triggerSlope, triggerLevel, pretriggerSamples)
end

function DAQmxCfgAnlgWindowRefTrig(taskHandle::TaskHandle, triggerSource::Ptr{Cchar}, triggerWhen::int32, windowTop::float64, windowBottom::float64, pretriggerSamples::uInt32)
    ccall((:DAQmxCfgAnlgWindowRefTrig, libnidaq), int32, (TaskHandle, Ptr{Cchar}, int32, float64, float64, uInt32), taskHandle, triggerSource, triggerWhen, windowTop, windowBottom, pretriggerSamples)
end

function DAQmxCfgDigPatternRefTrig(taskHandle::TaskHandle, triggerSource::Ptr{Cchar}, triggerPattern::Ptr{Cchar}, triggerWhen::int32, pretriggerSamples::uInt32)
    ccall((:DAQmxCfgDigPatternRefTrig, libnidaq), int32, (TaskHandle, Ptr{Cchar}, Ptr{Cchar}, int32, uInt32), taskHandle, triggerSource, triggerPattern, triggerWhen, pretriggerSamples)
end

function DAQmxDisableRefTrig(taskHandle::TaskHandle)
    ccall((:DAQmxDisableRefTrig, libnidaq), int32, (TaskHandle,), taskHandle)
end

# Read functions - Analog
function DAQmxReadAnalogF64(taskHandle::TaskHandle, numSampsPerChan::int32, timeout::float64, fillMode::bool32, readArray::Ptr{float64}, arraySizeInSamps::uInt32, sampsPerChanRead::Ptr{int32}, reserved::Ptr{bool32})
    ccall((:DAQmxReadAnalogF64, libnidaq), int32, (TaskHandle, int32, float64, bool32, Ptr{float64}, uInt32, Ptr{int32}, Ptr{bool32}), taskHandle, numSampsPerChan, timeout, fillMode, readArray, arraySizeInSamps, sampsPerChanRead, reserved)
end

function DAQmxReadAnalogScalarF64(taskHandle::TaskHandle, timeout::float64, value::Ptr{float64}, reserved::Ptr{bool32})
    ccall((:DAQmxReadAnalogScalarF64, libnidaq), int32, (TaskHandle, float64, Ptr{float64}, Ptr{bool32}), taskHandle, timeout, value, reserved)
end

function DAQmxReadBinaryI16(taskHandle::TaskHandle, numSampsPerChan::int32, timeout::float64, fillMode::bool32, readArray::Ptr{int16}, arraySizeInSamps::uInt32, sampsPerChanRead::Ptr{int32}, reserved::Ptr{bool32})
    ccall((:DAQmxReadBinaryI16, libnidaq), int32, (TaskHandle, int32, float64, bool32, Ptr{int16}, uInt32, Ptr{int32}, Ptr{bool32}), taskHandle, numSampsPerChan, timeout, fillMode, readArray, arraySizeInSamps, sampsPerChanRead, reserved)
end

function DAQmxReadBinaryU16(taskHandle::TaskHandle, numSampsPerChan::int32, timeout::float64, fillMode::bool32, readArray::Ptr{uInt16}, arraySizeInSamps::uInt32, sampsPerChanRead::Ptr{int32}, reserved::Ptr{bool32})
    ccall((:DAQmxReadBinaryU16, libnidaq), int32, (TaskHandle, int32, float64, bool32, Ptr{uInt16}, uInt32, Ptr{int32}, Ptr{bool32}), taskHandle, numSampsPerChan, timeout, fillMode, readArray, arraySizeInSamps, sampsPerChanRead, reserved)
end

function DAQmxReadBinaryI32(taskHandle::TaskHandle, numSampsPerChan::int32, timeout::float64, fillMode::bool32, readArray::Ptr{int32}, arraySizeInSamps::uInt32, sampsPerChanRead::Ptr{int32}, reserved::Ptr{bool32})
    ccall((:DAQmxReadBinaryI32, libnidaq), int32, (TaskHandle, int32, float64, bool32, Ptr{int32}, uInt32, Ptr{int32}, Ptr{bool32}), taskHandle, numSampsPerChan, timeout, fillMode, readArray, arraySizeInSamps, sampsPerChanRead, reserved)
end

function DAQmxReadBinaryU32(taskHandle::TaskHandle, numSampsPerChan::int32, timeout::float64, fillMode::bool32, readArray::Ptr{uInt32}, arraySizeInSamps::uInt32, sampsPerChanRead::Ptr{int32}, reserved::Ptr{bool32})
    ccall((:DAQmxReadBinaryU32, libnidaq), int32, (TaskHandle, int32, float64, bool32, Ptr{uInt32}, uInt32, Ptr{int32}, Ptr{bool32}), taskHandle, numSampsPerChan, timeout, fillMode, readArray, arraySizeInSamps, sampsPerChanRead, reserved)
end

# Read functions - Digital
function DAQmxReadDigitalU8(taskHandle::TaskHandle, numSampsPerChan::int32, timeout::float64, fillMode::bool32, readArray::Ptr{uInt8}, arraySizeInSamps::uInt32, sampsPerChanRead::Ptr{int32}, reserved::Ptr{bool32})
    ccall((:DAQmxReadDigitalU8, libnidaq), int32, (TaskHandle, int32, float64, bool32, Ptr{uInt8}, uInt32, Ptr{int32}, Ptr{bool32}), taskHandle, numSampsPerChan, timeout, fillMode, readArray, arraySizeInSamps, sampsPerChanRead, reserved)
end

function DAQmxReadDigitalU16(taskHandle::TaskHandle, numSampsPerChan::int32, timeout::float64, fillMode::bool32, readArray::Ptr{uInt16}, arraySizeInSamps::uInt32, sampsPerChanRead::Ptr{int32}, reserved::Ptr{bool32})
    ccall((:DAQmxReadDigitalU16, libnidaq), int32, (TaskHandle, int32, float64, bool32, Ptr{uInt16}, uInt32, Ptr{int32}, Ptr{bool32}), taskHandle, numSampsPerChan, timeout, fillMode, readArray, arraySizeInSamps, sampsPerChanRead, reserved)
end

function DAQmxReadDigitalU32(taskHandle::TaskHandle, numSampsPerChan::int32, timeout::float64, fillMode::bool32, readArray::Ptr{uInt32}, arraySizeInSamps::uInt32, sampsPerChanRead::Ptr{int32}, reserved::Ptr{bool32})
    ccall((:DAQmxReadDigitalU32, libnidaq), int32, (TaskHandle, int32, float64, bool32, Ptr{uInt32}, uInt32, Ptr{int32}, Ptr{bool32}), taskHandle, numSampsPerChan, timeout, fillMode, readArray, arraySizeInSamps, sampsPerChanRead, reserved)
end

function DAQmxReadDigitalLines(taskHandle::TaskHandle, numSampsPerChan::int32, timeout::float64, fillMode::bool32, readArray::Ptr{uInt8}, arraySizeInBytes::uInt32, sampsPerChanRead::Ptr{int32}, numBytesPerSamp::Ptr{int32}, reserved::Ptr{bool32})
    ccall((:DAQmxReadDigitalLines, libnidaq), int32, (TaskHandle, int32, float64, bool32, Ptr{uInt8}, uInt32, Ptr{int32}, Ptr{int32}, Ptr{bool32}), taskHandle, numSampsPerChan, timeout, fillMode, readArray, arraySizeInBytes, sampsPerChanRead, numBytesPerSamp, reserved)
end

function DAQmxReadDigitalScalarU32(taskHandle::TaskHandle, timeout::float64, value::Ptr{uInt32}, reserved::Ptr{bool32})
    ccall((:DAQmxReadDigitalScalarU32, libnidaq), int32, (TaskHandle, float64, Ptr{uInt32}, Ptr{bool32}), taskHandle, timeout, value, reserved)
end

# Read functions - Counter
function DAQmxReadCounterF64(taskHandle::TaskHandle, numSampsPerChan::int32, timeout::float64, readArray::Ptr{float64}, arraySizeInSamps::uInt32, sampsPerChanRead::Ptr{int32}, reserved::Ptr{bool32})
    ccall((:DAQmxReadCounterF64, libnidaq), int32, (TaskHandle, int32, float64, Ptr{float64}, uInt32, Ptr{int32}, Ptr{bool32}), taskHandle, numSampsPerChan, timeout, readArray, arraySizeInSamps, sampsPerChanRead, reserved)
end

function DAQmxReadCounterU32(taskHandle::TaskHandle, numSampsPerChan::int32, timeout::float64, readArray::Ptr{uInt32}, arraySizeInSamps::uInt32, sampsPerChanRead::Ptr{int32}, reserved::Ptr{bool32})
    ccall((:DAQmxReadCounterU32, libnidaq), int32, (TaskHandle, int32, float64, Ptr{uInt32}, uInt32, Ptr{int32}, Ptr{bool32}), taskHandle, numSampsPerChan, timeout, readArray, arraySizeInSamps, sampsPerChanRead, reserved)
end

function DAQmxReadCounterScalarF64(taskHandle::TaskHandle, timeout::float64, value::Ptr{float64}, reserved::Ptr{bool32})
    ccall((:DAQmxReadCounterScalarF64, libnidaq), int32, (TaskHandle, float64, Ptr{float64}, Ptr{bool32}), taskHandle, timeout, value, reserved)
end

function DAQmxReadCounterScalarU32(taskHandle::TaskHandle, timeout::float64, value::Ptr{uInt32}, reserved::Ptr{bool32})
    ccall((:DAQmxReadCounterScalarU32, libnidaq), int32, (TaskHandle, float64, Ptr{uInt32}, Ptr{bool32}), taskHandle, timeout, value, reserved)
end

function DAQmxReadCtrFreq(taskHandle::TaskHandle, numSampsPerChan::int32, timeout::float64, interleaved::bool32, readArrayFrequency::Ptr{float64}, readArrayDutyCycle::Ptr{float64}, arraySizeInSamps::uInt32, sampsPerChanRead::Ptr{int32}, reserved::Ptr{bool32})
    ccall((:DAQmxReadCtrFreq, libnidaq), int32, (TaskHandle, int32, float64, bool32, Ptr{float64}, Ptr{float64}, uInt32, Ptr{int32}, Ptr{bool32}), taskHandle, numSampsPerChan, timeout, interleaved, readArrayFrequency, readArrayDutyCycle, arraySizeInSamps, sampsPerChanRead, reserved)
end

function DAQmxReadCtrTime(taskHandle::TaskHandle, numSampsPerChan::int32, timeout::float64, interleaved::bool32, readArrayHighTime::Ptr{float64}, readArrayLowTime::Ptr{float64}, arraySizeInSamps::uInt32, sampsPerChanRead::Ptr{int32}, reserved::Ptr{bool32})
    ccall((:DAQmxReadCtrTime, libnidaq), int32, (TaskHandle, int32, float64, bool32, Ptr{float64}, Ptr{float64}, uInt32, Ptr{int32}, Ptr{bool32}), taskHandle, numSampsPerChan, timeout, interleaved, readArrayHighTime, readArrayLowTime, arraySizeInSamps, sampsPerChanRead, reserved)
end

function DAQmxReadCtrTicks(taskHandle::TaskHandle, numSampsPerChan::int32, timeout::float64, interleaved::bool32, readArrayHighTicks::Ptr{uInt32}, readArrayLowTicks::Ptr{uInt32}, arraySizeInSamps::uInt32, sampsPerChanRead::Ptr{int32}, reserved::Ptr{bool32})
    ccall((:DAQmxReadCtrTicks, libnidaq), int32, (TaskHandle, int32, float64, bool32, Ptr{uInt32}, Ptr{uInt32}, uInt32, Ptr{int32}, Ptr{bool32}), taskHandle, numSampsPerChan, timeout, interleaved, readArrayHighTicks, readArrayLowTicks, arraySizeInSamps, sampsPerChanRead, reserved)
end

# Write functions - Analog
function DAQmxWriteAnalogF64(taskHandle::TaskHandle, numSampsPerChan::int32, autoStart::bool32, timeout::float64, dataLayout::bool32, writeArray::Ptr{float64}, sampsPerChanWritten::Ptr{int32}, reserved::Ptr{bool32})
    ccall((:DAQmxWriteAnalogF64, libnidaq), int32, (TaskHandle, int32, bool32, float64, bool32, Ptr{float64}, Ptr{int32}, Ptr{bool32}), taskHandle, numSampsPerChan, autoStart, timeout, dataLayout, writeArray, sampsPerChanWritten, reserved)
end

function DAQmxWriteAnalogScalarF64(taskHandle::TaskHandle, autoStart::bool32, timeout::float64, value::float64, reserved::Ptr{bool32})
    ccall((:DAQmxWriteAnalogScalarF64, libnidaq), int32, (TaskHandle, bool32, float64, float64, Ptr{bool32}), taskHandle, autoStart, timeout, value, reserved)
end

function DAQmxWriteBinaryI16(taskHandle::TaskHandle, numSampsPerChan::int32, autoStart::bool32, timeout::float64, dataLayout::bool32, writeArray::Ptr{int16}, sampsPerChanWritten::Ptr{int32}, reserved::Ptr{bool32})
    ccall((:DAQmxWriteBinaryI16, libnidaq), int32, (TaskHandle, int32, bool32, float64, bool32, Ptr{int16}, Ptr{int32}, Ptr{bool32}), taskHandle, numSampsPerChan, autoStart, timeout, dataLayout, writeArray, sampsPerChanWritten, reserved)
end

function DAQmxWriteBinaryU16(taskHandle::TaskHandle, numSampsPerChan::int32, autoStart::bool32, timeout::float64, dataLayout::bool32, writeArray::Ptr{uInt16}, sampsPerChanWritten::Ptr{int32}, reserved::Ptr{bool32})
    ccall((:DAQmxWriteBinaryU16, libnidaq), int32, (TaskHandle, int32, bool32, float64, bool32, Ptr{uInt16}, Ptr{int32}, Ptr{bool32}), taskHandle, numSampsPerChan, autoStart, timeout, dataLayout, writeArray, sampsPerChanWritten, reserved)
end

function DAQmxWriteBinaryI32(taskHandle::TaskHandle, numSampsPerChan::int32, autoStart::bool32, timeout::float64, dataLayout::bool32, writeArray::Ptr{int32}, sampsPerChanWritten::Ptr{int32}, reserved::Ptr{bool32})
    ccall((:DAQmxWriteBinaryI32, libnidaq), int32, (TaskHandle, int32, bool32, float64, bool32, Ptr{int32}, Ptr{int32}, Ptr{bool32}), taskHandle, numSampsPerChan, autoStart, timeout, dataLayout, writeArray, sampsPerChanWritten, reserved)
end

function DAQmxWriteBinaryU32(taskHandle::TaskHandle, numSampsPerChan::int32, autoStart::bool32, timeout::float64, dataLayout::bool32, writeArray::Ptr{uInt32}, sampsPerChanWritten::Ptr{int32}, reserved::Ptr{bool32})
    ccall((:DAQmxWriteBinaryU32, libnidaq), int32, (TaskHandle, int32, bool32, float64, bool32, Ptr{uInt32}, Ptr{int32}, Ptr{bool32}), taskHandle, numSampsPerChan, autoStart, timeout, dataLayout, writeArray, sampsPerChanWritten, reserved)
end

# Write functions - Digital
function DAQmxWriteDigitalU8(taskHandle::TaskHandle, numSampsPerChan::int32, autoStart::bool32, timeout::float64, dataLayout::bool32, writeArray::Ptr{uInt8}, sampsPerChanWritten::Ptr{int32}, reserved::Ptr{bool32})
    ccall((:DAQmxWriteDigitalU8, libnidaq), int32, (TaskHandle, int32, bool32, float64, bool32, Ptr{uInt8}, Ptr{int32}, Ptr{bool32}), taskHandle, numSampsPerChan, autoStart, timeout, dataLayout, writeArray, sampsPerChanWritten, reserved)
end

function DAQmxWriteDigitalU16(taskHandle::TaskHandle, numSampsPerChan::int32, autoStart::bool32, timeout::float64, dataLayout::bool32, writeArray::Ptr{uInt16}, sampsPerChanWritten::Ptr{int32}, reserved::Ptr{bool32})
    ccall((:DAQmxWriteDigitalU16, libnidaq), int32, (TaskHandle, int32, bool32, float64, bool32, Ptr{uInt16}, Ptr{int32}, Ptr{bool32}), taskHandle, numSampsPerChan, autoStart, timeout, dataLayout, writeArray, sampsPerChanWritten, reserved)
end

function DAQmxWriteDigitalU32(taskHandle::TaskHandle, numSampsPerChan::int32, autoStart::bool32, timeout::float64, dataLayout::bool32, writeArray::Ptr{uInt32}, sampsPerChanWritten::Ptr{int32}, reserved::Ptr{bool32})
    ccall((:DAQmxWriteDigitalU32, libnidaq), int32, (TaskHandle, int32, bool32, float64, bool32, Ptr{uInt32}, Ptr{int32}, Ptr{bool32}), taskHandle, numSampsPerChan, autoStart, timeout, dataLayout, writeArray, sampsPerChanWritten, reserved)
end

function DAQmxWriteDigitalLines(taskHandle::TaskHandle, numSampsPerChan::int32, autoStart::bool32, timeout::float64, dataLayout::bool32, writeArray::Ptr{uInt8}, sampsPerChanWritten::Ptr{int32}, reserved::Ptr{bool32})
    ccall((:DAQmxWriteDigitalLines, libnidaq), int32, (TaskHandle, int32, bool32, float64, bool32, Ptr{uInt8}, Ptr{int32}, Ptr{bool32}), taskHandle, numSampsPerChan, autoStart, timeout, dataLayout, writeArray, sampsPerChanWritten, reserved)
end

function DAQmxWriteDigitalScalarU32(taskHandle::TaskHandle, autoStart::bool32, timeout::float64, value::uInt32, reserved::Ptr{bool32})
    ccall((:DAQmxWriteDigitalScalarU32, libnidaq), int32, (TaskHandle, bool32, float64, uInt32, Ptr{bool32}), taskHandle, autoStart, timeout, value, reserved)
end

# Write functions - Counter
function DAQmxWriteCtrFreq(taskHandle::TaskHandle, numSampsPerChan::int32, autoStart::bool32, timeout::float64, dataLayout::bool32, frequency::Ptr{float64}, dutyCycle::Ptr{float64}, numSampsPerChanWritten::Ptr{int32}, reserved::Ptr{bool32})
    ccall((:DAQmxWriteCtrFreq, libnidaq), int32, (TaskHandle, int32, bool32, float64, bool32, Ptr{float64}, Ptr{float64}, Ptr{int32}, Ptr{bool32}), taskHandle, numSampsPerChan, autoStart, timeout, dataLayout, frequency, dutyCycle, numSampsPerChanWritten, reserved)
end

function DAQmxWriteCtrFreqScalar(taskHandle::TaskHandle, autoStart::bool32, timeout::float64, frequency::float64, dutyCycle::float64, reserved::Ptr{bool32})
    ccall((:DAQmxWriteCtrFreqScalar, libnidaq), int32, (TaskHandle, bool32, float64, float64, float64, Ptr{bool32}), taskHandle, autoStart, timeout, frequency, dutyCycle, reserved)
end

function DAQmxWriteCtrTime(taskHandle::TaskHandle, numSampsPerChan::int32, autoStart::bool32, timeout::float64, dataLayout::bool32, highTime::Ptr{float64}, lowTime::Ptr{float64}, numSampsPerChanWritten::Ptr{int32}, reserved::Ptr{bool32})
    ccall((:DAQmxWriteCtrTime, libnidaq), int32, (TaskHandle, int32, bool32, float64, bool32, Ptr{float64}, Ptr{float64}, Ptr{int32}, Ptr{bool32}), taskHandle, numSampsPerChan, autoStart, timeout, dataLayout, highTime, lowTime, numSampsPerChanWritten, reserved)
end

function DAQmxWriteCtrTimeScalar(taskHandle::TaskHandle, autoStart::bool32, timeout::float64, highTime::float64, lowTime::float64, reserved::Ptr{bool32})
    ccall((:DAQmxWriteCtrTimeScalar, libnidaq), int32, (TaskHandle, bool32, float64, float64, float64, Ptr{bool32}), taskHandle, autoStart, timeout, highTime, lowTime, reserved)
end

function DAQmxWriteCtrTicks(taskHandle::TaskHandle, numSampsPerChan::int32, autoStart::bool32, timeout::float64, dataLayout::bool32, highTicks::Ptr{uInt32}, lowTicks::Ptr{uInt32}, numSampsPerChanWritten::Ptr{int32}, reserved::Ptr{bool32})
    ccall((:DAQmxWriteCtrTicks, libnidaq), int32, (TaskHandle, int32, bool32, float64, bool32, Ptr{uInt32}, Ptr{uInt32}, Ptr{int32}, Ptr{bool32}), taskHandle, numSampsPerChan, autoStart, timeout, dataLayout, highTicks, lowTicks, numSampsPerChanWritten, reserved)
end

function DAQmxWriteCtrTicksScalar(taskHandle::TaskHandle, autoStart::bool32, timeout::float64, highTicks::uInt32, lowTicks::uInt32, reserved::Ptr{bool32})
    ccall((:DAQmxWriteCtrTicksScalar, libnidaq), int32, (TaskHandle, bool32, float64, uInt32, uInt32, Ptr{bool32}), taskHandle, autoStart, timeout, highTicks, lowTicks, reserved)
end

# System functions
function DAQmxGetSysDevNames(data::Ptr{Cchar}, bufferSize::uInt32)
    ccall((:DAQmxGetSysDevNames, libnidaq), int32, (Ptr{Cchar}, uInt32), data, bufferSize)
end

function DAQmxGetSysNIDAQMajorVersion(data::Ptr{uInt32})
    ccall((:DAQmxGetSysNIDAQMajorVersion, libnidaq), int32, (Ptr{uInt32},), data)
end

function DAQmxGetSysNIDAQMinorVersion(data::Ptr{uInt32})
    ccall((:DAQmxGetSysNIDAQMinorVersion, libnidaq), int32, (Ptr{uInt32},), data)
end

function DAQmxGetSysNIDAQUpdateVersion(data::Ptr{uInt32})
    ccall((:DAQmxGetSysNIDAQUpdateVersion, libnidaq), int32, (Ptr{uInt32},), data)
end

# Device functions
function DAQmxGetDevProductType(device::Ptr{Cchar}, data::Ptr{Cchar}, bufferSize::uInt32)
    ccall((:DAQmxGetDevProductType, libnidaq), int32, (Ptr{Cchar}, Ptr{Cchar}, uInt32), device, data, bufferSize)
end

function DAQmxGetDevProductNum(device::Ptr{Cchar}, data::Ptr{uInt32})
    ccall((:DAQmxGetDevProductNum, libnidaq), int32, (Ptr{Cchar}, Ptr{uInt32}), device, data)
end

function DAQmxGetDevSerialNum(device::Ptr{Cchar}, data::Ptr{uInt32})
    ccall((:DAQmxGetDevSerialNum, libnidaq), int32, (Ptr{Cchar}, Ptr{uInt32}), device, data)
end

function DAQmxGetDevIsSimulated(device::Ptr{Cchar}, data::Ptr{bool32})
    ccall((:DAQmxGetDevIsSimulated, libnidaq), int32, (Ptr{Cchar}, Ptr{bool32}), device, data)
end

function DAQmxGetDevProductCategory(device::Ptr{Cchar}, data::Ptr{int32})
    ccall((:DAQmxGetDevProductCategory, libnidaq), int32, (Ptr{Cchar}, Ptr{int32}), device, data)
end

function DAQmxGetDevAIPhysicalChans(device::Ptr{Cchar}, data::Ptr{Cchar}, bufferSize::uInt32)
    ccall((:DAQmxGetDevAIPhysicalChans, libnidaq), int32, (Ptr{Cchar}, Ptr{Cchar}, uInt32), device, data, bufferSize)
end

function DAQmxGetDevAOPhysicalChans(device::Ptr{Cchar}, data::Ptr{Cchar}, bufferSize::uInt32)
    ccall((:DAQmxGetDevAOPhysicalChans, libnidaq), int32, (Ptr{Cchar}, Ptr{Cchar}, uInt32), device, data, bufferSize)
end

function DAQmxGetDevDILines(device::Ptr{Cchar}, data::Ptr{Cchar}, bufferSize::uInt32)
    ccall((:DAQmxGetDevDILines, libnidaq), int32, (Ptr{Cchar}, Ptr{Cchar}, uInt32), device, data, bufferSize)
end

function DAQmxGetDevDOLines(device::Ptr{Cchar}, data::Ptr{Cchar}, bufferSize::uInt32)
    ccall((:DAQmxGetDevDOLines, libnidaq), int32, (Ptr{Cchar}, Ptr{Cchar}, uInt32), device, data, bufferSize)
end

function DAQmxGetDevDIPorts(device::Ptr{Cchar}, data::Ptr{Cchar}, bufferSize::uInt32)
    ccall((:DAQmxGetDevDIPorts, libnidaq), int32, (Ptr{Cchar}, Ptr{Cchar}, uInt32), device, data, bufferSize)
end

function DAQmxGetDevDOPorts(device::Ptr{Cchar}, data::Ptr{Cchar}, bufferSize::uInt32)
    ccall((:DAQmxGetDevDOPorts, libnidaq), int32, (Ptr{Cchar}, Ptr{Cchar}, uInt32), device, data, bufferSize)
end

function DAQmxGetDevCIPhysicalChans(device::Ptr{Cchar}, data::Ptr{Cchar}, bufferSize::uInt32)
    ccall((:DAQmxGetDevCIPhysicalChans, libnidaq), int32, (Ptr{Cchar}, Ptr{Cchar}, uInt32), device, data, bufferSize)
end

function DAQmxGetDevCOPhysicalChans(device::Ptr{Cchar}, data::Ptr{Cchar}, bufferSize::uInt32)
    ccall((:DAQmxGetDevCOPhysicalChans, libnidaq), int32, (Ptr{Cchar}, Ptr{Cchar}, uInt32), device, data, bufferSize)
end

function DAQmxGetDevAIVoltageRngs(device::Ptr{Cchar}, data::Ptr{float64}, arraySizeInElements::uInt32)
    ccall((:DAQmxGetDevAIVoltageRngs, libnidaq), int32, (Ptr{Cchar}, Ptr{float64}, uInt32), device, data, arraySizeInElements)
end

function DAQmxGetDevAOVoltageRngs(device::Ptr{Cchar}, data::Ptr{float64}, arraySizeInElements::uInt32)
    ccall((:DAQmxGetDevAOVoltageRngs, libnidaq), int32, (Ptr{Cchar}, Ptr{float64}, uInt32), device, data, arraySizeInElements)
end

function DAQmxGetDevAICurrentRngs(device::Ptr{Cchar}, data::Ptr{float64}, arraySizeInElements::uInt32)
    ccall((:DAQmxGetDevAICurrentRngs, libnidaq), int32, (Ptr{Cchar}, Ptr{float64}, uInt32), device, data, arraySizeInElements)
end

function DAQmxGetDevAOCurrentRngs(device::Ptr{Cchar}, data::Ptr{float64}, arraySizeInElements::uInt32)
    ccall((:DAQmxGetDevAOCurrentRngs, libnidaq), int32, (Ptr{Cchar}, Ptr{float64}, uInt32), device, data, arraySizeInElements)
end

function DAQmxGetDevTerminals(device::Ptr{Cchar}, data::Ptr{Cchar}, bufferSize::uInt32)
    ccall((:DAQmxGetDevTerminals, libnidaq), int32, (Ptr{Cchar}, Ptr{Cchar}, uInt32), device, data, bufferSize)
end

function DAQmxGetDevBusType(device::Ptr{Cchar}, data::Ptr{int32})
    ccall((:DAQmxGetDevBusType, libnidaq), int32, (Ptr{Cchar}, Ptr{int32}), device, data)
end

function DAQmxSelfCal(deviceName::Ptr{Cchar})
    ccall((:DAQmxSelfCal, libnidaq), int32, (Ptr{Cchar},), deviceName)
end

function DAQmxResetDevice(deviceName::Ptr{Cchar})
    ccall((:DAQmxResetDevice, libnidaq), int32, (Ptr{Cchar},), deviceName)
end

# Error functions
function DAQmxGetErrorString(errorCode::int32, errorString::Ptr{Cchar}, bufferSize::uInt32)
    ccall((:DAQmxGetErrorString, libnidaq), int32, (int32, Ptr{Cchar}, uInt32), errorCode, errorString, bufferSize)
end

function DAQmxGetExtendedErrorInfo(errorString::Ptr{Cchar}, bufferSize::uInt32)
    ccall((:DAQmxGetExtendedErrorInfo, libnidaq), int32, (Ptr{Cchar}, uInt32), errorString, bufferSize)
end

# Channel property getters
function DAQmxGetChanType(taskHandle::TaskHandle, channel::Ptr{Cchar}, data::Ptr{int32})
    ccall((:DAQmxGetChanType, libnidaq), int32, (TaskHandle, Ptr{Cchar}, Ptr{int32}), taskHandle, channel, data)
end

function DAQmxGetAIMeasType(taskHandle::TaskHandle, channel::Ptr{Cchar}, data::Ptr{int32})
    ccall((:DAQmxGetAIMeasType, libnidaq), int32, (TaskHandle, Ptr{Cchar}, Ptr{int32}), taskHandle, channel, data)
end

function DAQmxGetAIMax(taskHandle::TaskHandle, channel::Ptr{Cchar}, data::Ptr{float64})
    ccall((:DAQmxGetAIMax, libnidaq), int32, (TaskHandle, Ptr{Cchar}, Ptr{float64}), taskHandle, channel, data)
end

function DAQmxSetAIMax(taskHandle::TaskHandle, channel::Ptr{Cchar}, data::float64)
    ccall((:DAQmxSetAIMax, libnidaq), int32, (TaskHandle, Ptr{Cchar}, float64), taskHandle, channel, data)
end

function DAQmxGetAIMin(taskHandle::TaskHandle, channel::Ptr{Cchar}, data::Ptr{float64})
    ccall((:DAQmxGetAIMin, libnidaq), int32, (TaskHandle, Ptr{Cchar}, Ptr{float64}), taskHandle, channel, data)
end

function DAQmxSetAIMin(taskHandle::TaskHandle, channel::Ptr{Cchar}, data::float64)
    ccall((:DAQmxSetAIMin, libnidaq), int32, (TaskHandle, Ptr{Cchar}, float64), taskHandle, channel, data)
end

function DAQmxGetAITermCfg(taskHandle::TaskHandle, channel::Ptr{Cchar}, data::Ptr{int32})
    ccall((:DAQmxGetAITermCfg, libnidaq), int32, (TaskHandle, Ptr{Cchar}, Ptr{int32}), taskHandle, channel, data)
end

function DAQmxSetAITermCfg(taskHandle::TaskHandle, channel::Ptr{Cchar}, data::int32)
    ccall((:DAQmxSetAITermCfg, libnidaq), int32, (TaskHandle, Ptr{Cchar}, int32), taskHandle, channel, data)
end

function DAQmxGetAIResolution(taskHandle::TaskHandle, channel::Ptr{Cchar}, data::Ptr{float64})
    ccall((:DAQmxGetAIResolution, libnidaq), int32, (TaskHandle, Ptr{Cchar}, Ptr{float64}), taskHandle, channel, data)
end

function DAQmxGetAIGain(taskHandle::TaskHandle, channel::Ptr{Cchar}, data::Ptr{float64})
    ccall((:DAQmxGetAIGain, libnidaq), int32, (TaskHandle, Ptr{Cchar}, Ptr{float64}), taskHandle, channel, data)
end

function DAQmxSetAIGain(taskHandle::TaskHandle, channel::Ptr{Cchar}, data::float64)
    ccall((:DAQmxSetAIGain, libnidaq), int32, (TaskHandle, Ptr{Cchar}, float64), taskHandle, channel, data)
end

function DAQmxGetAOOutputType(taskHandle::TaskHandle, channel::Ptr{Cchar}, data::Ptr{int32})
    ccall((:DAQmxGetAOOutputType, libnidaq), int32, (TaskHandle, Ptr{Cchar}, Ptr{int32}), taskHandle, channel, data)
end

function DAQmxGetAOMax(taskHandle::TaskHandle, channel::Ptr{Cchar}, data::Ptr{float64})
    ccall((:DAQmxGetAOMax, libnidaq), int32, (TaskHandle, Ptr{Cchar}, Ptr{float64}), taskHandle, channel, data)
end

function DAQmxSetAOMax(taskHandle::TaskHandle, channel::Ptr{Cchar}, data::float64)
    ccall((:DAQmxSetAOMax, libnidaq), int32, (TaskHandle, Ptr{Cchar}, float64), taskHandle, channel, data)
end

function DAQmxGetAOMin(taskHandle::TaskHandle, channel::Ptr{Cchar}, data::Ptr{float64})
    ccall((:DAQmxGetAOMin, libnidaq), int32, (TaskHandle, Ptr{Cchar}, Ptr{float64}), taskHandle, channel, data)
end

function DAQmxSetAOMin(taskHandle::TaskHandle, channel::Ptr{Cchar}, data::float64)
    ccall((:DAQmxSetAOMin, libnidaq), int32, (TaskHandle, Ptr{Cchar}, float64), taskHandle, channel, data)
end

function DAQmxGetCIMeasType(taskHandle::TaskHandle, channel::Ptr{Cchar}, data::Ptr{int32})
    ccall((:DAQmxGetCIMeasType, libnidaq), int32, (TaskHandle, Ptr{Cchar}, Ptr{int32}), taskHandle, channel, data)
end

function DAQmxGetCOOutputType(taskHandle::TaskHandle, channel::Ptr{Cchar}, data::Ptr{int32})
    ccall((:DAQmxGetCOOutputType, libnidaq), int32, (TaskHandle, Ptr{Cchar}, Ptr{int32}), taskHandle, channel, data)
end

function DAQmxGetCITwoEdgeSepUnits(taskHandle::TaskHandle, channel::Ptr{Cchar}, data::Ptr{int32})
    ccall((:DAQmxGetCITwoEdgeSepUnits, libnidaq), int32, (TaskHandle, Ptr{Cchar}, Ptr{int32}), taskHandle, channel, data)
end

# Timing property getters/setters
function DAQmxGetSampClkRate(taskHandle::TaskHandle, data::Ptr{float64})
    ccall((:DAQmxGetSampClkRate, libnidaq), int32, (TaskHandle, Ptr{float64}), taskHandle, data)
end

function DAQmxSetSampClkRate(taskHandle::TaskHandle, data::float64)
    ccall((:DAQmxSetSampClkRate, libnidaq), int32, (TaskHandle, float64), taskHandle, data)
end

function DAQmxGetSampClkSrc(taskHandle::TaskHandle, data::Ptr{Cchar}, bufferSize::uInt32)
    ccall((:DAQmxGetSampClkSrc, libnidaq), int32, (TaskHandle, Ptr{Cchar}, uInt32), taskHandle, data, bufferSize)
end

function DAQmxSetSampClkSrc(taskHandle::TaskHandle, data::Ptr{Cchar})
    ccall((:DAQmxSetSampClkSrc, libnidaq), int32, (TaskHandle, Ptr{Cchar}), taskHandle, data)
end

function DAQmxGetSampClkActiveEdge(taskHandle::TaskHandle, data::Ptr{int32})
    ccall((:DAQmxGetSampClkActiveEdge, libnidaq), int32, (TaskHandle, Ptr{int32}), taskHandle, data)
end

function DAQmxSetSampClkActiveEdge(taskHandle::TaskHandle, data::int32)
    ccall((:DAQmxSetSampClkActiveEdge, libnidaq), int32, (TaskHandle, int32), taskHandle, data)
end

function DAQmxGetSampQuantSampMode(taskHandle::TaskHandle, data::Ptr{int32})
    ccall((:DAQmxGetSampQuantSampMode, libnidaq), int32, (TaskHandle, Ptr{int32}), taskHandle, data)
end

function DAQmxSetSampQuantSampMode(taskHandle::TaskHandle, data::int32)
    ccall((:DAQmxSetSampQuantSampMode, libnidaq), int32, (TaskHandle, int32), taskHandle, data)
end

function DAQmxGetSampQuantSampPerChan(taskHandle::TaskHandle, data::Ptr{uInt64})
    ccall((:DAQmxGetSampQuantSampPerChan, libnidaq), int32, (TaskHandle, Ptr{Culonglong}), taskHandle, data)
end

function DAQmxSetSampQuantSampPerChan(taskHandle::TaskHandle, data::uInt64)
    ccall((:DAQmxSetSampQuantSampPerChan, libnidaq), int32, (TaskHandle, Culonglong), taskHandle, data)
end

# Buffer functions
function DAQmxCfgInputBuffer(taskHandle::TaskHandle, numSampsPerChan::uInt32)
    ccall((:DAQmxCfgInputBuffer, libnidaq), int32, (TaskHandle, uInt32), taskHandle, numSampsPerChan)
end

function DAQmxCfgOutputBuffer(taskHandle::TaskHandle, numSampsPerChan::uInt32)
    ccall((:DAQmxCfgOutputBuffer, libnidaq), int32, (TaskHandle, uInt32), taskHandle, numSampsPerChan)
end

function DAQmxGetBufInputBufSize(taskHandle::TaskHandle, data::Ptr{uInt32})
    ccall((:DAQmxGetBufInputBufSize, libnidaq), int32, (TaskHandle, Ptr{uInt32}), taskHandle, data)
end

function DAQmxSetBufInputBufSize(taskHandle::TaskHandle, data::uInt32)
    ccall((:DAQmxSetBufInputBufSize, libnidaq), int32, (TaskHandle, uInt32), taskHandle, data)
end

function DAQmxGetBufOutputBufSize(taskHandle::TaskHandle, data::Ptr{uInt32})
    ccall((:DAQmxGetBufOutputBufSize, libnidaq), int32, (TaskHandle, Ptr{uInt32}), taskHandle, data)
end

function DAQmxSetBufOutputBufSize(taskHandle::TaskHandle, data::uInt32)
    ccall((:DAQmxSetBufOutputBufSize, libnidaq), int32, (TaskHandle, uInt32), taskHandle, data)
end

# Read position functions
function DAQmxGetReadAvailSampPerChan(taskHandle::TaskHandle, data::Ptr{uInt32})
    ccall((:DAQmxGetReadAvailSampPerChan, libnidaq), int32, (TaskHandle, Ptr{uInt32}), taskHandle, data)
end

function DAQmxGetReadTotalSampPerChanAcquired(taskHandle::TaskHandle, data::Ptr{uInt64})
    ccall((:DAQmxGetReadTotalSampPerChanAcquired, libnidaq), int32, (TaskHandle, Ptr{Culonglong}), taskHandle, data)
end

function DAQmxGetReadCurrReadPos(taskHandle::TaskHandle, data::Ptr{uInt64})
    ccall((:DAQmxGetReadCurrReadPos, libnidaq), int32, (TaskHandle, Ptr{Culonglong}), taskHandle, data)
end

# Write position functions
function DAQmxGetWriteSpaceAvail(taskHandle::TaskHandle, data::Ptr{uInt32})
    ccall((:DAQmxGetWriteSpaceAvail, libnidaq), int32, (TaskHandle, Ptr{uInt32}), taskHandle, data)
end

function DAQmxGetWriteTotalSampPerChanGenerated(taskHandle::TaskHandle, data::Ptr{uInt64})
    ccall((:DAQmxGetWriteTotalSampPerChanGenerated, libnidaq), int32, (TaskHandle, Ptr{Culonglong}), taskHandle, data)
end

function DAQmxGetWriteCurrWritePos(taskHandle::TaskHandle, data::Ptr{uInt64})
    ccall((:DAQmxGetWriteCurrWritePos, libnidaq), int32, (TaskHandle, Ptr{Culonglong}), taskHandle, data)
end

function DAQmxGetWriteRegenMode(taskHandle::TaskHandle, data::Ptr{int32})
    ccall((:DAQmxGetWriteRegenMode, libnidaq), int32, (TaskHandle, Ptr{int32}), taskHandle, data)
end

function DAQmxSetWriteRegenMode(taskHandle::TaskHandle, data::int32)
    ccall((:DAQmxSetWriteRegenMode, libnidaq), int32, (TaskHandle, int32), taskHandle, data)
end
