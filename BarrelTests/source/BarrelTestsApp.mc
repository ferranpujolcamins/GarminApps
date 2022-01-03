import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Test;
import Shared_IQ_1_4_0;

class BarrelTestsApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();

        var logger = new UnitTests.Logger() as Toybox.Test.Logger;
        //var result = formatTest(logger);
        //System.println(result);
    }
    
    function getInitialView() as Array<Views or InputDelegates>? {
        return [ new WatchUi.SimpleDataField() ] as Array<Views or InputDelegates>;
    }

}

function getApp() as BarrelTestsApp {
    return Application.getApp() as BarrelTestsApp;
}