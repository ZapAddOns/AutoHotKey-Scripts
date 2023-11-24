# AutoHotKey-Scripts
Scripts for AutoHotKey to make the life easier

## Installation
Install AutoHotKey V2.x in your system. If done, double click on the script file you want to start.

## Isodoselines
With this script it is possible to create automatically isodose lines for absolut doses. After retrieving prescription and dose, it is possible to create isodose lines from a absolut dose. The script convert this absolut doses to relative values and insert them into the edit field.

### Usage
The following keys are used by the script:

#### Alt-p: Get the prescription percentage
Go in the dialog "Prescribe" to field "%" and press Alt-p. The script extract the prescription percentage.

#### Alt-d: Get the prescription dose
Go in the dialog "Prescribe" to field "cGy" and press Alt-d. The script extract the prescription dose.

#### Alt-b: Get prescription percentage and dose at the same time
Go in the dialog "Prescribe" to field "%" and press Alt-b. The script extract the prescription percentage and dose.

#### Alt-c: Calculate the right value for field "Dose [%]" from edit field content
Go to the dialog "Plan Settings" and choose the field "Dose [%]". If you enter a floating point value and press Alt-c nothing happens, because you already have a percentage value. If you enter a interger value (dose in cGy, e.g. 300) and press Alt-c, then this dose is converted from the absolut to a relative value with respect to dose and percentage of prescription.

#### Alt-l: Set absolut doses for all the isodose lines in the dialog
If you want to set all your isodose lines to a preset, then you could use Alt-l. For this, you have to add the values you wish to your script. At the beginning is a list of this. There you could say, for which prescribed dose you want which isodose lines. That could be relative (use floating point numbers) or absolut (use integer values in cGy) values. Both is possible. You have to do this normally only once when installing the script.

You have to get first the prescription values as described before (use best Alt-b for this). Then go in "Plan Settings" in the first edit field of column "Dose [%]" and press Alt-l. That's it. All values are set as you decided in the script.

### Demo
You could find a short demo video how it works [here](https://github.com/ZapAddOns/AutoHotKey-Scripts/blob/main/Isodoselines-Demo.mp4).

### Problems
Sometimes it could be, that the App is a little slow when pressing Alt-c. If this is the case, try it again.
