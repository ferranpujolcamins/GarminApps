import Toybox.Lang;
import Toybox.Activity;
import Toybox.UserProfile;
import Toybox.Test;
import TargetHrField;
using Shared_IQ_1_4_0.UserProfileInterfaces;
using Shared_IQ_3_2_0.Workout;

// Given that:
// - There's no current workout step.
// Then:
// - We display the placeholder text.
(:test)
function testTargetHrIsNullWhenNoWorkout(logger as Logger) as Boolean {
    var currentWorkoutStepProvider = new Workout.UnitTests.MockCurrentWorkoutStepProvider();
    currentWorkoutStepProvider.mWorkoutStep = null;

    var field = TargetHrField.compute(currentWorkoutStepProvider, UserProfile);

    logger.debug("field = " + field);
    return field.equals("--");
}

// Given that:
// - There workout target is not heart rate.
// Then:
// - We display the placeholder text.
(:test)
function testTargetHrIsNullWhenTargetIsNotHr(logger as Logger) as Boolean {
    var currentWorkoutStepProvider = new Workout.UnitTests.MockCurrentWorkoutStepProvider();
    var workoutStep = new Activity.WorkoutStep();
    workoutStep.targetType = Activity.WORKOUT_STEP_TARGET_SPEED;
    workoutStep.targetValueLow = 10;
    workoutStep.targetValueHigh = 12;
    currentWorkoutStepProvider.mWorkoutStep = workoutStep;

    var field = TargetHrField.compute(currentWorkoutStepProvider, UserProfile);

    logger.debug("field = " + field);
    return field.equals("--");
}

// Given that:
// - The workout target is specified as heart rate limits.
// Then:
// - We display the average of the low and high heart rate limits.
(:test)
function testTargetHrIsAverageOfLowAndHighHrTargets(logger as Logger) as Boolean {
    var currentWorkoutStepProvider = new Workout.UnitTests.MockCurrentWorkoutStepProvider();
    var workoutStep = new Activity.WorkoutStep();
    workoutStep.targetType = Activity.WORKOUT_STEP_TARGET_HEART_RATE;
    // There seems to be a bug in connectIQ that sets these values 100 too high.
    workoutStep.targetValueLow = 120 + 100;
    workoutStep.targetValueHigh = 140 + 100;
    currentWorkoutStepProvider.mWorkoutStep = workoutStep;

    var field = TargetHrField.compute(currentWorkoutStepProvider, UserProfile);

    logger.debug("field = " + field);
    return field.equals("130");
}

// Given that:
// - The workout target is specified as heart rate zone.
// Then:
// - We display the average of the low and high heart rate limits of the zone.
(:test)
function testTargetHrWithHrZoneTarget(logger as Logger) as Boolean {
    var currentWorkoutStepProvider = new Workout.UnitTests.MockCurrentWorkoutStepProvider();
    var workoutStep = new Activity.WorkoutStep();
    workoutStep.targetType = Activity.WORKOUT_STEP_TARGET_HEART_RATE;
    workoutStep.targetValueLow = 2;
    workoutStep.targetValueHigh = 0;
    currentWorkoutStepProvider.mWorkoutStep = workoutStep;

    var userProfileProvider = new UserProfileInterfaces.UnitTests.MockUserProfileProvider();
    userProfileProvider.mZones = [120, 130, 140, 150, 160, 170] as Array<Number>;
    userProfileProvider.mProfile.restingHeartRate = 60;

    var field = TargetHrField.compute(currentWorkoutStepProvider, userProfileProvider);

    logger.debug("field = " + field);
    return field.equals("135");
}