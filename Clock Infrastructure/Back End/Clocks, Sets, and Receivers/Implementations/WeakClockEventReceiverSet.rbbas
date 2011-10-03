#tag Class
Protected Class WeakClockEventReceiverSet
Inherits WeakSetBaseCode
Implements ClockEventReceiverSet
	#tag Method, Flags = &h0
		Sub AttachClockEventReceiver(cer As ClockEventReceiver)
		  // Part of the ClockEventReceiverSet interface.
		  
		  If Not Me.HasClockEventReceiver( cer ) Then
		    
		    App.Log "WeakClockEventReceiverSet<" + Str( p_id ) + ">: attaching ClockEventReceiver<" + Str( cer.ObjectID ) + ">."
		    
		    Me.Add cer
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DetachClockEventReceiver(cer As ClockEventReceiver)
		  // Part of the ClockEventReceiverSet interface.
		  
		  If Me.HasClockEventReceiver( cer ) Then
		    
		    App.Log "WeakClockEventReceiverSet<" + Str( p_id ) + ">: detaching ClockEventReceiver<" + Str( cer.ObjectID ) + ">."
		    
		    Me.Remove cer
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasClockEventReceiver(cer As ClockEventReceiver) As Boolean
		  // Part of the ClockEventReceiverSet interface.
		  
		  Return Me.Has( cer )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HoldsStrongReferencesToClockEventReceivers() As Boolean
		  // Part of the ClockEventReceiverSet interface.
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ListEventReceivers() As ClockEventReceiver()
		  Dim result() As ClockEventReceiver
		  
		  For Each u As UniqueIDParticipator In Me.List
		    
		    result.Append ClockEventReceiver( u )
		    
		  Next
		  
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotifyClockDisplayNameChanged(cdo As Clock)
		  // Part of the ClockEventReceiverSet interface.
		  
		  If Not ( cdo Is Nil ) Then
		    For Each er As ClockEventReceiver In Me.ListEventReceivers
		      
		      App.Log "WeakClockEventReceiverSet<" + Str( p_id ) + ">: notifying ClockEventReceiver<" + Str( er.ObjectID ) + "> that the display name of Clock<" + Str( cdo.ObjectID ) + "> has changed."
		      
		      er.ClockDisplayNameChanged cdo
		      
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotifyClockStarted(cdo As Clock)
		  // Part of the ClockEventReceiverSet interface.
		  
		  If Not ( cdo Is Nil ) Then
		    For Each er As ClockEventReceiver In Me.ListEventReceivers
		      
		      App.Log "WeakClockEventReceiverSet<" + Str( p_id ) + ">: notifying ClockEventReceiver<" + Str( er.ObjectID ) + "> that Clock<" + Str( cdo.ObjectID ) + "> has started."
		      
		      er.ClockStarted cdo
		      
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotifyClockStopped(cdo As Clock)
		  // Part of the ClockEventReceiverSet interface.
		  
		  If Not ( cdo Is Nil ) Then
		    For Each er As ClockEventReceiver In Me.ListEventReceivers
		      
		      App.Log "WeakClockEventReceiverSet<" + Str( p_id ) + ">: notifying ClockEventReceiver<" + Str( er.ObjectID ) + "> that Clock<" + Str( cdo.ObjectID ) + "> has stopped."
		      
		      er.ClockStopped cdo
		      
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotifyClockValueChanged(cdo As Clock)
		  // Part of the ClockEventReceiverSet interface.
		  
		  If Not ( cdo Is Nil ) Then
		    For Each er As ClockEventReceiver In Me.ListEventReceivers
		      
		      App.Log "WeakClockEventReceiverSet<" + Str( p_id ) + ">: notifying ClockEventReceiver<" + Str( er.ObjectID ) + "> that the value of Clock<" + Str( cdo.ObjectID ) + "> has changed."
		      
		      er.ClockValueChanged cdo
		      
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
