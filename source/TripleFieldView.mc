import Toybox.Lang;
import Toybox.Activity;
import Toybox.Application;
import Toybox.Graphics;
import Toybox.Time;
import Toybox.WatchUi;

class TripleFieldView extends WatchUi.DataField {

    class Model {
        function initialize(
            mainField as Field,
            mainFieldOnShow as Field?,
            field2 as Field,
            field3 as Field
        ) {
            mMainField = mainField;
            mMainFieldOnShow = mainFieldOnShow;
            mField2 = field2;
            mField3 = field3;
        }
        var mMainField as Field;
        var mMainFieldOnShow as Field?;
        var mField2 as Field;
        var mField3 as Field;
    }

    var mModel as Model;
    var mCounter as Counter;

    function initialize() {
        DataField.initialize();
        mModel = new Model(
            new Field(0 as FieldId, null),
            null,
            new Field(0 as FieldId, null),
            new Field(0 as FieldId, null)
        );
        mCounter = new Counter(4);
    }

    function onShow() as Void {
        mCounter = new Counter(4);
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
        var mainFieldId = properties.getValue(MainDataField) as FieldId;
        var mainFieldOnShowId = properties.getValue(MainDataFieldOnShow) as FieldId?;
        var field2Id = properties.getValue(DataField2) as FieldId;
        var field3Id = properties.getValue(DataField3) as FieldId;

        var mainFieldOnShow = null;
        if (mainFieldOnShowId != null && mainFieldOnShowId != None) {
            mainFieldOnShow = new Field(mainFieldOnShowId as FieldId, getFieldValue(mainFieldOnShowId as FieldId, info, currentWorkoutStepProvider));
        }

        var model = new Model(
            new Field(mainFieldId, getFieldValue(mainFieldId, info, currentWorkoutStepProvider)),
            mainFieldOnShow,
            new Field(field2Id, getFieldValue(field2Id, info, currentWorkoutStepProvider)),
            new Field(field3Id, getFieldValue(field3Id, info, currentWorkoutStepProvider))
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

        renderMainField(label, mainValue);
        renderField(mModel.mField2, value2);
        renderField(mModel.mField3, value3);

        // Call parent's onUpdate(dc) to redraw the layout
        View.onUpdate(dc);
    }

    function renderMainField(label as Text, value as Text) as Void {
        var mainFieldOnShowDisplayed = false;
        if(!mCounter.done()) {
            mCounter.tick();
            var mainFieldOnShow = mModel.mMainFieldOnShow;
            if (mainFieldOnShow != null) {
                mainFieldOnShowDisplayed = true;
                label.setText(getFieldName(mainFieldOnShow.mId));
                renderField(mainFieldOnShow, value);
            }
        }
        if (!mainFieldOnShowDisplayed) {
            label.setText(getFieldName(mModel.mMainField.mId));
            renderField(mModel.mMainField, value);
        }
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