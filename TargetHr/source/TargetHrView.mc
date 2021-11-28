import Toybox.Activity;
import Toybox.Lang;
import Toybox.Time;
import Toybox.WatchUi;
using Shared_3_2_0.Workout;
using TargetHrField as Field;

class TargetHrView extends WatchUi.SimpleDataField {

    function initialize() {
        SimpleDataField.initialize();
        label = Application.loadResource(Rez.Strings.Label) as String;
    }

    function compute(info as Activity.Info) as Numeric or Duration or String or Null {
        return Field.compute(new Workout.ActivityCurrentWorkoutStepProvider(Activity),
                             UserProfile);
    }

}