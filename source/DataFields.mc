import Toybox.Lang;
import Toybox.Activity;

enum FieldId {
    HeartRate = 0,
    HRZone = 1,
    TargetHR = 2
}

function getFieldValue(index as FieldId, info as Info, workoutStepProvider as CurrentWorkoutStepProvider) as Number? {
    switch(index) {
        case HeartRate:
            return info.currentHeartRate;
        case HRZone:
            return info.currentHeartRate;
        case TargetHR:
            var step = workoutStepProvider.getCurrentWorkoutStep();
            if (step == null) {
                return null;
            }
            if (step.targetType == Activity.WORKOUT_STEP_TARGET_HEART_RATE) {
                return (step.targetValueLow + step.targetValueHigh) / 2;
            }
            return null;

        default:
            throw new Lang.InvalidValueException("Invalid field index");
    }
}

function getFieldName(index as FieldId) as String {
    switch(index) {
        case HeartRate:
            return "Heart Rate";
        case HRZone:
            return "HR zone";
        case TargetHR:
            return "Target HR";
        default:
            throw new Lang.InvalidValueException("Invalid field index");
    }
}