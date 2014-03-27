import Control.Monad(liftM2)
import Data.Map(fromList)
import Graphics.X11.ExtraTypes.XF86
import System.IO

import XMonad
import XMonad.Actions.NoBorders
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.StackSet(greedyView,shift)
import XMonad.Actions.PhysicalScreens

xF86XK_AudioMicMute :: KeySym
xF86XK_AudioMicMute = 269025202

myWorkspaces = ["1:web", "2:dev", "3:dev", "4:irc", "5:pdf"] ++ map show [6..9]

myModMask = mod4Mask

myManageHook = composeAll
     [ className =? "Opera" --> viewShift "1:web"
     , manageDocks
     ]
     where viewShift = doF . liftM2 (.) greedyView shift

myFocusedBorderColor = "green"

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmonad/xmobarrc"
    xmonad $ defaultConfig
         { manageHook   = myManageHook <+> manageHook defaultConfig
         , layoutHook   = avoidStruts   $  layoutHook defaultConfig
         , modMask      = myModMask
         , logHook      = dynamicLogWithPP xmobarPP
                              { ppOutput = hPutStrLn xmproc
                              , ppTitle  = xmobarColor "green" "" . shorten 80
                              , ppSep    = " § "
                              , ppCurrent = xmobarColor "black" "green" . pad
                              }
         , terminal     = "urxvtc"
         , workspaces   = myWorkspaces
         , focusedBorderColor = myFocusedBorderColor
         }
         `additionalKeys` (
         [((0, xF86XK_MonBrightnessUp),   spawn "xbacklight -inc 10"),
          ((0, xF86XK_MonBrightnessDown), spawn "xbacklight -dec 10"),
          ((0, xF86XK_AudioLowerVolume),  spawn "amixer set Master 1024-"),
          ((0, xF86XK_AudioRaiseVolume),  spawn "amixer set Master 1024+"),
          ((0, xF86XK_Launch1),           spawn "ssh root halt"),
          ((0, xF86XK_AudioMicMute),      spawn "ssh root ifup wlan0=eduroam"),
          ((myModMask, xK_p),             spawn "dmenu_run -i -p '>' -nb black -nf gray -sb green -sf black"),
          ((myModMask, xK_b),             sendMessage ToggleStruts >> withFocused toggleBorder),

          ((myModMask .|. shiftMask, xK_p), spawn "~/apps/passmenu/passmenu")
          ]
          ++
          [((mod4Mask .|. mask, key), f sc)
           | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
            , (f, mask) <- [(viewScreen, 0), (sendToScreen, shiftMask)]
          ])


