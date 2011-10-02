#tag Class
Protected Class WeakClockEventReceiverSet
Inherits WeakSet
Implements ClockEventReceiverSet
	#tag Method, Flags = &h0
		Sub AttachClockEventReceiver(cer As ClockEventReceiver)
		  // Part of the ClockEventReceiverSet interface.
		  #error  // (don't forget to implement this method!)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DetachClockEventReceiver(cer As ClockEventReceiver)
		  // Part of the ClockEventReceiverSet interface.
		  #error  // (don't forget to implement this method!)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HoldsStrongReferencesToClockEventReceivers() As Boolean
		  // Part of the ClockEventReceiverSet interface.
		  #error  // (don't forget to implement this method!)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotifyClockDisplayNameChanged(cdo As Clock)
		  // Part of the ClockEventReceiverSet interface.
		  #error  // (don't forget to implement this method!)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotifyClockStarted(cdo As Clock)
		  // Part of the ClockEventReceiverSet interface.
		  #error  // (don't forget to implement this method!)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotifyClockStopped(cdo As Clock)
		  // Part of the ClockEventReceiverSet interface.
		  #error  // (don't forget to implement this method!)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotifyClockValueChanged(cdo As Clock)
		  // Part of the ClockEventReceiverSet interface.
		  #error  // (don't forget to implement this method!)
		  
		  
		End Sub
	#tag EndMethod


End Class
#tag EndClass
