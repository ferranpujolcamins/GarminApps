import Toybox.Lang;
import Toybox.Math;
import Toybox.Test;
import Shared_IQ_1_4_0.Math;

(:test)
function gcdTest(logger as Logger) as Boolean {
    return checkGcd(1, 1, 1, logger)
        && checkGcd(1, 2, 1, logger)
        && checkGcd(2, 2, 2, logger)
        && checkGcd(7, 5, 1, logger)
        && checkGcd(2, 8, 2, logger)
        && checkGcd(36, 30, 6, logger);
}

(:test)
function lcmTest(logger as Logger) as Boolean {
    return checkLcm(1, 1, 1, logger)
        && checkLcm(1, 2, 2, logger)
        && checkLcm(2, 2, 2, logger)
        && checkLcm(7, 5, 35, logger)
        && checkLcm(2, 8, 8, logger)
        && checkLcm(36, 30, 180, logger)
        && checkLcm(6, 10, 30, logger);
}

(:debug)
function checkGcd(a as Number,
                  b as Number,
                  expected as Number,
                  logger as Logger) as Boolean {
    var result = Math.gcd(a, b);
    if (result != expected) {
        logger.debug(Lang.format("FAIL: a = $1$, b = $2$, result = $3$, expected = $4$", [a, b, result, expected]));
        return false;
    }
    return true;
}

(:debug)
function checkLcm(a as Number,
                  b as Number,
                  expected as Number,
                  logger as Logger) as Boolean {
    var result = Math.lcm(a, b);
    if (result != expected) {
        logger.debug(Lang.format("FAIL: a = $1$, b = $2$, result = $3$, expected = $4$", [a, b, result, expected]));
        return false;
    }
    return true;
}