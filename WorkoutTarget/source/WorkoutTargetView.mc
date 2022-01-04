import Toybox.Activity;
import Toybox.Lang;
import Toybox.Time;
import Toybox.WatchUi;
using Shared_IQ_3_2_0.Workout;

class WorkoutTargetView extends WatchUi.SimpleDataField {

    function initialize() {
        SimpleDataField.initialize();
        // TODO:
        label = "TARGET";//Application.loadResource(Rez.Strings.Label) as String;
    }

    function compute(info as Activity.Info) as Numeric or Duration or String or Null {
        return TargetPaceField.compute(new Workout.ActivityCurrentWorkoutStepProvider(Activity));
    }

}