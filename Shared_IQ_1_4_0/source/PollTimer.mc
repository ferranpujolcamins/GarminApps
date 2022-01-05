import Toybox.Lang;
import Toybox.Time;

module Shared_IQ_1_4_0 {
    
    (:PollTimer)
    module PollTimerModule {

        // A timer that has to be polled with the 'done()' method.
        //
        // Creating the time with the desired duration starts the timer immediately.
        // Calls to the 'done()' method will return false before the timer expires, and true afterwards.
        class PollTimer {
            hidden var mDuration as Duration;
            hidden var mEndMoment as Moment;

            // Creates and immediately starts a timer with a given duration.
            function initialize(duration as Duration) {
                mDuration = duration;
                mEndMoment = Time.now().add(mDuration);
            }

            // Resets and restarts the timer wiht the same duration it was created with.
            function reset() as Void {
                mEndMoment = Time.now().add(mDuration);
            }

            // Returns false before the timer expires, and true afterwards.
            function done() as Boolean {
                return mEndMoment.lessThan(Time.now());
            }
        }
    }
}