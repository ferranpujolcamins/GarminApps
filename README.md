# Garmin Data Fields
This repository contains the code of several data fields for Garmin devices compatible with ConnectIQ.

### Did you found an error?
If you found a a problem with any of the data fields, or something is not working as you'd expect, please [open a new issue](https://github.com/ferranpujolcamins/GarminDataFields/issues/new/choose).

### Do you need help?
If you have any questions about the data fields, you need help, you want to share a feature idea, or anything else, please [start a discussion](https://github.com/ferranpujolcamins/GarminDataFields/discussions/new).

### Donations
You can use all the data fields for free. However, you can show your appreciation by making a donation. Any amout is very appreciated! Among other things, this helps me get more devices to test my fields on.

<form action="https://www.paypal.com/donate" method="post" target="_top">
<input type="hidden" name="business" value="SNYLYZW7C6NMQ" />
<input type="hidden" name="no_recurring" value="0" />
<input type="hidden" name="item_name" value="I really appreciate your contribution! I'm glad you found my work useful." />
<input type="hidden" name="currency_code" value="EUR" />
<input type="image" src="https://www.paypalobjects.com/en_US/i/btn/btn_donate_SM.gif" border="0" name="submit" title="PayPal - The safer, easier way to pay online!" alt="Donate with PayPal button" />
<img alt="" border="0" src="https://www.paypal.com/en_ES/i/scr/pixel.gif" width="1" height="1" />
</form>

## Fields in this repository
### TargetHr
A data field that displays the current workout step target heart rate, in beats per minute.

When the target is a heart rate zone, the data field displays the heart rate corresponding to the middle of the zone.
For example, if the target is zone 2 and your zone 2 goes from 130 to 150 bpm, the data field will display 140.

When the target is specified as a low and high heart rate limits, the data field displays the average of both values.
For example, if the target is to be between 140 and 180 bpm, the data field will display 160.

When there's no active workout or the current workout step target is not heart rate, the data field displays "--".

### TripleField
A data field that can display three pieces of information.
