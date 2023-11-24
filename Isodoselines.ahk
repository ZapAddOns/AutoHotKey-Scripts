; Script to set isodose lines from cGy
;
; Usage
; Press in the "%" field of Prescribe Alt-p to set the percent
; Press in the "cGy" field of Prescribe Alt-d to set the dose
; If you want to do both together, then go to the "%" field and press Alt-b
; Go to the Plan Settings
; Enter the dose in cGy you want to have in the "Dose [%]" column (only numbers, without any other character, no decimal separator)
; Press Alt-c to calculate the percentage value for given dose
;
; If you want to set all isodoses at one time, use Alt-l. Perhaps you have to set the array isodoseLines below.

#Warn  ; Enable warnings to assist with detecting common errors.
SendMode("Event")  ; Recommended for new scripts due to its superior speed and reliability.

thousendSeparator := ","

dose := 0
prescription := 0.0

isodoseLines := []

; Format: Described dose, 90 % value, 80 % value, 70 % value, 60 % value, 50 % value, 40 % value, 30 % value, 20 % value, 10 % value, 5 % value
; If the value is a float, you set the percantage, if the value is a integer, you set a dose (dose is converted to percentage and then set)
isodoseLines.Push([1200, 0, 2000, 0, 1200, 1000, 800, 600, 400, 300, 0])
isodoseLines.Push([1300, 0, 2000, 0, 1300, 1000, 800, 650, 400, 300, 0])
isodoseLines.Push([2000, 0, 2500, 0, 2000, 1500, 1250, 1000, 500, 300, 0])

!d::
{
	; Get dose
	A_Clipboard := ""
	SetKeyDelay(200)
	Send("^a")
	Send("^c")
	ClipWait
	SetDose(A_Clipboard)
	Return
	}

!p::
{
	; Get percentage
	A_Clipboard := ""
	SetKeyDelay(200)
	Send("^a")
	Send("^c")
	ClipWait
	SetPercentage(A_Clipboard)
	Return
}

!b::
{
	; Get percentage
	A_Clipboard := ""
	SetKeyDelay(200)
	Send("^a")
	Send("^c")
	ClipWait
	SetPercentage(A_Clipboard)
	; Go to next edit control
	Send("{Tab}")
	; Get dose
	A_Clipboard := ""
	Send("^a")
	Send("^c")
	ClipWait
	SetDose(A_Clipboard)
	Return
}

!c::
{
	; Calculate percentage from dose

	; If dose and prescription isn't set, do nothing
	If dose = 0 Or prescription = 0.0
		{
			Return
		}
	
	; Calc percent from given cGy
	SetKeyDelay(300)
	A_Clipboard := ""
	Send("^a")
	Send("^c")
	ClipWait(0.5, false)
	percent := CalcPercent(A_Clipboard)
	SetKeyDelay(20)
	Send(percent)
	SetKeyDelay(200)
	Send("{Tab}")
	Send("+{Tab}")
	Return
}

!v::
{
	; Show values for prescription and dose 
	MsgBox("Prescribed to: " prescription " %`nDose: " dose " cGy", "Plan Settings")
	Return
}

!l::
{
	; If dose and prescription isn't set, do nothing
	If dose = 0 Or prescription = 0.0
	{
		Return
	}

	; Search through all isodoselines
	For isodoselinesForDose in isodoseLines
	{
		; Try to get isodoselines for given dose
		If isodoselinesForDose[1] = dose
		{
			; If this isn't a valid entry
			If isodoselinesForDose.Length != 11
			{
				Return
			}

			; Doses are stored in the array from pos 2 to pos 11
			i := 2

			; Set all 10 possible doses
			While i <= 11
			{
				; If the entry is 0 then change nothing
				If isodoselinesForDose[i] != 0
				{
					; Select whole entry of field
					SetKeyDelay(100)
					Send("^a")

					SetKeyDelay(20)

					If IsInteger(isodoselinesForDose[i])
					{
						; Value is an integer, so calc correct percentage 
						percent := CalcPercent(isodoselinesForDose[i])	
						Send(percent)
					}
					else
					{
						; Value is a float, so output it without changes
						Send(isodoselinesForDose[i])
					}
				}

				SetKeyDelay(200)

				; If it isn't the last line, then go to the next field
				If i < 10
				{
					Send("{Tab 4}")
				}

				i := i + 1
			}
		}
	}
}

;!s::
;{
	; Not ready yet

	; Set plan settings to default
	;Local color

	; Set checkbox for Beams
	;SetCheckbox(607, 410, false)

	; Set checkbox for Contour
	;SetCheckbox(761, 410, false)

	;MouseClick("Left", 943, 553)

	;Send("{Tab}")
	;Send("+{Tab}")
;}

SetDose(value)
{
	Global dose

	value := StrReplace(value , thousendSeparator, "")

	If IsNumber(value)
	{
		dose := value * 1.0
	}

	return
}

SetPercentage(value)
{
	Global prescription

	value := StrReplace(value , thousendSeparator, "")

	If IsNumber(value)
	{
		prescription := value * 1.0
	}

	return
}

CalcPercent(value)
{
	Global dose
	Global prescription

	If IsInteger(value)
	{
		; Value is an integer
		percent := RTrim(RTrim(Round(value * prescription / dose, 5), 0), ".")

		Return percent
	}

	Return value
}

SetCheckbox(x, y, flag)
{
	color := PixelGetColor(x, y)

	If color = "0xFFA500" && flag = false
	{
		MouseClick("Left", x, y)
	}

	If color = "0x808080" && flag = true
	{
		MouseClick("Left", x, y)
	}
}
