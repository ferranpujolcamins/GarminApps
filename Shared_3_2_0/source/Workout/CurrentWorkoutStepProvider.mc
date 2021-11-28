import Toybox.Activity;

module Shared_3_2_0 {
    
    (:Workout)
    module Workout {

        typedef CurrentWorkoutStepProvider as interface {
            function getCurrentWorkoutStep() as WorkoutStep?;
        };

        class ActivityCurrentWorkoutStepProvider {
            function initialize(activity as Activity) {
                mActivity = activity;
            }

            function getCurrentWorkoutStep() as WorkoutStep? {
                if (!(mActivity has :getCurrentWorkoutStep)) {
                    return null;
                }
                var stepInfo = mActivity.getCurrentWorkoutStep();
                if (stepInfo == null) {
                    return null;
                }
                var stepOrInterval = stepInfo.step;
                if (stepOrInterval instanceof Activity.WorkoutIntervalStep) {
                    return stepOrInterval.activeStep;
                }
                return stepOrInterval;
            }

            private var mActivity as Activity;
        }

        (:test)
        module UnitTests {

            class MockCurrentWorkoutStepProvider {
                function getCurrentWorkoutStep() as WorkoutStep? {
                    return mWorkoutStep;
                }

                var mWorkoutStep as WorkoutStep? = new Activity.WorkoutStep();
            }
        }
    }
}