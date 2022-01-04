import Toybox.Lang;
import Toybox.Activity;
import Toybox.System;
import Shared_IQ_1_4_0.Format;
import Shared_IQ_1_4_0.Units;
import Shared_IQ_3_2_0.Workout;

module TargetPaceField {
    function compute(workoutStepProvider as CurrentWorkoutStepProvider) as String {
        var heartRate = tryCompute(workoutStepProvider);
        return heartRate == null ? "--:--" : heartRate;
    }

    function tryCompute(workoutStepProvider as CurrentWorkoutStepProvider) as String? {
        var workoutStep = workoutStepProvider.getCurrentWorkoutStep();
        if (workoutStep == null) { 
            return null;
        }

        if(workoutStep.targetType != Activity.WORKOUT_STEP_TARGET_SPEED) {
            return null;
        }
        // TODO: read unit from preferences
        var lowPace = Units.convert(workoutStep.targetValueHigh as Double, Units.MetersPerSecond, Units.MinPerKm);
        var highPace = Units.convert(workoutStep.targetValueLow as Double, Units.MetersPerSecond, Units.MinPerKm);
        return Format.minutesAndSecondsFromMinutes((lowPace + highPace) / 2d);
    }
}
