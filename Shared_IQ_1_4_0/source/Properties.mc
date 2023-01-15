import Toybox.Lang;
import Toybox.Application;

module Shared_IQ_1_4_0 {

    (:Properties)
    module PropertiesModule {

        // Represents a type that can get and set application properties (i.e. settings).
        typedef Properties as interface {
            function getValue(key as Application.PropertyKeyType) as Application.PropertyValueType;

            function setValue(key as Application.PropertyKeyType, value as Application.PropertyValueType) as Void;
        };

        // A class to get and set application properties (i.e. settings).
        //
        // Can be used with ani API level. Internally it uses the appropriate api depending on the current API level.
        class ApplicationProperties {
            (:typecheck(false)) // TODO
            function getValue(key as Application.PropertyKeyType) as Application.PropertyValueType {
                if (Application has :Properties) {
                    return Application.Properties.getValue(key);
                } else {
                    return Application.getApp().getProperty(key);
                }
            }

            (:typecheck(false)) // TODO
            function setValue(key as Application.PropertyKeyType, value as Application.PropertyValueType) as Void {
                if (Application has :Properties) {
                    Application.Properties.setValue(key, value);
                } else {
                    Application.getApp().setProperty(key, value);
                }
            }
        }

        (:debug)
        module UnitTests {
            
            // A class to mock application properties (i.e. settings).
            class MockProperties {
                function initialize() {
                    mValues = {} as Dictionary<Application.PropertyKeyType, Application.PropertyValueType>;
                }

                function getValue(key as Application.PropertyKeyType) as Application.PropertyValueType {
                    return mValues[key];
                }

                function setValue(key as Application.PropertyKeyType, value as Application.PropertyValueType) as Void {
                    mValues.put(key, value);
                }

                hidden var mValues as Dictionary<Application.PropertyKeyType, Application.PropertyValueType>;
            }
        }

    }

}