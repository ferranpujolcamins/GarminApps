import Toybox.Lang;
import Toybox.Activity;
import Toybox.UserProfile;
import Toybox.Test;

import Toybox.System;

(:test)
function testHiTargetHrZoneIsNullWhenNoWorkout(logger as Logger) as Boolean {
    var field = new TripleFieldView();

    var currentWorkoutStepProvider = new UnitTest.MockCurrentWorkoutStepProvider();
    currentWorkoutStepProvider.mWorkoutStep = null;

    var fieldValueProvider = new FieldValueProvider(
        currentWorkoutStepProvider,
        UserProfile,
        new Activity.Info()
    );

    var properties = new UnitTest.MockProperties();
    properties.setValue(MainDataField, HiTargetHRZone);

    var model = field._compute(fieldValueProvider, true, properties);

    logger.debug("mMainField = " + model.mMainField);
    return model.mMainField.equals("--");
}

(:test)
function testHiTargetHrZoneIsAverageOfLowAndHighHrTargets(logger as Logger) as Boolean {
    var field = new TripleFieldView();

    var currentWorkoutStepProvider = new UnitTest.MockCurrentWorkoutStepProvider();
    var workoutStep = new Activity.WorkoutStep();
    workoutStep.targetType = Activity.WORKOUT_STEP_TARGET_HEART_RATE;
    // There seems to be a bug in connectIQ that sets these values 100 too high.
    workoutStep.targetValueLow = 130 + 100;
    workoutStep.targetValueHigh = 154 + 100;
    currentWorkoutStepProvider.mWorkoutStep = workoutStep;

    var userProfileProvider = new UnitTest.MockUserProfileProvider();
    userProfileProvider.mZones = [110, 135, 155, 157, 160, 170] as Array<Number>;
    userProfileProvider.mProfile.restingHeartRate = 60;

    var fieldValueProvider = new FieldValueProvider(
        currentWorkoutStepProvider,
        userProfileProvider,
        new Activity.Info()
    );

    var properties = new UnitTest.MockProperties();
    properties.setValue(MainDataField, HiTargetHRZone);

    var model = field._compute(fieldValueProvider, true, properties);

    logger.debug("mMainField = " + model.mMainField);
    return model.mMainField.equals("2.9");
}

(:test)
function testHiTargetHrZoneWithHrZoneTarget(logger as Logger) as Boolean {
    var field = new TripleFieldView();

    var currentWorkoutStepProvider = new UnitTest.MockCurrentWorkoutStepProvider();
    var workoutStep = new Activity.WorkoutStep();
    workoutStep.targetType = Activity.WORKOUT_STEP_TARGET_HEART_RATE;
    workoutStep.targetValueLow = 2;
    workoutStep.targetValueHigh = 0;
    currentWorkoutStepProvider.mWorkoutStep = workoutStep;

    var fieldValueProvider = new FieldValueProvider(
        currentWorkoutStepProvider,
        UserProfile,
        new Activity.Info()
    );

    var properties = new UnitTest.MockProperties();
    properties.setValue(MainDataField, HiTargetHRZone);

    var model = field._compute(fieldValueProvider, true, properties);

    logger.debug("mMainField = " + model.mMainField);
    return model.mMainField.equals("3.0");
}

function testHiTargetHrZoneWithHrZone5Target(logger as Logger) as Boolean {
    var field = new TripleFieldView();

    var currentWorkoutStepProvider = new UnitTest.MockCurrentWorkoutStepProvider();
    var workoutStep = new Activity.WorkoutStep();
    workoutStep.targetType = Activity.WORKOUT_STEP_TARGET_HEART_RATE;
    workoutStep.targetValueLow = 5;
    workoutStep.targetValueHigh = 0;
    currentWorkoutStepProvider.mWorkoutStep = workoutStep;

    var fieldValueProvider = new FieldValueProvider(
        currentWorkoutStepProvider,
        UserProfile,
        new Activity.Info()
    );

    var properties = new UnitTest.MockProperties();
    properties.setValue(MainDataField, HiTargetHRZone);

    var model = field._compute(fieldValueProvider, true, properties);

    logger.debug("mMainField = " + model.mMainField);
    return model.mMainField.equals("5.9");
}