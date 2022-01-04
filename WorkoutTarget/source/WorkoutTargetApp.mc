import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

import Toybox.Test;
import Shared_IQ_1_4_0;

class WorkoutTargetApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();

        //var logger = new UnitTests.Logger() as Toybox.Test.Logger;
        //var result = testTargetPaceIsAverage(logger);
        //System.println(result);
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        return [ new WorkoutTargetView() ] as Array<Views or InputDelegates>;
    }

}