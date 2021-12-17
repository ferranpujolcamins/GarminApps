import Toybox.Lang;
using Shared_IQ_1_4_0.HeartRateZones as Hr;
import Shared_IQ_1_4_0.UserProfileInterfaces;
import Shared_IQ_3_2_0.Workout;

module TargetHrField {
    function compute(workoutStepProvider as CurrentWorkoutStepProvider,
                     userProfileProvider as UserProfileProvider) as String {

        var heartRate = tryCompute(workoutStepProvider, userProfileProvider);
        return heartRate == null ? "--" : heartRate.format("%i");
    }

    function tryCompute(workoutStepProvider as CurrentWorkoutStepProvider,
                     userProfileProvider as UserProfileProvider) as Number? {

        var workoutStep = workoutStepProvider.getCurrentWorkoutStep();
        if (workoutStep == null) { return null; }

        var hrWorkoutTarget = Workout.HrWorkoutTarget.isTargetHr(workoutStep);
        if (hrWorkoutTarget == null) { return null; }

        if (hrWorkoutTarget.isZone()) {
            var zone = hrWorkoutTarget.getZone().toFloat();
            var lowHr = Hr.getHeartRate(zone, userProfileProvider);
            var hiHr = Hr.getHeartRate(zone + 1, userProfileProvider);
            if (lowHr == null || hiHr == null) {
                return null;
            }
            return (lowHr + hiHr) / 2;
        } else {
            return (hrWorkoutTarget.getValueLow() + hrWorkoutTarget.getValueHigh()) / 2;
        }
    }
}
