import Toybox.Lang;
import Toybox.Activity;
import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

class TripleFieldView extends WatchUi.DataField {

    class Model {
        function initialize(
            label as String,
            mainFieldValue as Numeric?,
            field2Value as Numeric?,
            field3Value as Numeric?
        ) {
            mLabelText = label;
            mMainFieldValue = mainFieldValue;
            mField2Value = field2Value;
            mField3Value = field3Value;
        }
        var mLabelText as String;
        var mMainFieldValue as Numeric? = null;
        var mField2Value as Numeric? = null;
        var mField3Value as Numeric? = null;
    }

    var mModel as Model;

    function initialize() {
        DataField.initialize();
        mModel = new Model(
            "",
            null,
            null,
            null
        );
    }

    // Set your layout here. Anytime the size of obscurity of
    // the draw context is changed this will be called.
    function onLayout(dc as Dc) as Void {
        var obscurityFlags = DataField.getObscurityFlags();

        if (obscurityFlags == (OBSCURE_TOP | OBSCURE_LEFT | OBSCURE_RIGHT)) {
            View.setLayout(Rez.Layouts.TopLayout(dc));
        } else if (obscurityFlags == (OBSCURE_TOP | OBSCURE_LEFT)) {
            View.setLayout(Rez.Layouts.TopLeftLayout(dc));
        } else if (obscurityFlags == (OBSCURE_TOP | OBSCURE_RIGHT)) {
            View.setLayout(Rez.Layouts.TopRightLayout(dc));
        } else if (obscurityFlags == (OBSCURE_BOTTOM | OBSCURE_LEFT)) {
            View.setLayout(Rez.Layouts.BottomLeftLayout(dc));
        } else if (obscurityFlags == (OBSCURE_BOTTOM | OBSCURE_RIGHT)) {
            View.setLayout(Rez.Layouts.BottomRightLayout(dc));
        } else {
            View.setLayout(Rez.Layouts.MainLayout(dc));
        }
    }

    // The given info object contains all the current workout information.
    // Calculate a value and save it locally in this method.
    // Note that compute() and onUpdate() are asynchronous, and there is no
    // guarantee that compute() will be called before onUpdate().
    function compute(info as Info) as Void {
        mModel = _compute(new ActivityCurrentWorkoutStepProvider(Activity), info, new ApplicationProperties());
    }

    function _compute(currentWorkoutStepProvider as CurrentWorkoutStepProvider, info as Info, properties as Properties) as Model {
        var mainField = properties.getValue(MainDataField);
        var field2 = properties.getValue(DataField2);
        var field3 = properties.getValue(DataField3);
        var model = new Model(
            getFieldName(mainField as FieldId),
            getFieldValue(mainField as FieldId, info, currentWorkoutStepProvider),
            getFieldValue(field2 as FieldId, info, currentWorkoutStepProvider),
            getFieldValue(field3 as FieldId, info, currentWorkoutStepProvider)
        );
        return model;
    }

    // Display the value you computed here. This will be called
    // once a second when the data field is visible.
    function onUpdate(dc as Dc) as Void {
        (View.findDrawableById("Background") as Text).setColor(getBackgroundColor());

        var label = View.findDrawableById("label") as Text;
        var mainValue = View.findDrawableById("value1") as Text;
        var value2 = View.findDrawableById("value2") as Text;
        var value3 = View.findDrawableById("value3") as Text;

        if (getBackgroundColor() == Graphics.COLOR_BLACK) {
            mainValue.setColor(Graphics.COLOR_WHITE);
            value2.setColor(Graphics.COLOR_WHITE);
            value3.setColor(Graphics.COLOR_WHITE);
        } else {
            mainValue.setColor(Graphics.COLOR_BLACK);
            value2.setColor(Graphics.COLOR_BLACK);
            value3.setColor(Graphics.COLOR_BLACK);
        }



        label.setText(mModel.mLabelText);
        mainValue.setText(asText(mModel.mMainFieldValue));
        value2.setText(asText(mModel.mField2Value));
        value3.setText(asText(mModel.mField3Value));

        // Call parent's onUpdate(dc) to redraw the layout
        View.onUpdate(dc);
    }

    function asText(value as Number?) as String {
        if (value != null) {
            return value.format("%.2f");
        }
        return "--";
    }
}