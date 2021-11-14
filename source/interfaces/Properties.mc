import Toybox.Lang;
import Toybox.Application;

enum PropertyKeys {
    MainDataField = "MainDataField",
    DataField2 = "DataField2",
    DataField3 = "DataField3"
}

typedef Properties as interface {
    function getValue(key as PropertyKeys) as Application.PropertyValueType;

    function setValue(key as PropertyKeys, value as Application.PropertyValueType) as Void;
};

class ApplicationProperties {
    function getValue(key as PropertyKeys) as Application.PropertyValueType {
        return Application.Properties.getValue(key as String);
    }

    function setValue(key as PropertyKeys, value as Application.PropertyValueType) as Void {
        Application.Properties.setValue(key as String, value);
    }
}

(:test)
module UnitTest {
    class MockProperties {
        function initialize() {
            mValues = {} as Dictionary<PropertyKeys, Application.PropertyValueType>;
        }

        function getValue(key as PropertyKeys) as Application.PropertyValueType {
            return mValues[key];
        }

        function setValue(key as PropertyKeys, value as Application.PropertyValueType) as Void {
            mValues.put(key, value);
        }

        hidden var mValues as Dictionary<PropertyKeys, Application.PropertyValueType>;
    }
}