#tag Class
Protected Class WeakClockSet
Inherits WeakSet
Implements ClockSet
	#tag Method, Flags = &h0
		Sub AddClock(c As Clock)
		  // Part of the ClockSet interface.
		  #error  // (don't forget to implement this method!)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AttachClockSetEventReceiver(cser As ClockSetEventReceiver)
		  // Part of the ClockSet interface.
		  #error  // (don't forget to implement this method!)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DetachClockSetEventReceiver(cser As ClockSetEventReceiver)
		  // Part of the ClockSet interface.
		  #error  // (don't forget to implement this method!)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HoldsStrongReferencesToClockObjects() As Boolean
		  // Part of the ClockSet interface.
		  #error  // (don't forget to implement this method!)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HoldsStrongReferencesToClockSetEventReceivers() As Boolean
		  // Part of the ClockSet interface.
		  #error  // (don't forget to implement this method!)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveClock(c As Clock)
		  // Part of the ClockSet interface.
		  #error  // (don't forget to implement this method!)
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected p_clock_objs As Dictionary
	#tag EndProperty


End Class
#tag EndClass
