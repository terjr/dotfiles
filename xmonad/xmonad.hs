import Control.Monad(liftM2)
import Graphics.X11.ExtraTypes.XF86
import System.IO

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.StackSet(greedyView,shift)

myWorkspaces = ["1:web", "2:dev", "3:hck", "4:uni", "5:aud", "6", "7", "8", "9"]

myManageHook = composeAll
    [ className =? "Opera" --> viewShift "1:web"
    , manageDocks
    ]
    where viewShift = doF . liftM2 (.) greedyView shift


main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/terje/.xmonad/xmobarrc"
    xmonad $ defaultConfig
         { manageHook = myManageHook <+> manageHook defaultConfig
         , layoutHook = avoidStruts   $  layoutHook defaultConfig
         , modMask    = mod4Mask
         , logHook    = dynamicLogWithPP xmobarPP
                            { ppOutput = hPutStrLn xmproc
                            , ppTitle  = xmobarColor "green" "" . shorten 80
                            }
         , terminal   = "urxvt"
         , workspaces = myWorkspaces
         }
         `additionalKeys`
         [((0, xF86XK_AudioLowerVolume), spawn "amixer set Master 2-"),
          ((0, xF86XK_AudioRaiseVolume), spawn "amixer set Master 2+")]

