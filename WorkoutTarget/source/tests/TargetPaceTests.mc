import Toybox.Lang;
import Toybox.Activity;
import Toybox.Test;
using Shared_IQ_3_2_0.Workout;
import TargetPaceField;

// Given that:
// - There's no current workout step.
// Then:
// - We display the placeholder text.
(:test)
function testTargetPaceFieldIsNullWhenNoWorkout(logger as Logger) as Boolean {
    var currentWorkoutStepProvider = new Workout.UnitTests.MockCurrentWorkoutStepProvider();
    currentWorkoutStepProvider.mWorkoutStep = null;

    var field = TargetPaceField.compute(currentWorkoutStepProvider);

    logger.debug("field = " + field);
    return field.equals("--:--");
}

// Given that:
// - There workout target is not heart rate.
// Then:
// - We display the placeholder text.
(:test)
function testTargetPaceFieldIsNullWhenTargetIsNotPaceNorSpeed(logger as Logger) as Boolean {
    var currentWorkoutStepProvider = new Workout.UnitTests.MockCurrentWorkoutStepProvider();
    var workoutStep = new Activity.WorkoutStep();
    workoutStep.targetType = Activity.WORKOUT_STEP_TARGET_HEART_RATE;
    workoutStep.targetValueLow = 120;
    workoutStep.targetValueHigh = 130;
    currentWorkoutStepProvider.mWorkoutStep = workoutStep;

    var field = TargetPaceField.compute(currentWorkoutStepProvider);

    logger.debug("field = " + field);
    return field.equals("--:--");
}

// Given that:
// - The workout target is a speed range.
// Then:
// - We display the average of the low and high pace limits.
(:test)
function testTargetPaceIsAverage(logger as Logger) as Boolean {
    var currentWorkoutStepProvider = new Workout.UnitTests.MockCurrentWorkoutStepProvider();
    var workoutStep = new Activity.WorkoutStep();
    workoutStep.targetType = Activity.WORKOUT_STEP_TARGET_SPEED;
    workoutStep.targetValueLow = (1/(5.5d * 60 / 1000)) as Number; // 5:30 min/km in m/s
    workoutStep.targetValueHigh = (1/(6.5d * 60 / 1000)) as Number; // 6:30 min/km in m/s
    currentWorkoutStepProvider.mWorkoutStep = workoutStep;

    var field = TargetPaceField.compute(currentWorkoutStepProvider);

    logger.debug("field = " + field);
    return field.equals("6:00");
}

// Given that:
// - The workout target is a single speed.
// Then:
// - We display the speed.
(:test)
function testTargetPaceIsSingleSpeed(logger as Logger) as Boolean {
    var currentWorkoutStepProvider = new Workout.UnitTests.MockCurrentWorkoutStepProvider();
    var workoutStep = new Activity.WorkoutStep();
    workoutStep.targetType = Activity.WORKOUT_STEP_TARGET_SPEED;
    workoutStep.targetValueLow = (1/(5.5d * 60 / 1000)) as Number; // 5:30 min/km in m/s
    workoutStep.targetValueHigh = workoutStep.targetValueLow;
    currentWorkoutStepProvider.mWorkoutStep = workoutStep;

    var field = TargetPaceField.compute(currentWorkoutStepProvider);

    logger.debug("field = " + field);
    return field.equals("5:30");
}