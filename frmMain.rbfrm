#tag Window
Begin Window frmMain
   BackColor       =   &hFFFFFF
   Backdrop        =   ""
   CloseButton     =   True
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   246
   ImplicitInstance=   True
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
   Title           =   "TickTockThree"
   Visible         =   True
   Width           =   700
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Dim c1 As New ctrClockUI
		  c1.EmbedWithin Self, 20, 14
		  c1.Label = "SFS"
		  
		  Dim c2 As New ctrClockUI
		  c2.EmbedWithin Self, c1.Left + c1.Width + 12, 14
		  c2.Label = "Multiboard"
		  
		  Dim c3 As New ctrClockUI
		  c3.EmbedWithin Self, c2.Left + c2.Width + 12, 14
		  c3.Label = "HHS"
		  
		End Sub
	#tag EndEvent


#tag EndWindowCode

