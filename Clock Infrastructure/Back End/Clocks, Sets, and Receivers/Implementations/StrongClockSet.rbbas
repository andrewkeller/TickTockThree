#tag Class
Protected Class StrongClockSet
Inherits StrongSetBaseCode
Implements ClockSet
	#tag Method, Flags = &h0
		Sub AddClock(c As Clock)
		  // Part of the ClockSet interface.
		  
		  If Not Me.HasClock( c ) Then
		    
		    App.Log "StrongClockSet<" + Str( p_id ) + ">: adding Clock<" + Str( c.ObjectID ) + ">."
		    
		    Me.Add c
		    p_autoupdate_obj_pool.NotifyClockAdded Me, c
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AttachClockSetEventReceiver(cser As ClockSetEventReceiver)
		  // Part of the ClockSet interface.
		  
		  If Not p_autoupdate_obj_pool.HasClockSetEventReceiver( cser ) Then
		    
		    App.Log "StrongClockSet<" + Str( p_id ) + ">: attaching ClockSetEventReceiver<" + Str( cser.ObjectID ) + ">."
		    
		    p_autoupdate_obj_pool.AttachClockSetEventReceiver cser
		    
		    For Each clk As Clock In Me.ListClocks
		      
		      App.Log "StrongClockSet<" + Str( p_id ) + ">: notifying ClockSetEventReceiver<" + Str( cser.ObjectID ) + "> that Clock<" + Str( clk.ObjectID ) + "> exists."
		      
		      cser.ClockAdded Me, clk
		      
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClockCount() As Integer
		  // Part of the ClockSet interface.
		  
		  Return p_strongpool_by_uid.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1000
		Attributes( Hidden = True )  Sub Constructor()
		  p_autoupdate_obj_pool = New WeakClockSetEventReceiverSet
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Sub Destructor()
		  App.Log "StrongClockSet<" + Str( p_id ) + ">: deallocating; will remove all remaining clocks from this set now."
		  
		  For Each clk As Clock In ListClocks
		    
		    RemoveClock clk
		    
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DetachClockSetEventReceiver(cser As ClockSetEventReceiver)
		  // Part of the ClockSet interface.
		  
		  If p_autoupdate_obj_pool.HasClockSetEventReceiver( cser ) Then
		    
		    App.Log "StrongClockSet<" + Str( p_id ) + ">: detaching ClockSetEventReceiver<" + Str( cser.ObjectID ) + ">."
		    
		    p_autoupdate_obj_pool.DetachClockSetEventReceiver cser
		    
		    For Each clk As Clock In Me.ListClocks
		      
		      App.Log "StrongClockSet<" + Str( p_id ) + ">: reminding ClockSetEventReceiver<" + Str( cser.ObjectID ) + "> that it should make sure it detaches from Clock<" + Str( clk.ObjectID ) + ">."
		      
		      cser.ClockRemoved Me, clk
		      
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasClock(c As Clock) As Boolean
		  // Part of the ClockSet interface.
		  
		  Return Me.Has( c )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasClockSetEventReceiver(cser As ClockSetEventReceiver) As Boolean
		  // Part of the ClockSet interface.
		  
		  Return p_autoupdate_obj_pool.HasClockSetEventReceiver( cser )
		End Function
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
		Sub RemoveAllClocks()
		  // Part of the ClockSet interface.
		  
		  App.Log "StrongClockSet<" + Str( p_id ) + ">: removing all Clocks."
		  
		  For Each clk As Clock In Me.ListClocks
		    
		    RemoveClock clk
		    
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveClock(c As Clock)
		  // Part of the ClockSet interface.
		  
		  If Me.HasClock( c ) Then
		    
		    App.Log "StrongClockSet<" + Str( p_id ) + ">: removing Clock<" + Str( c.ObjectID ) + ">."
		    
		    Me.Remove c
		    p_autoupdate_obj_pool.NotifyClockRemoved Me, c
		    
		  End If
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
