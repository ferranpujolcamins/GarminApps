import Toybox.Lang;
import Toybox.System;

module Shared_IQ_1_4_0 {
    
    (:DeviceSettings)
    module DeviceSettingsInterfaces {

        typedef DeviceSettingsProvider as interface {
            function activityTrackingOn() as Boolean;
            function alarmCount() as Number;
            function distanceUnits() as UnitsSystem;
            function elevationUnits() as UnitsSystem;
            function firmwareVersion() as Array<Number>;
            function heightUnits() as UnitsSystem;
            function inputButtons() as ButtonInputs;
            function is24Hour() as Boolean;
            function isTouchScreen() as Boolean;
            function monkeyVersion() as Array<Number>;
            function notificationCount() as Number;
            function paceUnits() as UnitsSystem;
            function partNumber() as String;
            function phoneConnected() as Boolean;
            function screenHeight() as Number;
            function screenShape() as ScreenShape;
            function screenWidth() as Number;
            function temperatureUnits() as UnitsSystem;
            function tonesOn() as Boolean;
            function vibrateOn() as Boolean;
            function weightUnits() as UnitsSystem;
        };

        class SystemDeviceSettingsProvider {
            function activityTrackingOn() as Boolean {
                return System.getDeviceSettings().activityTrackingOn;
            }
            
            function alarmCount() as Number {
                return System.getDeviceSettings().alarmCount;
            }
            
            function distanceUnits() as UnitsSystem {
                return System.getDeviceSettings().distanceUnits;
            }
            
            function elevationUnits() as UnitsSystem {
                return System.getDeviceSettings().elevationUnits;
            }
            
            function firmwareVersion() as Array<Number> {
                return System.getDeviceSettings().firmwareVersion;
            }
            
            function heightUnits() as UnitsSystem {
                return System.getDeviceSettings().heightUnits;
            }
            
            function inputButtons() as ButtonInputs {
                return System.getDeviceSettings().inputButtons;
            }
            
            function is24Hour() as Boolean {
                return System.getDeviceSettings().is24Hour;
            }
            
            function isTouchScreen() as Boolean {
                return System.getDeviceSettings().isTouchScreen;
            }
            
            function monkeyVersion() as Array<Number> {
                return System.getDeviceSettings().monkeyVersion;
            }
            
            function notificationCount() as Number {
                return System.getDeviceSettings().notificationCount;
            }
            
            function paceUnits() as UnitsSystem {
                return System.getDeviceSettings().paceUnits;
            }
            
            function partNumber() as String {
                return System.getDeviceSettings().partNumber;
            }
            
            function phoneConnected() as Boolean {
                return System.getDeviceSettings().phoneConnected;
            }
            
            function screenHeight() as Number {
                return System.getDeviceSettings().screenHeight;
            }
            
            function screenShape() as ScreenShape {
                return System.getDeviceSettings().screenShape;
            }
            
            function screenWidth() as Number {
                return System.getDeviceSettings().screenWidth;
            }
            
            function temperatureUnits() as UnitsSystem {
                return System.getDeviceSettings().temperatureUnits;
            }
            
            function tonesOn() as Boolean {
                return System.getDeviceSettings().tonesOn;
            }
            
            function vibrateOn() as Boolean {
                return System.getDeviceSettings().vibrateOn;
            }
            
            function weightUnits() as UnitsSystem {
                return System.getDeviceSettings().weightUnits;
            }
            
        }

        (:debug)
        module UnitTests {
            class MockDeviceSettingsProvider {
               
                function activityTrackingOn() as Boolean {
                    return mActivityTrackingOn;
                }

                function alarmCount() as Number {
                    return mAlarmCount;
                }

                function distanceUnits() as UnitsSystem {
                    return mDistanceUnits;
                }
                
                function elevationUnits() as UnitsSystem {
                    return mElevationUnits;
                }

                function firmwareVersion() as Array<Number> {
                    return mFirmwareVersion;
                }

                function heightUnits() as UnitsSystem {
                    return mHeightUnits;
                }

                function inputButtons() as ButtonInputs {
                    return mInputButtons;
                }

                function is24Hour() as Boolean {
                    return mIs24Hour;
                }

                function isTouchScreen() as Boolean {
                    return mIsTouchScreen;
                }

                function monkeyVersion() as Array<Number> {
                    return mMonkeyVersion;
                }

                function notificationCount() as Number {
                    return mNotificationCount;
                }

                function paceUnits() as UnitsSystem {
                    return mPaceUnits;
                }

                function partNumber() as String {
                    return mPartNumber;
                }

                function phoneConnected() as Boolean {
                    return mPhoneConnected;
                }

                function screenHeight() as Number {
                    return mScreenHeight;
                }

                function screenShape() as ScreenShape {
                    return mScreenShape;
                }

                function screenWidth() as Number {
                    return mScreenWidth;
                }

                function temperatureUnits() as UnitsSystem {
                    return mTemperatureUnits;
                }

                function tonesOn() as Boolean {
                    return mTonesOn;
                }

                function vibrateOn() as Boolean {
                    return mVibrateOn;
                }

                function weightUnits() as UnitsSystem {
                    return mWeightUnits;
                }

                var mActivityTrackingOn as Boolean = true;
                var mAlarmCount as Number = 0;
                var mDistanceUnits as UnitsSystem = System.UNIT_METRIC;
                var mElevationUnits as UnitsSystem = System.UNIT_METRIC;
                var mFirmwareVersion as Array<Number> = System.getDeviceSettings().firmwareVersion;
                var mHeightUnits as UnitsSystem = System.UNIT_METRIC;
                var mInputButtons as ButtonInputs = System.getDeviceSettings().inputButtons;
                var mIs24Hour as Boolean = true;
                var mIsTouchScreen as Boolean = System.getDeviceSettings().isTouchScreen;
                var mMonkeyVersion as Array<Number> = System.getDeviceSettings().monkeyVersion;
                var mNotificationCount as Number = 0;
                var mPaceUnits as UnitsSystem =System.UNIT_METRIC;
                var mPartNumber as String = System.getDeviceSettings().partNumber;
                var mPhoneConnected as Boolean = false;
                var mScreenHeight as Number = System.getDeviceSettings().screenHeight;
                var mScreenShape as ScreenShape = System.getDeviceSettings().screenShape;
                var mScreenWidth as Number = System.getDeviceSettings().screenWidth;
                var mTemperatureUnits as UnitsSystem = System.UNIT_METRIC;
                var mTonesOn as Boolean = true;
                var mVibrateOn as Boolean = true;
                var mWeightUnits as UnitsSystem = System.UNIT_METRIC;
            }
        }
    }
}