import Toybox.Lang;
import Toybox.Activity;
import Toybox.Test;

(:test)
function testTargetHrIsNullWhenNoWorkout(logger as Logger) as Boolean {
    var field = new TripleFieldView();

    var currentWorkoutStepProvider = new UnitTest.MockCurrentWorkoutStepProvider();
    var workoutStep = null;

    var info = new Activity.Info();

    var properties = new UnitTest.MockProperties();
    properties.setValue(MainDataField, TargetHR);

    var model = field._compute(currentWorkoutStepProvider, info, properties);

    logger.debug("mMainFieldValue = " + model.mMainFieldValue);
    return model.mMainFieldValue == null;
}

(:test)
function testTargetHrIsAverageOfLowAndHighTargets(logger as Logger) as Boolean {
    var field = new TripleFieldView();

    var currentWorkoutStepProvider = new UnitTest.MockCurrentWorkoutStepProvider();
    var workoutStep = new Activity.WorkoutStep();
    workoutStep.targetType = Activity.WORKOUT_STEP_TARGET_HEART_RATE;
    workoutStep.targetValueLow = 120;
    workoutStep.targetValueHigh = 140;
    currentWorkoutStepProvider.mWorkoutStep = workoutStep;

    var info = new Activity.Info();

    var properties = new UnitTest.MockProperties();
    properties.setValue(MainDataField, TargetHR);

    var model = field._compute(currentWorkoutStepProvider, info, properties);

    logger.debug("mMainFieldValue = " + model.mMainFieldValue);
    return model.mMainFieldValue == 130;
}