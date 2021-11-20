import Toybox.Lang;
import Toybox.Application;

(:debug)
class ApplicationProperties {
    function initialize() {
        mValues = {} as Dictionary<PropertyKeys, Application.PropertyValueType>;
        mValues[MainDataField] = TargetHR;
        mValues[MainDataFieldOnShow] = None;
        mValues[DataField2] = TargetHRZone;
        mValues[DataField3] = HeartRate;
    }

    function getValue(key as PropertyKeys) as Application.PropertyValueType {
        return mValues[key];
    }

    function setValue(key as PropertyKeys, value as Application.PropertyValueType) as Void {
        mValues.put(key, value);
    }

    hidden var mValues as Dictionary<PropertyKeys, Application.PropertyValueType>;
}