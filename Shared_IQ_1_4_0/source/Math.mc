import Toybox.Lang;
import Toybox.Math;

module Shared_IQ_1_4_0 {

    (:Math)
    module Math {

        // Compute the greatest common divisor of two numbers.
        function gcd(a as Number, b as Number) as Number {
            while (b != 0) {
                var temp = b;
                b = a % b;
                a = temp;
            }
            return a;
        }

        // Compute the least common multiple of two numbers.
        function lcm(a as Number, b as Number) as Number {
            return (a*b).abs() / gcd(a, b);
        }
    }
}