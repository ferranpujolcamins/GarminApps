import Toybox.Lang;
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
                break;
                
            case :LowLimitMenuItem:
                mProperties.setValue(DefaultValue as String, LowLimit);
                break;
            
            case :AverageMenuItem:
                mProperties.setValue(DefaultValue as String, Average);
                break;

            case :HighLimitMenuItem:
                mProperties.setValue(DefaultValue as String, HighLimit);
                break;

            default:
                Assert.that(false);
        }
        WatchUi.popView(SLIDE_BLINK);
    }

    hidden function showHelp() as Void {
        WatchUi.pushView(helpView(), null, SLIDE_LEFT);   
    }

    hidden function helpView() as View {
        var text = Application.loadResource(Rez.Strings.DefaultValueSettingPrompt) as String;
        return new WatchUi.TextArea({
            :text=>text,
        }) as View;
    }

    hidden var mProperties as Properties;
}