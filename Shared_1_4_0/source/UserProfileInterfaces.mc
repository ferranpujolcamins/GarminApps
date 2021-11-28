import Toybox.Lang;
import Toybox.UserProfile;

module Shared_1_4_0 {
    
    (:UserProfileInterfaces)
    module UserProfileInterfaces {

        typedef UserProfileProvider as interface {
            function getHeartRateZones(sport as UserProfile.SportHrZone) as Array<Number>;
            function getProfile() as UserProfile.Profile;
        };

        (:test)
        module UnitTests {
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