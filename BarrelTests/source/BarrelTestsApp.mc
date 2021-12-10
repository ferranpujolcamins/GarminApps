import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class BarrelTestsApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }
    
    function getInitialView() as Array<Views or InputDelegates>? {
        return [ new WatchUi.SimpleDataField() ] as Array<Views or InputDelegates>;
    }

}

function getApp() as BarrelTestsApp {
    return Application.getApp() as BarrelTestsApp;
}