import Toybox.Lang;
using Shared_IQ_1_4_0.HeartRateZones as Hr;
import Shared_IQ_1_4_0.UserProfileInterfaces;
import Shared_IQ_1_4_0.PropertiesModule;
import Shared_IQ_3_2_0.Workout;

class TargetHrZoneField {
    hidden var mWorkoutStepProvider as CurrentWorkoutStepProvider;
    hidden var mUserProfileProvider as UserProfileProvider;
    hidden var mProperties as Properties;

    function initialize(workoutStepProvider as CurrentWorkoutStepProvider,
                        userProfileProvider as UserProfileProvider,
                        properties as Properties) {
                            
        mWorkoutStepProvider = workoutStepProvider;
        mUserProfileProvider = userProfileProvider;
        mProperties = properties;
    }

    function compute() as String {
        var heartRateZone = tryCompute();
        return heartRateZone == null ? "-.-" : heartRateZone;
    }

    function tryCompute() as String? {
        var workoutStep = mWorkoutStepProvider.getCurrentWorkoutStep();
        if (workoutStep == null) { return null; }

        var hrWorkoutTarget = Workout.HrWorkoutTarget.isTargetHr(workoutStep);
        if (hrWorkoutTarget == null) { return null; }

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
}