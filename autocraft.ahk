;crafter thing by sts.sl
;Lalt+1/2/3 to pick items
;Lalt+L to start
;Lalt+B to exit
#SingleInstance force
#KeyHistory 0
SetKeyDelay, 50
SetDefaultMouseSpeed, 20

;this will be really ugly, i have no idea about arrays in AHK...
global itemNames := Object()
itemNames[1] := "energy restore (large)"
itemNames[2] := "cipher"
itemNames[3] := "shield restore (large)"
global taskList := Object()
taskList[1] := false
taskList[2] := false
taskList[3] := false


;turn item 1,2,3 etc. on/off
<!1::
taskList[1] := !(taskList[1])
listItems()
return

<!2::
taskList[2] := !(taskList[2])
listItems()
return

<!3::
taskList[3] := !(taskList[3])
listItems()
return

;list the items that are to be crafted
listItems()
{
	items:="Items to craft:(" . trutru() . ")`n"
	for i, x in taskList
	{
		if (x)
		{
			items:= items . itemNames[i]
			items := items . ", "
		}
	}
	ToolTip, %items%, 632, 66
	return
}


;i stole these 2
;Timed ToolTip
timedTT(text)
{
	ToolTip, %text% , 280, 30
	SetTimer, RemoveTT, 1750
	return
}

; Removing Tooltip Function
RemoveTT:
{
	ToolTip
	SetTimer, RemoveTT, Off
	return
}

<!b::
ExitApp
return

deleteText()
{
	/*
	Loop 40 
	{
		Send {Backspace}
		sleep 10
	}
	*/
	MouseMove 494, 247
	Sleep 200
	Click, 4
	Sleep 100
	return
}

craft(i)
{
	deleteText()
	MouseClick, left, 364, 249, 4
	Sleep 100
	x := itemNames[i]
	Send %x%
	MouseMove, 440, 300
	Sleep 2000
	Click, 4
	Sleep 2000
	Click, 4
	Sleep 1000
	MouseMove, 798, 580
	Sleep 100
	Click, 4
	return
}



;counts "true" values in taskList
trutru()
{
	x:=0
	for i, j in taskList
	{
		if (j)
		{
			x:=x+1
		}
	}
	return x
}

timedwait()
{
Sleep, (61000-(trutru()-1)*5700)
return
}


craftItems()
{
	while (trutru()=0)
		Sleep 1000
	for i, x in taskList
	{
		if (x)
		{
			craft(i)
			Sleep 500
		}
	}
return
}


<!l::
listItems()
Loop
{
	craftItems()
	timedwait()
}
return

