import Toybox.Lang;
import Toybox.Activity;

enum FieldId {
    None = 9999,
    HeartRate = 0,
    HRZone = 1,
    TargetHR = 2,

   // Target = 3,
   // TargetData = 4
}


class Field {
    function initialize(id as FieldId, value as Float?) {
        mId = id;
        mValue = value;
    }

    var mId as FieldId;
    var mValue as Float? = null;
}

function getFieldValue(index as FieldId, info as Info, workoutStepProvider as CurrentWorkoutStepProvider) as Float? {
    switch(index) {
        case HeartRate:
            return info.currentHeartRate;
        case HRZone:
            return getHeartRateZone();
        case TargetHR:
            var step = workoutStepProvider.getCurrentWorkoutStep();
            if (step == null) {
                return null;
            }
            if (step.targetType == Activity.WORKOUT_STEP_TARGET_HEART_RATE) {
                return ((step.targetValueLow + step.targetValueHigh) / 2) as Float;
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