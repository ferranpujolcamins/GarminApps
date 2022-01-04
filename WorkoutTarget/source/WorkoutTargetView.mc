import Toybox.Activity;
import Toybox.Lang;
import Toybox.Time;
import Toybox.WatchUi;
using Shared_IQ_1_4_0.DeviceSettingsInterfaces;
using Shared_IQ_3_2_0.Workout;

class WorkoutTargetView extends WatchUi.SimpleDataField {

    function initialize() {
        SimpleDataField.initialize();
        // TODO:
        label = "TARGET";//Application.loadResource(Rez.Strings.Label) as String;
        mTargetPaceField = new TargetPaceField(new Workout.ActivityCurrentWorkoutStepProvider(Activity),
                                               new DeviceSettingsInterfaces.SystemDeviceSettingsProvider());
    }

    function compute(info as Activity.Info) as Numeric or Duration or String or Null {
        return mTargetPaceField.compute();
    }

    hidden var mTargetPaceField as TargetPaceField;
}