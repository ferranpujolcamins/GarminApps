import Toybox.Lang;
import Toybox.Application;
import Toybox.Test;
using Shared_IQ_1_4_0.PropertiesModule as PropertiesModule;

(:test)
function testProperties(logger as Logger) as Boolean {
    var properties = new PropertiesModule.ApplicationProperties();

    properties.setValue("Key", 5);
    var value = properties.getValue("Key");
    return value == 5;
}