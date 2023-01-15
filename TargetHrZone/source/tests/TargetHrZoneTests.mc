import Toybox.Lang;
import Toybox.Activity;
import Toybox.UserProfile;
import Toybox.Test;
using Shared_IQ_1_4_0.UserProfileInterfaces;
import Shared_IQ_1_4_0.PropertiesModule;
using Shared_IQ_3_2_0.Workout;

// Given that:
// - There's no current workout step and there has never been one
// Then:
// - We display the placeholder text.
(:test)
function testFieldIsNullWhenNoWorkout(logger as Logger) as Boolean {
    var currentWorkoutStepProvider = new Workout.UnitTests.MockCurrentWorkoutStepProvider();
    currentWorkoutStepProvider.mWorkoutStep = null;

    var fieldText = new TargetHrZoneField(currentWorkoutStepProvider, UserProfile, new PropertiesModule.ApplicationProperties())
        .compute();

    logger.debug("field = " + fieldText);
    return fieldText.equals("-.-");
}

// Given that:
// - There's no current workout step but a workout step has existed before
// Then:
// - We display the last workout step target between parentheses.
(:test)
function testFieldIsShownAfterWorkout(logger as Logger) as Boolean {
    var currentWorkoutStepProvider = new Workout.UnitTests.MockCurrentWorkoutStepProvider();
    var workoutStep = new Activity.WorkoutStep();
    workoutStep.targetType = Activity.WORKOUT_STEP_TARGET_HEART_RATE;
    workoutStep.targetValueLow = 2;
    workoutStep.targetValueHigh = 0;
    currentWorkoutStepProvider.mWorkoutStep = workoutStep;

    var field = new TargetHrZoneField(currentWorkoutStepProvider, UserProfile, new PropertiesModule.ApplicationProperties());
    var fieldText1 = field.compute();

    currentWorkoutStepProvider.mWorkoutStep = null;

    var fieldText2 = field.compute();

    logger.debug("field (1) = " + fieldText1);
    logger.debug("field (2) = " + fieldText2);
    return fieldText1.equals("2") && fieldText2.equals("(2)");
}

// Given that:
// - There workout target is not heart rate
// Then:
// - We display the placeholder text.
(:test)
function testFieldIsNullWhenTargetIsNotHr(logger as Logger) as Boolean {
    var currentWorkoutStepProvider = new Workout.UnitTests.MockCurrentWorkoutStepProvider();
    var workoutStep = new Activity.WorkoutStep();
    workoutStep.targetType = Activity.WORKOUT_STEP_TARGET_SPEED;
    workoutStep.targetValueLow = 10;
    workoutStep.targetValueHigh = 12;
    currentWorkoutStepProvider.mWorkoutStep = workoutStep;

    var fieldText = new TargetHrZoneField(currentWorkoutStepProvider, UserProfile, new PropertiesModule.ApplicationProperties())
        .compute();

    logger.debug("field = " + fieldText);
    return fieldText.equals("-.-");
}

// Given that:
// - The workout target is specified as heart rate limits
// - The hr limits do not coincide with a heart rate zone
// - The default value setting is set to "Average"
// - The average of both limits does not coincides with the threshold of an hr zone
// Then:
// - The target zone is the value corresponding to the average of the high and low hr limits
// - We display the target zone with the decimal point, so the user can see that the target is not a heart rate zone.
(:test)
function testWhenDefaultValueIsAverage(logger as Logger) as Boolean {
    var currentWorkoutStepProvider = new Workout.UnitTests.MockCurrentWorkoutStepProvider();
    var workoutStep = new Activity.WorkoutStep();
    workoutStep.targetType = Activity.WORKOUT_STEP_TARGET_HEART_RATE;
    // There seems to be a bug in connectIQ that sets these values 100 too high.
    workoutStep.targetValueLow = 130 + 100;
    workoutStep.targetValueHigh = 150 + 100;
    currentWorkoutStepProvider.mWorkoutStep = workoutStep;

    var userProfileProvider = new UserProfileInterfaces.UnitTests.MockUserProfileProvider();
    userProfileProvider.mZones = [110, 135, 150, 155, 160, 170] as Array<Number>;

    var properties = new PropertiesModule.UnitTests.MockProperties();
    properties.setValue(DefaultValue as String, Average as Number);

    var fieldText = new TargetHrZoneField(currentWorkoutStepProvider, userProfileProvider, properties)
        .compute();

    logger.debug("field = " + fieldText);
    return fieldText.equals("2.3");
}

// Given that:
// - The workout target is specified as heart rate limits
// - The hr limits do not coincide with a heart rate zone
// - The average of both limits coincides with the threshold of a hr zone
// Then:
// - The target zone is the value corresponding to the average of the high and low hr limits
// - We display the target zone with the decimal point, so the user can see that the target is not a heart rate zone.
(:test)
function testDefaultValueIsDisplayedWithDecimalWhenNotExactZone(logger as Logger) as Boolean {
    var currentWorkoutStepProvider = new Workout.UnitTests.MockCurrentWorkoutStepProvider();
    var workoutStep = new Activity.WorkoutStep();
    workoutStep.targetType = Activity.WORKOUT_STEP_TARGET_HEART_RATE;
    // There seems to be a bug in connectIQ that sets these values 100 too high.
    workoutStep.targetValueLow = 150 + 100;
    workoutStep.targetValueHigh = 160 + 100;
    currentWorkoutStepProvider.mWorkoutStep = workoutStep;

    var userProfileProvider = new UserProfileInterfaces.UnitTests.MockUserProfileProvider();
    userProfileProvider.mZones = [110, 135, 150, 155, 160, 170] as Array<Number>;

    var properties = new PropertiesModule.UnitTests.MockProperties();
    properties.setValue(DefaultValue as String, Average as Number);

    var fieldText = new TargetHrZoneField(currentWorkoutStepProvider, userProfileProvider, properties)
        .compute();

    logger.debug("field = " + fieldText);
    return fieldText.equals("4.0");
}

// Given that:
// - The workout target is specified as heart rate limits
// - The hr limits coincide with a heart rate zone
// Then:
// - The target zone is the hr zone that matches the high and low hr limits
// - We display the target zone without the decimal point, so the user can see that the target is a heart rate zone.
(:test)
function testDefaultValueIsNotDisplayedWhenTargetIsExactlyAZone(logger as Logger) as Boolean {
    var currentWorkoutStepProvider = new Workout.UnitTests.MockCurrentWorkoutStepProvider();
    var workoutStep = new Activity.WorkoutStep();
    workoutStep.targetType = Activity.WORKOUT_STEP_TARGET_HEART_RATE;
    // There seems to be a bug in connectIQ that sets these values 100 too high.
    workoutStep.targetValueLow = 155 + 100;
    workoutStep.targetValueHigh = 160 + 100;
    currentWorkoutStepProvider.mWorkoutStep = workoutStep;

    var userProfileProvider = new UserProfileInterfaces.UnitTests.MockUserProfileProvider();
    userProfileProvider.mZones = [110, 135, 150, 155, 160, 170] as Array<Number>;

    var fieldText = new TargetHrZoneField(currentWorkoutStepProvider, userProfileProvider, new PropertiesModule.ApplicationProperties())
        .compute();

    logger.debug("field = " + fieldText);
    return fieldText.equals("4");
}

// Given that:
// - The workout target is specified as heart rate limits
// - The hr limits do not coincide with a heart rate zone
// - The default value setting is set to "Low Heart Rate"
// Then:
// - The target zone is the value corresponding to low hr limit
// - We display the target zone with the decimal point, so the user can see that the target is not a heart rate zone.
(:test)
function testWhenDefaultValueIsLowLimit(logger as Logger) as Boolean {
    var currentWorkoutStepProvider = new Workout.UnitTests.MockCurrentWorkoutStepProvider();
    var workoutStep = new Activity.WorkoutStep();
    workoutStep.targetType = Activity.WORKOUT_STEP_TARGET_HEART_RATE;
    // There seems to be a bug in connectIQ that sets these values 100 too high.
    workoutStep.targetValueLow = 130 + 100;
    workoutStep.targetValueHigh = 150 + 100;
    currentWorkoutStepProvider.mWorkoutStep = workoutStep;

    var userProfileProvider = new UserProfileInterfaces.UnitTests.MockUserProfileProvider();
    userProfileProvider.mZones = [110, 135, 150, 155, 160, 170] as Array<Number>;

    var properties = new PropertiesModule.UnitTests.MockProperties();
    properties.setValue(DefaultValue as String, LowLimit as Number);

    var fieldText = new TargetHrZoneField(currentWorkoutStepProvider, userProfileProvider, properties)
        .compute();

    logger.debug("field = " + fieldText);
    return fieldText.equals("1.8");
}

// Given that:
// - The workout target is specified as heart rate limits
// - The hr limits do not coincide with a heart rate zone
// - The default value setting is set to "High Heart Rate"
// Then:
// - The target zone is the value corresponding to high hr limit
// - We display the target zone with the decimal point, so the user can see that the target is not a heart rate zone.
(:test)
function testWhenDefaultValueIsHighLimit(logger as Logger) as Boolean {
    var currentWorkoutStepProvider = new Workout.UnitTests.MockCurrentWorkoutStepProvider();
    var workoutStep = new Activity.WorkoutStep();
    workoutStep.targetType = Activity.WORKOUT_STEP_TARGET_HEART_RATE;
    // There seems to be a bug in connectIQ that sets these values 100 too high.
    workoutStep.targetValueLow = 130 + 100;
    workoutStep.targetValueHigh = 152 + 100;
    currentWorkoutStepProvider.mWorkoutStep = workoutStep;

    var userProfileProvider = new UserProfileInterfaces.UnitTests.MockUserProfileProvider();
    userProfileProvider.mZones = [110, 135, 150, 155, 160, 170] as Array<Number>;

    var properties = new PropertiesModule.UnitTests.MockProperties();
    properties.setValue(DefaultValue as String, HighLimit as Number);

    var fieldText = new TargetHrZoneField(currentWorkoutStepProvider, userProfileProvider, properties)
        .compute();

    logger.debug("field = " + fieldText);
    return fieldText.equals("3.4");
}

// Given that:
// - The workout target is specified as heart rate limits
// - The default value setting is set to "Average"
// - The heart rate limits average is exactly the middle of the heart rate zone
// - The heart rate limits average is not an integer number
// Then:
// - The target zone is `X.5`.
(:test)
function testTargetHrZoneIsNotRoundedOff(logger as Logger) as Boolean {
    var currentWorkoutStepProvider = new Workout.UnitTests.MockCurrentWorkoutStepProvider();
    var workoutStep = new Activity.WorkoutStep();
    workoutStep.targetType = Activity.WORKOUT_STEP_TARGET_HEART_RATE;
    // There seems to be a bug in connectIQ that sets these values 100 too high.
    workoutStep.targetValueLow = 154 + 100;
    workoutStep.targetValueHigh = 161 + 100;
    currentWorkoutStepProvider.mWorkoutStep = workoutStep;

    var userProfileProvider = new UserProfileInterfaces.UnitTests.MockUserProfileProvider();
    userProfileProvider.mZones = [110, 135, 150, 155, 160, 170] as Array<Number>;

    var properties = new PropertiesModule.UnitTests.MockProperties();
    properties.setValue(DefaultValue as String, Average as Number);

    var fieldText = new TargetHrZoneField(currentWorkoutStepProvider, userProfileProvider, properties)
        .compute();

    logger.debug("field = " + fieldText);
    return fieldText.equals("4.5");
}

// Given that:
// - The workout target is specified as heart rate zone
// Then:
// - We display the target zone without the decimal point, so the user can see that the target is a heart rate zone.
(:test)
function testTargetHrZoneWithHrZoneTarget(logger as Logger) as Boolean {
    var currentWorkoutStepProvider = new Workout.UnitTests.MockCurrentWorkoutStepProvider();
    var workoutStep = new Activity.WorkoutStep();
    workoutStep.targetType = Activity.WORKOUT_STEP_TARGET_HEART_RATE;
    workoutStep.targetValueLow = 2;
    workoutStep.targetValueHigh = 0;
    currentWorkoutStepProvider.mWorkoutStep = workoutStep;

    var fieldText = new TargetHrZoneField(currentWorkoutStepProvider, UserProfile, new PropertiesModule.ApplicationProperties())
        .compute();

    logger.debug("field = " + fieldText);
    return fieldText.equals("2");
}