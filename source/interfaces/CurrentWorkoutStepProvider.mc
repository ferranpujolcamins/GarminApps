import Toybox.Activity;

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
            // TODO: check we return correct values while in rest step.
            return stepOrInterval.activeStep;
        }
        return stepOrInterval;
    }

    private var mActivity as Activity;
}

(:test)
module UnitTest {
    class MockCurrentWorkoutStepProvider {
        function getCurrentWorkoutStep() as WorkoutStep? {
            return mWorkoutStep;
        }

        var mWorkoutStep as WorkoutStep? = new Activity.WorkoutStep();
    }
}