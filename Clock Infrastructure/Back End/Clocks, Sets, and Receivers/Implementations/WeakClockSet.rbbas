#tag Class
Protected Class WeakClockSet
Inherits WeakSetBaseCode
Implements ClockSet
	#tag Method, Flags = &h0
		Sub AddClock(c As Clock)
		  // Part of the ClockSet interface.
		  
		  App.Log "WeakClockSet<" + Str( cvt( Me ).Hash ) + ">: adding Clock<" + Str( c.ObjectID ) + ">."
		  
		  Me.Add c
		  p_autoupdate_obj_pool.NotifyClockAdded Me, c
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AttachClockSetEventReceiver(cser As ClockSetEventReceiver)
		  // Part of the ClockSet interface.
		  
		  App.Log "WeakClockSet<" + Str( cvt( Me ).Hash ) + ">: attaching ClockSetEventReceiver<" + Str( cser.ObjectID ) + ">."
		  
		  p_autoupdate_obj_pool.AttachClockSetEventReceiver cser
		  
		  For Each clk As Clock In Me.ListClocks
		    
		    App.Log "WeakClockSet<" + Str( cvt( Me ).Hash ) + ">: notifying ClockSetEventReceiver<" + Str( cser.ObjectID ) + "> that Clock<" + Str( clk.ObjectID ) + "> exists."
		    
		    cser.ClockAdded Me, clk
		    
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
		Attributes( Hidden = True )  Sub Destructor()
		  App.Log "WeakClockSet<" + Str( p_id ) + ">: deallocating; will remove all remaining clocks from this set now."
		  
		  For Each clk As Clock In ListClocks
		    
		    RemoveClock clk
		    
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DetachClockSetEventReceiver(cser As ClockSetEventReceiver)
		  // Part of the ClockSet interface.
		  
		  App.Log "WeakClockSet<" + Str( cvt( Me ).Hash ) + ">: detaching ClockSetEventReceiver<" + Str( cser.ObjectID ) + ">."
		  
		  p_autoupdate_obj_pool.DetachClockSetEventReceiver cser
		  
		  For Each clk As Clock In Me.ListClocks
		    
		    App.Log "WeakClockSet<" + Str( cvt( Me ).Hash ) + ">: reminding ClockSetEventReceiver<" + Str( cser.ObjectID ) + "> that it should make sure it detaches from Clock<" + Str( clk.ObjectID ) + ">."
		    
		    cser.ClockRemoved Me, clk
		    
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

	#tag Method, Flags = &h0
		Function ListClocks() As Clock()
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
		  
		  App.Log "WeakClockSet<" + Str( cvt( Me ).Hash ) + ">: removing Clock<" + Str( c.ObjectID ) + ">."
		  
		  Me.Remove c
		  p_autoupdate_obj_pool.NotifyClockRemoved Me, c
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected p_autoupdate_obj_pool As ClockSetEventReceiverSet
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
