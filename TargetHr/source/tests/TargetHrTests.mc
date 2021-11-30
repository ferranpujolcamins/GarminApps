import Toybox.Lang;
import Toybox.Activity;
import Toybox.UserProfile;
import Toybox.Test;
import TargetHrField;
using Shared_IQ_1_4_0.UserProfileInterfaces;
using Shared_IQ_3_2_0.Workout;

(:test)
function testTargetHrIsNullWhenNoWorkout(logger as Logger) as Boolean {
    var currentWorkoutStepProvider = new Workout.UnitTests.MockCurrentWorkoutStepProvider();
    currentWorkoutStepProvider.mWorkoutStep = null;

    var field = TargetHrField.compute(currentWorkoutStepProvider, UserProfile);

    logger.debug("field = " + field);
    return field.equals("--");
}

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