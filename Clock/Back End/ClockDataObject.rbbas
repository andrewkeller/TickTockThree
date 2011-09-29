#tag Class
Protected Class ClockDataObject
	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Sub Constructor()
		  ReDim p_autoupdate_obj_pool(-1)
		  p_clock = New DurationKFS
		  p_displayname = "Untitled Clock"
		  p_id = NextUniqueInteger
		  
		  App.Log "ClockDataObject<" + Str( p_id ) + "> initializing."
		  
		  RegisterObject Me
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Sub Constructor(other As ClockDataObject)
		  ReDim p_autoupdate_obj_pool(-1)
		  Dim other_id_str As String
		  
		  If other Is Nil Then
		    
		    p_clock = New DurationKFS
		    p_displayname = "Untitled Clock"
		    other_id_str = "Nil"
		    
		  Else
		    
		    p_clock = New DurationKFS( other.p_clock, True )
		    p_displayname = other.p_displayname
		    other_id_str = Str( other.p_id )
		    
		  End If
		  
		  p_id = NextUniqueInteger
		  
		  App.Log "ClockDataObject<" + Str( p_id ) + "> initializing as a clone of ClockDataObject<" + Str( other.p_id ) + ">."
		  
		  RegisterObject Me
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Sub Destructor()
		  App.Log "ClockDataObject<" + Str( p_id ) + "> deallocating."
		  
		  UnregisterObject Me
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DisplayName() As String
		  Return p_displayname
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DisplayName(Assigns new_value As String)
		  App.Log "ClockDataObject<" + Str( p_id ) + "> changing display name to '" + new_value + "'."
		  
		  p_displayname = new_value
		  
		  For Each t As ClockEventReceiver In p_autoupdate_obj_pool
		    t.ClockMessageChanged Me
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function GetObjectByID(id As Int64) As ClockDataObject
		  If Not ( p_cdao_pool Is Nil ) Then
		    
		    Dim v As Variant = p_cdao_pool.Lookup( id, Nil )
		    
		    If v IsA WeakRef Then
		      
		      v = WeakRef( v ).Value
		      
		      If v IsA ClockDataObject Then
		        
		        Return v
		        
		      End If
		    End If
		  End If
		  
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsRunning() As Boolean
		  Return p_clock.IsRunning
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsRunning(Assigns new_value As Boolean)
		  If p_clock.IsRunning <> new_value Then
		    
		    p_clock.IsRunning = new_value
		    
		    If new_value Then
		      
		      App.Log "ClockDataObject<" + Str( p_id ) + "> changing state to name to running."
		      
		      For Each t As ClockEventReceiver In p_autoupdate_obj_pool
		        
		        App.Log "ClockDataObject<" + Str( p_id ) + "> notifying ClockEventReceiver<" + Str( cvt(t).Hash ) + "> that the state has changed to running."
		        
		        t.ClockStarted Me
		        
		      Next
		      
		    Else
		      
		      App.Log "ClockDataObject<" + Str( p_id ) + "> changing state to name to stopped."
		      
		      For Each t As ClockEventReceiver In p_autoupdate_obj_pool
		        
		        App.Log "ClockDataObject<" + Str( p_id ) + "> notifying ClockEventReceiver<" + Str( cvt(t).Hash ) + "> that the state has changed to stopped."
		        
		        t.ClockStopped Me
		        
		      Next
		      
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function NextUniqueInteger() As Int64
		  Static counter As Int64 = 0
		  
		  counter = counter + 1
		  
		  Return counter
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ObjectID() As Int64
		  Return p_id
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RegisterForClockObjectUpdates(target As ClockEventReceiver)
		  If Not ( target Is Nil ) Then
		    
		    p_autoupdate_obj_pool.Append target
		    
		    App.Log "ClockDataObject<" + Str( p_id ) + "> registering ClockEventReceiver<" + Str( cvt(target).Hash ) + ">."
		    
		    target.ClockMessageChanged Me
		    target.ClockValueChanged Me
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Sub RegisterForClockSetUpdates(target As ClockSetEventReceiver)
		  If Not ( target Is Nil ) Then
		    
		    App.Log "Global ClockDataObject pool regestering ClockSetEventReceiver<" + Str( cvt(target).Hash ) + ">."
		    
		    p_autoupdate_set_pool.Append target
		    
		    For Each v As Variant In p_cdao_pool.Values
		      
		      Try
		        
		        target.ClockCreated ClockDataObject( WeakRef( v ).Value )
		        
		      Catch err As RuntimeException
		        ReRaiseRBFrameworkExceptionsKFS err
		        
		        MsgBox "Uh oh...  While pushing all new clocks to a clock sum window, an exception of type "+Introspection.GetType(err).Name+" was encountered:" _
		        + EndOfLine + EndOfLine + err.Message + " (error code " + Str( err.ErrorNumber ) + ")"
		        
		        App.Log "While notifying ClockSetEventReceiver<" + Str( cvt(target).Hash ) + "> of all data for the first time, an exception of type " + Introspection.GetType(err).Name + " was encountered: " + err.Message + " (error code " + Str( err.ErrorNumber ) + ")"
		        
		      End Try
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Sub RegisterObject(cdao As ClockDataObject)
		  If Not ( cdao Is Nil ) Then
		    
		    App.Log "Global ClockDataObject pool regestering ClockDataObject<" + Str( cdao.ObjectID ) + ">."
		    
		    If p_cdao_pool Is Nil Then p_cdao_pool = New Dictionary
		    
		    p_cdao_pool.Value( cdao.p_id ) = New WeakRef( cdao )
		    
		    For Each t As ClockSetEventReceiver In p_autoupdate_set_pool
		      
		      App.Log "Global ClockDataObject pool notifying ClockSetEventReceiver<" + Str( cvt(t).Hash ) + "> that ClockDataObject<" + Str( cdao.ObjectID ) + "> is now a member of the set."
		      
		      t.ClockCreated cdao
		      
		    Next
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Start()
		  App.Log "ClockDataObject<" + Str( p_id ) + "> changing state to name to running."
		  
		  p_clock.Start
		  
		  For Each t As ClockEventReceiver In p_autoupdate_obj_pool
		    
		    App.Log "ClockDataObject<" + Str( p_id ) + "> notifying ClockEventReceiver<" + Str( cvt(t).Hash ) + "> that the state has changed to running."
		    
		    t.ClockStarted Me
		    
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Stop()
		  App.Log "ClockDataObject<" + Str( p_id ) + "> changing state to name to stopped."
		  
		  p_clock.Stop
		  
		  For Each t As ClockEventReceiver In p_autoupdate_obj_pool
		    
		    App.Log "ClockDataObject<" + Str( p_id ) + "> notifying ClockEventReceiver<" + Str( cvt(t).Hash ) + "> that the state has changed to stopped."
		    
		    t.ClockStopped Me
		    
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UnregisterForClockObjectUpdates(target As ClockEventReceiver)
		  If Not ( target Is Nil ) Then
		    
		    App.Log "ClockDataObjec<" + Str( p_id ) + "> unregistering ClockEventReceiver<" + Str( cvt(target).Hash ) + ">."
		    
		    For idx As Integer = UBound( p_autoupdate_obj_pool ) DownTo 0
		      
		      If p_autoupdate_obj_pool(idx) Is Nil Or p_autoupdate_obj_pool(idx) Is target Then p_autoupdate_obj_pool.Remove idx
		      
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Sub UnregisterForClockSetUpdates(target As ClockSetEventReceiver)
		  If Not ( target Is Nil ) Then
		    
		    App.Log "Global ClockDataObject pool unregestering ClockSetEventReceiver<" + Str( cvt(target).Hash ) + ">."
		    
		    For idx As Integer = UBound( p_autoupdate_set_pool ) DownTo 0
		      
		      If p_autoupdate_set_pool(idx) Is Nil Or p_autoupdate_set_pool(idx) Is target Then p_autoupdate_set_pool.Remove idx
		      
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Sub UnregisterObject(cdao As ClockDataObject)
		  If Not ( cdao Is Nil ) Then
		    
		    App.Log "Global ClockDataObject pool unregestering ClockDataObject<" + Str( cdao.ObjectID ) + ">."
		    
		    If Not ( p_cdao_pool Is Nil ) Then
		      
		      p_cdao_pool.Remove cdao.p_id
		      
		    End If
		    
		    For Each t As ClockSetEventReceiver In p_autoupdate_set_pool
		      
		      App.Log "Global ClockDataObject pool notifying ClockSetEventReceiver<" + Str( cvt(t).Hash ) + "> that ClockDataObject<" + Str( cdao.ObjectID ) + "> is no longer registered."
		      
		      t.ClockDestroyed cdao
		      
		    Next
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value() As DurationKFS
		  Return New DurationKFS( p_clock, True )
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected p_autoupdate_obj_pool() As ClockEventReceiver
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected Shared p_autoupdate_set_pool() As ClockSetEventReceiver
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected Shared p_cdao_pool As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_clock As DurationKFS
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_displayname As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_id As Int64
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
