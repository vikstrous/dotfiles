import XMonad  
import XMonad.Hooks.DynamicLog  
import XMonad.Hooks.ManageDocks  
import XMonad.Util.Run  
import System.IO  
import XMonad.Util.EZConfig(additionalKeys)
import Graphics.X11.ExtraTypes

main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig

myBar  = "xmobar"

myPP = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "[" "]" }

toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

modm = mod4Mask

myConfig = defaultConfig   
      { modMask = modm
      , terminal = "urxvt"
      , manageHook = manageDocks <+> manageHook defaultConfig  
      , layoutHook = avoidStruts $ layoutHook defaultConfig  
      , logHook = dynamicLogWithPP xmobarPP  
           { ppTitle = xmobarColor "blue" "" . shorten 50   
           --, ppLayout = const "" -- to disable the layout info on xmobar  
           }   
      } `additionalKeys`
      [ ((0, xF86XK_AudioMute), spawn "amixer -q set Master toggle")
      , ((0, xF86XK_AudioLowerVolume), spawn "amixer -q set Master 3- unmute")
      , ((0, xF86XK_AudioRaiseVolume), spawn "amixer -q set Master 3+ unmute")
      ]
