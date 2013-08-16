import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import System.IO

-- xmproc <- spawnPipe "/usr/bin/xmobar /home/v/.xmobarrc.hs"
main = xmonad =<< xmobar defaultConfig
    { modMask = mod4Mask -- Use Super instead of Alt
    , terminal = "urxvt"
    , manageHook = manageDocks <+> manageHook defaultConfig
    , layoutHook = avoidStruts  $  layoutHook defaultConfig
    }
