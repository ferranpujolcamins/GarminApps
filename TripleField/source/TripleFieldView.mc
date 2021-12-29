import Toybox.Lang;
import Toybox.Activity;
import Toybox.Application;
import Toybox.Graphics;
import Toybox.Time;
import Toybox.WatchUi;
import Shared.PollTimerModule;
import Shared.CurrentWorkoutStepProviderModule;
import Shared.Assert;

class TripleFieldView extends WatchUi.DataField {

    class Model {
        function initialize(
            label as String,
            mainField as String,
            field2 as String,
            field3 as String
        ) {
            mLabel = label;
            mMainField = mainField;
            mField2 = field2;
            mField3 = field3;
        }
        var mLabel as String;
        var mMainField as String;
        var mField2 as String;
        var mField3 as String;
    }

    var mModel as Model;
    var mTimer as PollTimer;
    var mProperties as Properties;

    function initialize() {
        DataField.initialize();
        mModel = new Model(
            "",
            "",
            "",
            ""
        );
        mTimer = new PollTimer(new Time.Duration(4));
        mProperties = new ApplicationProperties();
    }

    function onShow() as Void {
        mTimer.reset();
    }

    enum FieldSize {
        Small,
        Medium,
        Big
    }

    // Set your layout here. Anytime the size of obscurity of
    // the draw context is changed this will be called.
    function onLayout(dc as Dc) as Void {
        // TODO: option to not show label and have more space?

        var obscurityFlags = DataField.getObscurityFlags();

        var fieldHeight = dc.getHeight();
        var fieldSize;
        if (fieldHeight < 60) {
            fieldSize = Small;
        } else if (fieldHeight < 119) {
            fieldSize = Medium;
        } else {
            fieldSize = Big;
        }

        if (obscurityFlags == (OBSCURE_TOP | OBSCURE_LEFT | OBSCURE_RIGHT)) {
            switch (fieldSize) {
                case Small:
                    View.setLayout(Rez.Layouts.TopSmallLayout(dc));
                    break;
                case Medium:
                    View.setLayout(Rez.Layouts.TopLayout(dc));
                    break;
                default:
                    View.setLayout(Rez.Layouts.TopBigLayout(dc));
                    break;
            }
        } else if (obscurityFlags == (OBSCURE_TOP | OBSCURE_LEFT)) {
            View.setLayout(Rez.Layouts.TopLeftLayout(dc));
        } else if (obscurityFlags == (OBSCURE_TOP | OBSCURE_RIGHT)) {
            View.setLayout(Rez.Layouts.TopRightLayout(dc));
        } else if (obscurityFlags == (OBSCURE_BOTTOM | OBSCURE_LEFT | OBSCURE_RIGHT)) {
            switch (fieldSize) {
                case Small:
                    View.setLayout(Rez.Layouts.BottomSmallLayout(dc));
                    break;
                case Medium:
                    View.setLayout(Rez.Layouts.BottomLayout(dc));
                    break;
                default:
                    View.setLayout(Rez.Layouts.BottomBigLayout(dc));
                    break;
            }
        } else if (obscurityFlags == (OBSCURE_BOTTOM | OBSCURE_LEFT)) {
            View.setLayout(Rez.Layouts.BottomLeftLayout(dc));
        } else if (obscurityFlags == (OBSCURE_BOTTOM | OBSCURE_RIGHT)) {
            View.setLayout(Rez.Layouts.BottomRightLayout(dc));
        } else if (obscurityFlags == (OBSCURE_LEFT)) {
            switch (fieldSize) {
                case Small:
                    View.setLayout(Rez.Layouts.LeftSmallLayout(dc));
                    break;
                case Medium:
                    View.setLayout(Rez.Layouts.LeftLayout(dc));
                    break;
                default:
                    View.setLayout(Rez.Layouts.LeftBigLayout(dc));
                    break;
            }
        } else if (obscurityFlags == (OBSCURE_RIGHT)) {
            switch (fieldSize) {
                case Small:
                    View.setLayout(Rez.Layouts.RightSmallLayout(dc));
                    break;
                case Medium:
                    View.setLayout(Rez.Layouts.RightLayout(dc));
                    break;
                default:
                    View.setLayout(Rez.Layouts.RightBigLayout(dc));
                    break;
            }
        } else {
            View.setLayout(Rez.Layouts.SingleFieldLayout(dc));
        }
    }

    // The given info object contains all the current workout information.
    // Calculate a value and save it locally in this method.
    // Note that compute() and onUpdate() are asynchronous, and there is no
    // guarantee that compute() will be called before onUpdate().
    function compute(info as Info) as Void {
        mModel = _compute(
            new FieldValueProvider(
                new ActivityCurrentWorkoutStepProvider(Activity),
                UserProfile,
                info
            ),
            mTimer.done(),
            mProperties
        );
    }

    function _compute(fieldValueProvider as FieldValueProvider,
                      timerDone as Boolean,
                      properties as Properties) as Model {

        var mainFieldId = properties.getValue(MainDataField) as FieldId;
        var mainFieldOnShowId = properties.getValue(MainDataFieldOnShow) as FieldId?;
        var field2Id = properties.getValue(DataField2) as FieldId;
        var field3Id = properties.getValue(DataField3) as FieldId;

        var mainField;
        if (!timerDone && mainFieldOnShowId != null && mainFieldOnShowId != None) {
            mainField = new Field(mainFieldOnShowId, fieldValueProvider.get(mainFieldOnShowId));
        } else {
            mainField = new Field(mainFieldId, fieldValueProvider.get(mainFieldId));
        }
        
        var field2 = new Field(field2Id, fieldValueProvider.get(field2Id));
        var field3 = new Field(field3Id, fieldValueProvider.get(field3Id));

        var model = new Model(
            getFieldName(mainField.mId),
            renderField(mainField),
            renderField(field2),
            renderField(field3)
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

        label.setText(mModel.mLabel);
        mainValue.setText(mModel.mMainField);
        value2.setText(mModel.mField2);
        value3.setText(mModel.mField3);

        // Call parent's onUpdate(dc) to redraw the layout
        View.onUpdate(dc);
    }

    function renderField(field as Field) as String {
        var value = field.mValue;
        if (value == null) {
            return "--";
        }
        switch (field.mId) {
            case HeartRate:
                return formatBPM(value);

            case HRZone:
                return formatZone(value);

            case TargetHR:
                return formatBPM(value);

            case TargetHRZone:
                if (value.toNumber().toFloat() == value) {
                    return formatExactZone(value);
                } else {
                    return formatZone(value);
                }

            case LoTargetHR:
                return formatBPM(value);

            case HiTargetHR:
                return formatBPM(value);

            case LoTargetHRZone:
                return formatZone(value);

            case HiTargetHRZone:
                return formatZone(value);

            default:
                Assert.that(false);
                return "--";
        }
    }

    function formatBPM(value as Float) as String {
        return value.format("%i");
    }

    function formatZone(value as Float) as String {
        return value.format("%.1f");
    }

    function formatExactZone(value as Float) as String {
        return value.format("%i");
    }
}