import Toybox.Lang;
import Toybox.Time;

module Shared_IQ_1_4_0 {
    
    (:PollTimer)
    module PollTimerModule {

        // A timer that has to be polled with the 'done()' method.
        class PollTimer {
            hidden var mDuration as Duration;
            hidden var mEndMoment as Moment;

            function initialize(duration as Duration) {
                mDuration = duration;
                mEndMoment = Time.now().add(mDuration);
            }

            function reset() as Void {
                mEndMoment = Time.now().add(mDuration);
            }

            function done() as Boolean {
                return mEndMoment.lessThan(Time.now());
            }
        }
    }
}