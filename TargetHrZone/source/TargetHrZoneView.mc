import Toybox.Activity;
import Toybox.Lang;
import Toybox.Time;
import Toybox.WatchUi;
using Shared_IQ_1_4_0.PropertiesModule as Props;
using Shared_IQ_3_2_0.Workout;

class TargetHrZoneView extends WatchUi.SimpleDataField {

    var mField as TargetHrZoneField;

    function initialize() {
        SimpleDataField.initialize();
        label = Application.loadResource(Rez.Strings.Label) as String;
        mField = new TargetHrZoneField(
            new Workout.ActivityCurrentWorkoutStepProvider(Activity),
            UserProfile,
            new Props.ApplicationProperties()
        );
    }

    function compute(info as Activity.Info) as Numeric or Duration or String or Null {
        return mField.compute();
    }
}