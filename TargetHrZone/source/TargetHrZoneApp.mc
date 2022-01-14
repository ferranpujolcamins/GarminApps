import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
using Shared_IQ_1_4_0.PropertiesModule as Props;

class TargetHrZoneApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function onStart(state as Dictionary?) as Void {
    }

    function onStop(state as Dictionary?) as Void {
    }

    function getInitialView() as Array<Views or InputDelegates>? {
        return [ new TargetHrZoneView() ] as Array<Views or InputDelegates>;
    }

    function getSettingsView() as Array<WatchUi.Views or WatchUi.InputDelegates> or Null {
        return [ new Rez.Menus.SettingsMenu(),
                 new SettingsMenuInputDelegate(new Props.ApplicationProperties())
               ] as Array<WatchUi.Views or WatchUi.InputDelegates>;
    }

    function onSettingsChanged() {
        WatchUi.requestUpdate();
    }
}

function getApp() as TargetHrZoneApp {
    return Application.getApp() as TargetHrZoneApp;
}