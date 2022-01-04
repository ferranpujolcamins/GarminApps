import Toybox.Lang;
import Toybox.Activity;
import Toybox.System;
import Shared_IQ_1_4_0.Format;
import Shared_IQ_1_4_0.Units;
import Shared_IQ_1_4_0.DeviceSettingsInterfaces;
import Shared_IQ_3_2_0.Workout;

class TargetPaceField {
    function initialize(workoutStepProvider as CurrentWorkoutStepProvider,
                        deviceSettingsProvider as DeviceSettingsProvider) {
        mWorkoutStepProvider = workoutStepProvider;
        mDeviceSettingsProvider = deviceSettingsProvider;
    }

    function compute() as String {
        var heartRate = tryCompute();
        return heartRate == null ? "--:--" : heartRate;
    }

    function tryCompute() as String? {
        var workoutStep = mWorkoutStepProvider.getCurrentWorkoutStep();
        if (workoutStep == null) { 
            return null;
        }

        if(workoutStep.targetType != Activity.WORKOUT_STEP_TARGET_SPEED) {
            return null;
        }

        var targetUnits = mDeviceSettingsProvider.paceUnits() == System.UNIT_METRIC
            ? Units.MinPerKm
            : Units.MinPerMile;
        var lowPace = Units.convert(workoutStep.targetValueHigh as Double, Units.MetersPerSecond, targetUnits);
        var highPace = Units.convert(workoutStep.targetValueLow as Double, Units.MetersPerSecond, targetUnits);
        return Format.minutesAndSecondsFromMinutes((lowPace + highPace) / 2d);
    }

    hidden var mWorkoutStepProvider as CurrentWorkoutStepProvider;
    hidden var mDeviceSettingsProvider as DeviceSettingsProvider;
}
