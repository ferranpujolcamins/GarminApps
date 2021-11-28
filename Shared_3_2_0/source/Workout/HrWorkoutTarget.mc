import Toybox.Lang;
import Toybox.Activity;

module Shared_3_2_0 {
    
    (:Workout)
    module Workout {
        
        class HrWorkoutTarget {
            hidden var mWorkoutStep as WorkoutStep;

            function initialize(workoutStep as WorkoutStep) {
                mWorkoutStep = workoutStep;
            }

            static function isTargetHr(workoutStep as WorkoutStep) as HrWorkoutTarget? {
                if (workoutStep.targetType != Activity.WORKOUT_STEP_TARGET_HEART_RATE) {
                    return null;
                }
                return new HrWorkoutTarget(workoutStep);
            }

            function isZone() as Boolean {
                return mWorkoutStep.targetValueLow < 100;
            }

            function getZone() as Number {
                return mWorkoutStep.targetValueLow;
            }

            function getValueLow() as Number {
                // There seems to be a bug in connectIQ that sets these values 100 too high.
                return mWorkoutStep.targetValueLow - 100;
            }

            function getValueHigh() as Number {
                // There seems to be a bug in connectIQ that sets these values 100 too high.
                return mWorkoutStep.targetValueHigh - 100;
            }
        }
    }
}