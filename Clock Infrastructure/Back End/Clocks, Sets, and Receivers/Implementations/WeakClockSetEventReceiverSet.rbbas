#tag Class
Protected Class WeakClockSetEventReceiverSet
Inherits WeakSetBaseCode
Implements ClockSetEventReceiverSet
	#tag Method, Flags = &h0
		Sub AttachClockSetEventReceiver(cser As ClockSetEventReceiver)
		  // Part of the ClockSetEventReceiverSet interface.
		  
		  If Not Me.HasClockSetEventReceiver( cser ) Then
		    
		    App.Log "WeakClockSetEventReceiverSet<" + Str( p_id ) + ">: attaching ClockSetEventReceiver<" + Str( cser.ObjectID ) + ">."
		    
		    Me.Add cser
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DetachClockSetEventReceiver(cser As ClockSetEventReceiver)
		  // Part of the ClockSetEventReceiverSet interface.
		  
		  If Me.HasClockSetEventReceiver( cser ) Then
		    
		    App.Log "WeakClockSetEventReceiverSet<" + Str( p_id ) + ">: detaching ClockSetEventReceiver<" + Str( cser.ObjectID ) + ">."
		    
		    Me.Remove cser
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasClockSetEventReceiver(cser As ClockSetEventReceiver) As Boolean
		  // Part of the ClockSetEventReceiverSet interface.
		  
		  Return Me.Has( cser )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HoldsStrongReferencesToClockSetEventReceivers() As Boolean
		  // Part of the ClockSetEventReceiverSet interface.
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ListEventReceivers() As ClockSetEventReceiver()
		  Dim result() As ClockSetEventReceiver
		  
		  For Each u As UniqueIDParticipator In Me.List
		    
		    result.Append ClockSetEventReceiver( u )
		    
		  Next
		  
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotifyClockAdded(cset As ClockSet, cdao As Clock)
		  // Part of the ClockSetEventReceiverSet interface.
		  
		  If Not ( cdao Is Nil ) Then
		    For Each er As ClockSetEventReceiver In Me.ListEventReceivers
		      
		      App.Log "WeakClockSetEventReceiverSet<" + Str( p_id ) + ">: notifying ClockSetEventReceiver<" + Str( er.ObjectID ) + "> that Clock<" + Str( cdao.ObjectID ) + "> has been added to a set."
		      
		      er.ClockAdded cset, cdao
		      
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotifyClockRemoved(cset As ClockSet, cdao As Clock)
		  // Part of the ClockSetEventReceiverSet interface.
		  
		  If Not ( cdao Is Nil ) Then
		    For Each er As ClockSetEventReceiver In Me.ListEventReceivers
		      
		      App.Log "WeakClockSetEventReceiverSet<" + Str( p_id ) + ">: notifying ClockSetEventReceiver<" + Str( er.ObjectID ) + "> that Clock<" + Str( cdao.ObjectID ) + "> has been removed from a set."
		      
		      er.ClockRemoved cset, cdao
		      
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotifyClockSetDestroyed(cset As ClockSet)
		  // Part of the ClockSetEventReceiverSet interface.
		  
		  If Not ( cset Is Nil ) Then
		    For Each er As ClockSetEventReceiver In Me.ListEventReceivers
		      
		      App.Log "WeakClockSetEventReceiverSet<" + Str( p_id ) + ">: notifying ClockSetEventReceiver<" + Str( er.ObjectID ) + "> that ClockSet<" + Str( cset.ObjectID ) + "> is being destroyed."
		      
		      er.ClockSetDestroyed cset
		      
		    Next
		  End If
		End Sub
	#tag EndMethod


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
