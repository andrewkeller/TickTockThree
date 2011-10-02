#tag Class
Protected Class WeakClockSet
Inherits WeakSetBaseCode
Implements ClockSet
	#tag Method, Flags = &h0
		Sub AddClock(c As Clock)
		  // Part of the ClockSet interface.
		  
		  Me.Add c
		  p_autoupdate_obj_pool.NotifyClockAdded c
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AttachClockSetEventReceiver(cser As ClockSetEventReceiver)
		  // Part of the ClockSet interface.
		  
		  p_autoupdate_obj_pool.AttachClockSetEventReceiver cser
		  
		  For Each clk As Clock In Me.ListClocks
		    
		    cser.ClockAdded clk
		    
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Attributes( Hidden = True )  Sub Constructor()
		  p_autoupdate_obj_pool = New WeakClockSetEventReceiverSet
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DetachClockSetEventReceiver(cser As ClockSetEventReceiver)
		  // Part of the ClockSet interface.
		  
		  p_autoupdate_obj_pool.DetachClockSetEventReceiver cser
		  
		  For Each clk As Clock In Me.ListClocks
		    
		    cser.ClockRemoved clk
		    
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HoldsStrongReferencesToClockObjects() As Boolean
		  // Part of the ClockSet interface.
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HoldsStrongReferencesToClockSetEventReceivers() As Boolean
		  // Part of the ClockSet interface.
		  
		  Return p_autoupdate_obj_pool.HoldsStrongReferencesToClockSetEventReceivers
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ListClocks() As Clock()
		  Dim result() As Clock
		  
		  For Each u As UniqueIDParticipator In Me.List
		    
		    result.Append Clock( u )
		    
		  Next
		  
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveClock(c As Clock)
		  // Part of the ClockSet interface.
		  
		  Me.Remove c
		  p_autoupdate_obj_pool.NotifyClockRemoved c
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected p_autoupdate_obj_pool As ClockSetEventReceiverSet
	#tag EndProperty


End Class
#tag EndClass
