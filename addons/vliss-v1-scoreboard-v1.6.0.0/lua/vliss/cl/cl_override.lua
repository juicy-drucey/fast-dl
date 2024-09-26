/*
*   @package        : rcore
*   @module         : vliss
*   @author         : Richard [http://steamcommunity.com/profiles/76561198135875727]
*   @copyright      : (c) 2016 - 2020
*   @website        : https://rlib.io
*   @docs           : https://docs.rlib.io
*
*   LICENSOR HEREBY GRANTS LICENSEE PERMISSION TO MODIFY AND/OR CREATE DERIVATIVE WORKS BASED AROUND THE
*   SOFTWARE HEREIN, ALSO, AGREES AND UNDERSTANDS THAT THE LICENSEE DOES NOT HAVE PERMISSION TO SHARE,
*   DISTRIBUTE, PUBLISH, AND/OR SELL THE ORIGINAL SOFTWARE OR ANY DERIVATIVE WORKS. LICENSEE MUST ONLY
*   INSTALL AND USE THE SOFTWARE HEREIN AND/OR ANY DERIVATIVE WORKS ON PLATFORMS THAT ARE OWNED/OPERATED
*   BY ONLY THE LICENSEE.
*
*   YOU MAY REVIEW THE COMPLETE LICENSE FILE PROVIDED AND MARKED AS LICENSE.TXT
*
*   BY MODIFYING THIS FILE -- YOU UNDERSTAND THAT THE ABOVE MENTIONED AUTHORS CANNOT BE HELD RESPONSIBLE
*   FOR ANY ISSUES THAT ARISE FROM MAKING ANY ADJUSTMENTS TO THIS SCRIPT. YOU UNDERSTAND THAT THE ABOVE
*   MENTIONED AUTHOR CAN ALSO NOT BE HELD RESPONSIBLE FOR ANY DAMAGES THAT MAY OCCUR TO YOUR SERVER AS A
*   RESULT OF THIS SCRIPT AND ANY OTHER SCRIPT NOT BEING COMPATIBLE WITH ONE ANOTHER.
*/

GM                          = GM or GAMEMODE

/*
*   standard tables and localization
*/

local base                  = vliss
local cfg                   = base.cfg
local handle                = base.handle
local ln                    = base.lang

/*
*   localize gamemodes
*/

local rp                    = base.rp
local dr                    = base.dr
local sb                    = base.sb
local mu                    = base.mu
local ph                    = base.ph
local zs                    = base.zs
local mb                    = base.mb
local ttt                   = base.ttt

/*
*   convars
*/

local OverrideScoreboard    = CreateClientConVar( 'FAdmin_OverrideScoreboard', 1, true, false)

CreateClientConVar( 'vliss_scoreboardtoggle', 0, true, false )
CreateClientConVar( 'vliss_keyboardtoggle', 0, true, false )
CreateClientConVar( 'vliss_playersort', 1, true, false )

/*
*   initialize
*/

vliss_sb_init = vliss_sb_init or nil

/*
*   RemoveScoreboard
*/

function base:RemoveScoreboard( )
    if not vliss_sb_init then return end
    vliss_sb_init:Remove( )
    vliss_sb_init = nil
end

/*
*   CreateScoreboard
*/

function base:CreateScoreboard( )
    base:RemoveScoreboard( )
    RunConsoleCommand( 'vliss_playersort', '1' )
    vliss_sb_init = vgui.Create( 'vliss_scoreboard' )
end

/*
*   think > toggle > scoreboard
*/

local th_next = 0
local function th_sb_toggle( )
    if GetConVarNumber( 'vliss_scoreboardtoggle' ) ~= 1 then return end
    if th_next > CurTime( ) then return end

    if not input.IsKeyDown( KEY_TAB ) then return end

    if not IsValid( GetScoreboardPanel( ) ) then
        base:CreateScoreboard( )
        return
    end

    GetScoreboardPanel( ):SetVisible(not GetScoreboardPanel( ):IsVisible( ))
    th_next = CurTime( ) + 0.2
end
hook.Add( 'Think', 'ScoreboardToggle', th_sb_toggle )

/*
*   think > toggle > keyboard
*/

local function th_key_toggle( )
    if not vliss_sb_init then return end
    if th_next > CurTime( ) then return end

    if GetConVarNumber( 'vliss_keyboardtoggle' ) == 1 then
        vliss_sb_init:SetKeyboardInputEnabled( true )
    else
        vliss_sb_init:SetKeyboardInputEnabled( false )
    end
end
hook.Add( 'Think', 'KeyboardToggle', th_key_toggle )

/*
*   state > show
*/

local function state_show( )
    if GetConVarNumber( 'vliss_scoreboardtoggle' ) == 1 then return false end
    ShowScoreboard = true

    if not vliss_sb_init or cfg.dev.bDevMode then
        base:CreateScoreboard( )
    end

    gui.EnableScreenClicker( true )
    vliss_sb_init:SetVisible( true )
    vliss_sb_init:UpdateScoreboard( true )
    vliss_sb_init:StartUpdateTimer( )

    return true
end
hook.Add( 'ScoreboardShow', 'DarkRP_Override', state_show )

/*
*   state > hide
*/

local function state_hide( )
    if GetConVarNumber( 'vliss_scoreboardtoggle' ) == 1 then return false end
    ShowScoreboard = false
    gui.EnableScreenClicker( false )

    if vliss_sb_init then
        vliss_sb_init:SetVisible( false )
    end
end
hook.Add( 'ScoreboardHide', 'DarkRP_Override_H', state_hide )

/*
*   GetScoreboardPanel
*/

function GetScoreboardPanel( )
    return vliss_sb_init
end

/*
*   rcc > interface > intiailize
*/

local function cc_initialize( )
    ShowScoreboard = true

    if vliss_sb_init then
        base:RemoveScoreboard( )
    end
    if not vliss_sb_init then
        base:CreateScoreboard( )
    end

    return true
end
concommand.Add( 'vliss_init', cc_initialize )