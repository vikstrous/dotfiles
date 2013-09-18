import XMonad  
import XMonad.Hooks.DynamicLog  
import XMonad.Hooks.ManageDocks  
import XMonad.Util.Run  
import System.IO  
import XMonad.Util.EZConfig(additionalKeys)
import Graphics.X11.ExtraTypes
import XMonad.Layout.Spacing
import XMonad.Layout.Accordion
import XMonad.Layout.BorderResize
import XMonad.Layout.Grid
import XMonad.Layout.AutoMaster
import XMonad.Actions.MouseResize
import XMonad.Layout.WindowArranger

main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig

myLayout = tiled ||| Mirror tiled ||| Mirror (autoMaster 1 (1/100) Grid) ||| Full
       where 
       -- default tiling algorithm partitions the screen into two panes
       tiled = spacing 0 $ Tall nmaster delta ratio 
       -- The default number of windows in the master pane
       nmaster = 1 
       -- Default proportion of screen occupied by master pane
       ratio = 2/3 
       -- Percent of screen to increment by when resizing panes
       delta = 5/100

myBar  = "xmobar"

myPP = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "[" "]" }

toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

modm = mod4Mask

myConfig = defaultConfig
      { modMask = modm
      , layoutHook = myLayout
      , terminal = "urxvt"
      , manageHook = manageDocks <+> manageHook defaultConfig
      --, layoutHook = avoidStruts $ layoutHook defaultConfig
      , logHook = dynamicLogWithPP xmobarPP
           { ppTitle = xmobarColor "blue" "" . shorten 50
           --, ppLayout = const "" -- to disable the layout info on xmobar
           }
      } `additionalKeys`
      [ ((0, xF86XK_AudioMute), spawn "amixer -q set Master toggle")
      , ((0, xF86XK_AudioLowerVolume), spawn "amixer -q set Master 3- unmute")
      , ((0, xF86XK_AudioRaiseVolume), spawn "amixer -q set Master 3+ unmute")
      ]
