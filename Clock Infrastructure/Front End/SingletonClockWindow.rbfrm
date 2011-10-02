#tag Window
Begin Window SingletonClockWindow
   BackColor       =   "#ClockGlobals.kDefaultActiveClockColor"
   Backdrop        =   ""
   CloseButton     =   True
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   1.43e+2
   ImplicitInstance=   False
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   260359578
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   True
   MinWidth        =   64
   Placement       =   0
   Resizeable      =   True
   Title           =   "Singleton Clock Window"
   Visible         =   False
   Width           =   2.4e+2
   Begin ClockButton clkBtn
      AcceptFocus     =   ""
      AcceptTabs      =   True
      AutoDeactivate  =   True
      BackColor       =   &hFFFFFF
      Backdrop        =   ""
      Enabled         =   True
      EraseBackground =   True
      HasBackColor    =   False
      Height          =   121
      HelpTag         =   ""
      InitialParent   =   ""
      Left            =   14
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   8
      UseFocusRing    =   ""
      Visible         =   True
      Width           =   212
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Function CancelClose(appQuitting as Boolean) As Boolean
		  If App.UserWantsToSaveSingletonWindows Then
		    If MsgBox( "This program cannot currently save any changes.  Are you sure you would like to close this window?", 1 + 16 ) = 2 Then
		      
		      Return True
		      
		    End If
		  End If
		  
		  Return False
		End Function
	#tag EndEvent

	#tag Event
		Function ConstructContextualMenu(base as MenuItem, x as Integer, y as Integer) As Boolean
		  Dim m As New MenuItem( "Enable Global Exclusion" )
		  
		  If ParticipatesInGlobalExclusion Then m.Checked = True
		  
		  base.Append m
		End Function
	#tag EndEvent

	#tag Event
		Function ContextualMenuAction(hitItem as MenuItem) As Boolean
		  If hitItem.Text = "Enable Global Exclusion" Then
		    
		    p_enable_global_exclusion = Not hitItem.Checked
		    
		    Return True
		    
		  End If
		End Function
	#tag EndEvent


	#tag MenuHandler
		Function FileClose() As Boolean Handles FileClose.Action
			Self.Close
			Return True
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h0
		Function DisplayName() As String
		  Return clkBtn.DisplayName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DisplayName(Assigns new_value As String)
		  clkBtn.DisplayName = new_value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Sub EnforceGlobalExclusion(base_obj As SingletonClockWindow)
		  If Not ( base_obj Is Nil ) Then
		    
		    If base_obj.ParticipatesInGlobalExclusion Then
		      
		      For idx As Integer = WindowCount -1 DownTo 0
		        
		        Dim w As Window = Window( idx )
		        
		        If w IsA SingletonClockWindow And Not ( w Is base_obj ) Then
		          
		          Dim c As SingletonClockWindow = SingletonClockWindow( w )
		          
		          If c.ParticipatesInGlobalExclusion And c.IsPressed Then
		            
		            c.IsPressed = False
		            
		          End If
		        End If
		      Next
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsPressed() As Boolean
		  Return clkBtn.IsPressed
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsPressed(Assigns new_value As Boolean)
		  clkBtn.IsPressed = new_value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ParticipatesInGlobalExclusion() As Boolean
		  Return p_enable_global_exclusion
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected p_enable_global_exclusion As Boolean = True
	#tag EndProperty


#tag EndWindowCode

#tag Events clkBtn
	#tag Event
		Sub DisplayNameChanged()
		  Self.Title = Trim( Me.DisplayName ) + " Timer"
		End Sub
	#tag EndEvent
	#tag Event
		Sub ClockStarted()
		  Self.HasBackColor = True
		  
		  EnforceGlobalExclusion Self
		End Sub
	#tag EndEvent
	#tag Event
		Sub ClockStopped()
		  Self.HasBackColor = False
		End Sub
	#tag EndEvent
	#tag Event
		Sub UserWantsClockClosed()
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
