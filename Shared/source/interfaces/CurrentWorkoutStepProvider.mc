import Toybox.Activity;

module Shared {
    
    (:CurrentWorkoutStepProvider)
    module CurrentWorkoutStepProviderModule {

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
    }

    (:CurrentWorkoutStepProvider, :tests)
    module CurrentWorkoutStepProviderTests {

        class MockCurrentWorkoutStepProvider {
            function getCurrentWorkoutStep() as WorkoutStep? {
                return mWorkoutStep;
            }

            var mWorkoutStep as WorkoutStep? = new Activity.WorkoutStep();
        }
    }
}