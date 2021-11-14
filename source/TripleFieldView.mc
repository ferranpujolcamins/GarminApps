import Toybox.Lang;
import Toybox.Activity;
import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

class TripleFieldView extends WatchUi.DataField {

    class Field {
        function initialize(id as FieldId, value as Float?) {
            mId = id;
            mValue = value;
        }

        var mId as FieldId;
        var mValue as Float? = null;
    }

    class Model {
        function initialize(
            mainField as Field,
            field2 as Field,
            field3 as Field
        ) {
            mMainField = mainField;
            mField2 = field2;
            mField3 = field3;
        }
        var mMainField as Field;
        var mField2 as Field;
        var mField3 as Field;
    }

    var mModel as Model;

    function initialize() {
        DataField.initialize();
        mModel = new Model(
            new Field(0 as FieldId, null),
            new Field(0 as FieldId, null),
            new Field(0 as FieldId, null)
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
            new Field(mainField as FieldId, getFieldValue(mainField as FieldId, info, currentWorkoutStepProvider)),
            new Field(field2 as FieldId, getFieldValue(field2 as FieldId, info, currentWorkoutStepProvider)),
            new Field(field3 as FieldId, getFieldValue(field3 as FieldId, info, currentWorkoutStepProvider))
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
            label.setColor(Graphics.COLOR_WHITE);
            mainValue.setColor(Graphics.COLOR_WHITE);
            value2.setColor(Graphics.COLOR_WHITE);
            value3.setColor(Graphics.COLOR_WHITE);
        } else {
            label.setColor(Graphics.COLOR_BLACK);
            mainValue.setColor(Graphics.COLOR_BLACK);
            value2.setColor(Graphics.COLOR_BLACK);
            value3.setColor(Graphics.COLOR_BLACK);
        }

        label.setText(getFieldName(mModel.mMainField.mId));
        renderField(mModel.mMainField, mainValue);
        renderField(mModel.mField2, value2);
        renderField(mModel.mField3, value3);

        // Call parent's onUpdate(dc) to redraw the layout
        View.onUpdate(dc);
    }

    function renderField(field as Field, label as Text) as Void {
        var text;
        switch (field.mId) {
            case HeartRate:
                text = formatBPM(field.mValue);
                break;
            case HRZone:
                text = formatZone(field.mValue);
                break;
            case TargetHR:
                text = formatBPM(field.mValue);
                break;
        }
        label.setText(text);
    }

    function formatBPM(value as Float?) as String {
        if (value != null) {
            return value.format("%i");
        }
        return "--";
    }

    function formatZone(value as Float?) as String {
        if (value != null) {
            return value.format("%.1f");
        }
        return "--";
    }
}