import Toybox.Lang;
import Toybox.UserProfile;

module Shared_IQ_1_4_0 {
    
    (:UserProfileInterfaces)
    module UserProfileInterfaces {

        // Represents a type that can get the user profile.
        //
        // Toybox.UserProfile implements this interface and can be used as is wherever an object implementing this interface is needed.
        typedef UserProfileProvider as interface {
            function getHeartRateZones(sport as UserProfile.SportHrZone) as Array<Number>;
            function getProfile() as UserProfile.Profile;
        };

        (:debug)
        module UnitTests {

            // A class to mock the user profile.
            class MockUserProfileProvider {
               
                function getHeartRateZones(sport as UserProfile.SportHrZone) as Array<Number> {
                    return mZones;
                }

                function getProfile() as UserProfile.Profile {
                    return mProfile;
                }

                var mProfile as UserProfile.Profile = new UserProfile.Profile();
                var mZones as Array<Number> = [120, 130, 140, 150, 160, 170] as Array<Number>;
            }
        }
    }
}