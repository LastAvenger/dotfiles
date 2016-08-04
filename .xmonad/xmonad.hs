import System.IO
import Data.List

import XMonad
import XMonad.ManageHook

import XMonad.Layout.NoBorders

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers

import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Cursor

myTerminal = "terminator"

myModMask = mod4Mask

myFocuseFollowsMouse = True
-- Border
myBorderWidth = 2
myNormalBorderColor = "#cccccc"
myFocusedBorderColor = "#00ffff"

myStartupHook = do
    setDefaultCursor xC_left_ptr
    -- Startup script
    -- spawn "~/.xmonad/startup.sh"

myWorkspaces = ["web", "code", "term", "im", "doc", "fm", "ent",  "mail", "misc"]
-- myWorkspaces = zipWith (++) [ show x ++ ":" | x <- [1..9] ++ [0]]
--                          ["web", "code", "term", "im", "doc", "fm", "ent", "mail", "misc"]

appFloat    = ["Dia", "Gimp", "Krita"]
appCenter   = ["feh", "MPlayer", "Zenity", "burp-StartBurp"]
appIgnore   = ["trayer", "dzen"]

appWeb  = ["Firefox", "chromium"]
appCode = ["Gvim", "Atom", "ReText"]
appTerm = ["Terminator"]
appIM   = ["telegram-desktop", "qTox", "Wine", "Srain"]
appMail = ["Thunderbird"]
appFm   = []
appDoc  = ["Wps", "Wpp", "Et", "Okular", "Gimp", "Krita"]
-- TODO
appEnt  = [ "teeworlds"
          , "ddnet"
          , "teeworlds-ddnet"
          , "net-minecraft-bootstrap-Bootstrap"
          , "netease-cloud-music"
          ]
appMisc = ["VirtualBox"]

myManageHook = composeAll . concat $
    [ [isFullscreen   --> doFloat]
    , [className =? a --> doCenterFloat  | a <- appCenter]
    , [className =? a --> doIgnore       | a <- appIgnore]
    , [className =? a --> doShift "web"  | a <- appWeb]
    , [className =? a --> doShift "code" | a <- appCode]
    , [className =? a --> doShift "term" | a <- appTerm]
    , [className =? a --> doShift "im"   | a <- appIM]
    , [className =? a --> doShift "mail" | a <- appMail]
    , [className =? a --> doShift "doc"  | a <- appDoc]
    , [className =? a --> doShift "fm"   | a <- appFm]
    , [className =? a --> doShift "ent"  | a <- appEnt]
    , [className =? a --> doShift "misc" | a <- appMisc]

    , [(isPrefixOf "Minecraft") <$> className --> doShift "ent"]
    ]

myLayoutHook = avoidStruts $ layoutHook defaultConfig

myLogHook xmproc = dynamicLogWithPP $ defaultPP
                    { ppCurrent         = dzenColor "#87ceff" "#1a1a1a" . pad
                    , ppVisible         = dzenColor "#aaaaaa" "#1a1a1a" . pad
                    , ppHidden          = dzenColor "#aaaaaa" "#1a1a1a" . pad
                    , ppHiddenNoWindows = dzenColor "#7b7b7b" "#1a1a1a" . pad
                    , ppUrgent          = dzenColor "#ff0000" "#1a1a1a" . pad
                    , ppWsSep           = " "
                    , ppSep             = "  |  "
                    , ppLayout          = dzenColor "#87ceff" "#1a1a1a" .
                                              ( \x -> case x of
                                                "Tall"            -> "^i(" ++ myBitmapsDir ++ "/tall.xbm)"
                                                "Mirror Tall"     -> "^i(" ++ myBitmapsDir ++ "/mtall.xbm)"
                                                "Full"            -> "^i(" ++ myBitmapsDir ++ "/full.xbm)"
                                                "Simple Float"    -> "~"
                                                _                 -> x
                                              )
                    , ppTitle           = (" " ++) . dzenColor "white" "#1a1a1a" . dzenEscape . shorten 50
                    , ppOutput          = hPutStrLn xmproc
                    }

-- NB: dzen2 DOSEN'T support the option `-wp` and `-wx` (p => percentage),
-- I use a shell wrapper from https://github.com/ervandew/dotfiles/blob/master/bin/dzen2
-- {bg,fg}color and font are also set by this wrapper
--
myBitmapsDir = "/home/la/.xmonad/dzen2"
myDzen2Wrapper = "/home/la/.xmonad/start_dzen2.sh"
myXmonadBar = myDzen2Wrapper ++ " -wp 60 -h 18 -x 0 -y 0 -ta l"
myStatusBar = "conky | " ++ myDzen2Wrapper ++" -xp 60 -wp 30 -h 18 -y 0 -ta r"

main = do
    xmproc <- spawnPipe myXmonadBar
    spawn myStatusBar
    xmonad $ defaultConfig 
        { modMask = myModMask
        , terminal = myTerminal
        , borderWidth = myBorderWidth
        , normalBorderColor = myNormalBorderColor
        , focusedBorderColor = myFocusedBorderColor
        , workspaces = myWorkspaces
        , startupHook = myStartupHook
        , manageHook = myManageHook
        , layoutHook = smartBorders $ myLayoutHook
        , logHook = myLogHook xmproc
        }
        -- key binds? use xbindkeys~
        `additionalKeys` []
