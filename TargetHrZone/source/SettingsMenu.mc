import Toybox.Lang;
import Toybox.Graphics;
import Toybox.System;
import Toybox.WatchUi;
import Shared_IQ_1_4_0.Assert;
import Shared_IQ_1_4_0.PropertiesModule;

class SettingsMenuInputDelegate extends WatchUi.Menu2InputDelegate {
    function initialize(properties as Properties) {
        Menu2InputDelegate.initialize();
        mProperties = properties;
    }

    function onSelect(item) {
        var itemId = item.getId() as Symbol;
        switch(itemId) {
            case :HelpMenuItem:
                showHelp();
                return;
                
            case :LowLimitMenuItem:
                mProperties.setValue(:DefaultValue as String, LowLimit);
                break;
            
            case :AverageMenuItem:
                mProperties.setValue(:DefaultValue as String, Average);
                break;

            case :HighLimitMenuItem:
                mProperties.setValue(:DefaultValue as String, HighLimit);
                break;

            default:
                Assert.that(false);
        }
        WatchUi.popView(SLIDE_BLINK);
    }

    hidden function showHelp() as Void {
        WatchUi.pushView(new SettingsHelpView(), null, SLIDE_LEFT);   
    }

    hidden var mProperties as Properties;
}

class SettingsHelpView extends WatchUi.View {
    public function initialize() {
        View.initialize();
    }

    public function onLayout(dc as Dc) as Void {
        setLayout( Rez.Layouts.SettingsHelpLayout(dc) );
    }

    public function onUpdate(dc as Dc) as Void {
        View.onUpdate(dc);
    }
}