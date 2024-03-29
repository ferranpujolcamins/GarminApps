# Garmin Apps
This repository contains the code of several data fields, watch faces and apps for Garmin devices compatible with ConnectIQ.

### Did you found an error?
If you found a a problem with any of the apps, or something is not working as you'd expect, please [open a new issue](https://github.com/ferranpujolcamins/GarminApps/issues/new/choose).

### Do you need help?
If you have any questions about the apps, you need help, you want to share a feature idea, or anything else, please [start a discussion](https://github.com/ferranpujolcamins/GarminApps/discussions/new).

### Do you want to contribute?
See [Contributing](CONTRIBUTING.md).

### Donations
You can use all the apps for free. However, you can show your appreciation by making a donation. Any amount is very appreciated! Among other things, this helps me get more devices to test my fields on.

[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/donate/?business=SNYLYZW7C6NMQ&no_recurring=0&item_name=I+really+appreciate+your+contribution%21+I%27m+glad+you+found+my+work+useful.&currency_code=EUR)

## Apps in this repository
### TargetHr data field
A data field that displays the current workout step target heart rate, in beats per minute.

[![Download](https://img.shields.io/badge/Download-connect%20IQ-blue)](https://apps.garmin.com/en-US/apps/a686aad7-0747-47e9-b61f-83e44aa7ea3a)

![TargetHr](https://user-images.githubusercontent.com/6429775/143912998-0ba62450-05a0-40c4-a8bb-6bf1055221d7.png)

When the target is a heart rate zone, the data field displays the heart rate corresponding to the middle of the zone.
For example, if the target is zone 2 and your zone 2 goes from 130 to 150 bpm, the data field will display 140.

When the target is specified as a low and high heart rate limits, the data field displays the average of both values.
For example, if the target is to be between 140 and 180 bpm, the data field will display 160.

When there's no active workout or the current workout step target is not heart rate, the data field displays "--".

### TargetHrZone data field
A data field that displays the heart rate zone value corresponding to the current workout target heart rate.

[![Download](https://img.shields.io/badge/Download-connect%20IQ-blue)](https://apps.garmin.com/es-ES/apps/bd6adc81-599a-44be-a483-34b457ef9e1b)

![TargetHrZone](https://user-images.githubusercontent.com/6429775/148199894-f5272cd7-57ba-4c00-85a7-2799a0a18254.png)


A data field that displays the heart rate zone value corresponding to the current workout target heart rate.

When the data field shows no decimal point, it means that the target is to be in one of your heart rate zones.

When the data field does show a decimal point, it means that the target is to be in a heart rate range that does not exactly match one of your heart rate zones.
In this case, the value displayed can be configured in the app settings between the low limit of the heart range, the high limit of the heart rate range or the average of the heart rate range.

Some examples:
- When the workout target is a heart rate zone, the data field displays the heart rate zone with no decimal point. For example, if the target is zone 2, the data field will display "2".

- When the target is specified as a low and high heart rate limits, and those limits match one of your heart rate zones, the data field displays that heart rate zone with no decimal point. For example, if the target is to be between 170 and 190 bpm and that happens to be your zone 5, the data field will display "5".

- When the target is specified as a low and high heart rate limits, and those limits do not match one of your heart rate zones, the data field displays the heart rate zone value corresponding to the average of both values, with a decimal point. For example, if the target is to be between 160 and 180 bpm, and your zone 5 is 170-190 bpm, the data field will display "5.0".

When there's no active workout or the current workout step target is not heart rate, the data field displays "--".

### WorkoutTarget data field (Work in progress)
A data field that displays the current workout step target, no matter what kind of target it is.
