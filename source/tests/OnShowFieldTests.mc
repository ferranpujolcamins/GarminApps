import Toybox.Lang;
import Toybox.Activity;
import Toybox.Test;

(:test)
function testOnShowValues(logger as Logger) as Boolean {
    var field = new TripleFieldView();

    var currentWorkoutStepProvider = new UnitTest.MockCurrentWorkoutStepProvider();
    var workoutStep = new Activity.WorkoutStep();
    workoutStep.targetType = Activity.WORKOUT_STEP_TARGET_HEART_RATE;
    workoutStep.targetValueLow = 120;
    workoutStep.targetValueHigh = 140;
    currentWorkoutStepProvider.mWorkoutStep = workoutStep;

    var info = new Activity.Info();
    info.currentHeartRate = 150;

    var fieldValueProvider = new FieldValueProvider(
        currentWorkoutStepProvider,
        new UnitTest.MockUserProfileProvider(),
        info
        
    );

    var properties = new UnitTest.MockProperties();
    properties.setValue(MainDataField, HeartRate);
    properties.setValue(MainDataFieldOnShow, TargetHR);

    var modelOnShow = field._compute(fieldValueProvider, false, properties);
    var model = field._compute(fieldValueProvider, true, properties);

    logger.debug("mMainFieldOnShow = " + modelOnShow.mMainField);
    logger.debug("mMainField = " + model.mMainField);
    return modelOnShow.mMainField.equals("130")
        && model.mMainField.equals("150");
}
