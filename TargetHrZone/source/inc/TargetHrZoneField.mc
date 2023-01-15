import Toybox.Lang;
using Shared_IQ_1_4_0.HeartRateZones as Hr;
import Shared_IQ_1_4_0.UserProfileInterfaces;
import Shared_IQ_1_4_0.PropertiesModule;
import Shared_IQ_3_2_0.Workout;

class TargetHrZoneField {
    function initialize(workoutStepProvider as CurrentWorkoutStepProvider,
                        userProfileProvider as UserProfileProvider,
                        properties as Properties) {
                            
        mWorkoutStepProvider = workoutStepProvider;
        mUserProfileProvider = userProfileProvider;
        mProperties = properties;
        mLastHrWorkoutTarget = null;
        mFieldText = placeholder();
    }

    function compute() as String {
        var hrWorkoutTarget = null as HrWorkoutTarget?;
        var workoutStep = mWorkoutStepProvider.getCurrentWorkoutStep();
        if (workoutStep == null) {
            hrWorkoutTarget = mLastHrWorkoutTarget;
        } else {
            hrWorkoutTarget = Workout.HrWorkoutTarget.isTargetHr(workoutStep);
        }

        var mFieldText = placeholder();
        if (hrWorkoutTarget != null) {
            var zone = computeHeartRateZone(hrWorkoutTarget);
            if (zone != null) {
                mFieldText = zone;
                if (workoutStep == null) {
                    // Using mLastHrWorkoutTarget
                    mFieldText = "(" + mFieldText + ")";
                }
            }
        }

        mLastHrWorkoutTarget = hrWorkoutTarget;
        return mFieldText;
    }

    hidden function computeHeartRateZone(hrWorkoutTarget as HrWorkoutTarget) as String? {
        if (hrWorkoutTarget.isZone()) {
            return hrWorkoutTarget.getZone().format("%i");
        } else {
            var lowHr = hrWorkoutTarget.getValueLow();
            var highHr = hrWorkoutTarget.getValueHigh();

            var zone = Hr.isHeartRateZone(lowHr, highHr, mUserProfileProvider);
            if (zone != null) {
                return zone.format("%i");
            } else {
                var bpm = getAlternativeValue(lowHr, highHr);
                if (bpm == null) {
                    return null;
                }
                return Hr.getHeartRateZone(bpm, mUserProfileProvider).format("%.1f");
            }
        }
    }

    hidden function getAlternativeValue(lowHr as Number, highHr as Number) as Float? {
        var alternativeValueType = mProperties.getValue(DefaultValue as Number);
        if (alternativeValueType == null) {
            return null;
        }

        switch(alternativeValueType) {
            case LowLimit:
                return lowHr.toFloat();

            case Average:
                return  (lowHr + highHr) / 2.0;

            case HighLimit:
                return highHr.toFloat();

            default:
                return null;
        }
    }

    hidden function placeholder() as String {
        return "-.-";
    }

    hidden var mWorkoutStepProvider as CurrentWorkoutStepProvider;
    hidden var mUserProfileProvider as UserProfileProvider;
    hidden var mProperties as Properties;
    hidden var mLastHrWorkoutTarget as HrWorkoutTarget?;
    hidden var mFieldText as String;
}