import Toybox.Lang;
using Shared_IQ_1_4_0.HeartRateZones as Hr;
import Shared_IQ_1_4_0.UserProfileInterfaces;
import Shared_IQ_3_2_0.Workout;

module TargetHrZoneField {
    function compute(workoutStepProvider as CurrentWorkoutStepProvider,
                     userProfileProvider as UserProfileProvider) as String {

        var heartRateZone = tryCompute(workoutStepProvider, userProfileProvider);
        if (heartRateZone == null) {
            return "--";
        } else if (heartRateZone.toNumber().toFloat() == heartRateZone) {
            return heartRateZone.format("%i");
        } else {
            return heartRateZone.format("%.1f");
        }
    }

    function tryCompute(workoutStepProvider as CurrentWorkoutStepProvider,
                     userProfileProvider as UserProfileProvider) as Float? {

        var workoutStep = workoutStepProvider.getCurrentWorkoutStep();
        if (workoutStep == null) { return null; }

        var hrWorkoutTarget = Workout.HrWorkoutTarget.isTargetHr(workoutStep);
        if (hrWorkoutTarget == null) { return null; }

        if (hrWorkoutTarget.isZone()) {
            return hrWorkoutTarget.getZone() as Float;
        } else {
            var bpm = (hrWorkoutTarget.getValueLow() + hrWorkoutTarget.getValueHigh()) / 2;
            return Hr.getHeartRateZone(bpm, userProfileProvider);
        }
    }
}