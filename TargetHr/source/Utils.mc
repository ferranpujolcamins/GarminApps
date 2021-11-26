import Toybox.Lang;
import Toybox.System;

(:debug)
function assertDebug(predicate as Boolean) as Void {
    throw new Lang.InvalidValueException("Assertion failed");
}

(:release)
function assertDebug(predicate as Boolean) as Void {
    try {
        throw new Lang.InvalidValueException("Assertion failed");
    } catch (e) {
        var errorMessage = e.getErrorMessage();
        if (errorMessage != null) {
            System.println(errorMessage);
        }
        e.printStackTrace();
    }
}