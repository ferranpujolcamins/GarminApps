import Toybox.Lang;
import Toybox.Activity;
import Toybox.UserProfile;
import Toybox.Test;

(:test)
function testTargetHrIsNullWhenNoWorkout(logger as Logger) as Boolean {
    var field = new TripleFieldView();

    var currentWorkoutStepProvider = new UnitTest.MockCurrentWorkoutStepProvider();
    currentWorkoutStepProvider.mWorkoutStep = null;

    var fieldValueProvider = new FieldValueProvider(
        currentWorkoutStepProvider,
        UserProfile,
        new Activity.Info()
    );

    var properties = new UnitTest.MockProperties();
    properties.setValue(MainDataField, TargetHR);

    var model = field._compute(fieldValueProvider, properties);

    logger.debug("mMainField = " + model.mMainField);
    return model.mMainField.equals("--");
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

    var fieldValueProvider = new FieldValueProvider(
        currentWorkoutStepProvider,
        UserProfile,
        new Activity.Info()
    );

    var properties = new UnitTest.MockProperties();
    properties.setValue(MainDataField, TargetHR);

    var model = field._compute(fieldValueProvider, properties);

    logger.debug("mMainField = " + model.mMainField);
    return model.mMainField.equals("130");
}