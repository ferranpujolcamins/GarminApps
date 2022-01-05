import Toybox.Lang;
import Toybox.Activity;

module Shared_IQ_3_2_0 {
    
    (:Workout)
    module Workout {
        
        // A class that represents a heart rate workout step target and allows you to get its information.
        //
        // Don't manually create an instance of this class. Use the static method 'isTargetHr' instead.
        class HrWorkoutTarget {

            // Checks whether the current workout step target is a heart rate target or not.
            // If it is, create an instance of this class so you can use it to get the heart rate target information.
            static function isTargetHr(workoutStep as WorkoutStep) as HrWorkoutTarget? {
                if (workoutStep.targetType != Activity.WORKOUT_STEP_TARGET_HEART_RATE) {
                    return null;
                }
                return new HrWorkoutTarget(workoutStep);
            }

            // Do not create an instance manually. Use 'isTargetHr' instead.
            function initialize(workoutStep as WorkoutStep) {
                mWorkoutStep = workoutStep;
            }

            // Returns true when the heart rate target is specified as a heart rate zone.
            // Returns false when the heart rate target is specified as a heart rate range.
            function isZone() as Boolean {
                return mWorkoutStep.targetValueLow < 100;
            }

            // Get the target heart rate zone.
            //
            // Check that the target is indeed a heart rate zone with 'isZone' before using this method.
            function getZone() as Number {
                return mWorkoutStep.targetValueLow;
            }

            // Get the low limit of the target heart rate range.
            //
            // Check that the target is indeed a heart rate range with 'isZone' before using this method.
            function getValueLow() as Number {
                // ConnectIQ seems to encode hr zone when the value < 100, and heartRate + 100 when value >= 100.
                return mWorkoutStep.targetValueLow - 100;
            }

            // Get the high limit of the target heart rate range.
            //
            // Check that the target is indeed a heart rate range with 'isZone' before using this method.
            function getValueHigh() as Number {
                // ConnectIQ seems to encode hr zone when the value < 100, and heartRate + 100 when value >= 100.
                return mWorkoutStep.targetValueHigh - 100;
            }

            hidden var mWorkoutStep as WorkoutStep;
        }
    }
}