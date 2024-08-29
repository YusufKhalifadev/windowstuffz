InstallKeybdHook
!Enter:: {
  Run "wt"
}
!w:: {
  Run "thorium"
}
; Close Active window
+!q:: {
  acitve_id := WinGetID("A")
  WinClose acitve_id
}
; sound control
!=::SoundSetVolume("+5")
!-::SoundSetVolume("-5")
!BackSpace::SoundSetMute(-1)

; Switch Capslock with escape
CapsLock::Esc
