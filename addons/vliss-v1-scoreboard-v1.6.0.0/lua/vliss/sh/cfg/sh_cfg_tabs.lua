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

local base                  = vliss
local cfg                   = base.cfg

/*
*   rules
*/

cfg.Menu.TitleRules         = 'Network Rules'

cfg.RulesTextColor          = Color(  255, 255, 255, 255 )
cfg.RulesText =
[[

----DO NOT DO THE FOLLOWING----
[x] No ghosting while in spectator mode or when dead
[x] No racist or sexually abusive comments toward others
[x] No impersonating staff members
[x] No being disrespectful to other players or staff
[x] No threatening to DDoS or take down our network [perm-ban and IP logging]
[x] No asking for other players personal information (IE: home address, phone number)
[x] No blocking doors or denying players access to a part of the map.
[x] No abusing the !unstuck command.
[x] No prop-killing.
[x] No hiding in areas as a prop that hunters cannot access or see.
[x] No mic or chat spamming.

----INFRACTION CONSEQUENCES----
The following actions may be taken in this order [unless violating a more serious offense]:

[-] Player shall be warned about the rule they have broken.
[-] Will be kicked from the server if they continue to break a rule.
[-] A ban will be issued for a term of 3-5 days (depending on what occured)
[-] A permanent ban will be issued and shall not be removed
[-] Bypassing a server ban will result in a GLOBAL BAN from ALL servers within our network including denied access to our website

]]

/*
*   menu > buttons
*
*   these settings configure the Home tab buttons
*/

cfg.Menu.IconsTextEnabled   = true

cfg.Menu.TitleForums        = 'Community Forums'
cfg.Menu.LinkForums         = 'http://gmodstore.com/community'

cfg.Menu.TitleDonate        = 'Donate to our Network!'
cfg.Menu.LinkDonate         = 'https://vliss.rlib.io/internal/demo'

cfg.Menu.TitleWebsite       = 'Welcome to our Official Website!'
cfg.Menu.LinkWebsite        = 'https://vliss.rlib.io/internal/demo'

cfg.Menu.TitleWorkshop      = 'The Official Network Steam Collection'
cfg.Menu.LinkWorkshop       = 'https://steamcommunity.com/sharedfiles/filedetails/?id=2306283801'

/*
*   menu > home tab > buttons
*/

cfg.HomeTab.Buttons =
{
    {
        enabled             = true,
        name                = 'Rules',
        description         = 'What you should know',
        icon                = 'vliss/vliss_btn_rules.png',
        clr_btn_n           = Color( 163, 135, 79, 190 ),
        clr_btn_h           = Color( 163, 135, 79, 240 ),
        clr_txt_n           = Color( 255, 255, 255, 255 ),
        clr_txt_h           = Color( 255, 255, 255, 255 ),
        func                = function( )
                                -- Internal
                                base:OpenExternal( cfg.Menu.TitleRules, cfg.RulesText, true )
                            end
    },
    {
        enabled             = true,
        name                = 'Donate',
        description         = 'Donate to help keep us running',
        icon                = 'vliss/vliss_btn_donate.png',
        clr_btn_n           = Color( 64, 105, 126, 190 ),
        clr_btn_h           = Color( 64, 105, 126, 240 ),
        clr_txt_n           = Color( 255, 255, 255, 255 ),
        clr_txt_h           = Color( 255, 255, 255, 255 ),
        func                = function( )
                                -- Internal
                                base:OpenExternal( cfg.Menu.TitleDonate, cfg.Menu.LinkDonate )

                                -- External
                                -- gui.OpenURL( cfg.Menu.LinkDonate )
                            end
    },
    {
        enabled             = true,
        name                = 'Website',
        description         = 'Visit the official website',
        icon                = 'vliss/vliss_btn_website.png',
        clr_btn_n           = Color( 163, 135, 79, 190 ),
        clr_btn_h           = Color( 163, 135, 79, 240 ),
        clr_txt_n           = Color( 255, 255, 255, 255 ),
        clr_txt_h           = Color( 255, 255, 255, 255 ),
        func                = function( )
                                -- Internal
                                base:OpenExternal( cfg.Menu.TitleWebsite, cfg.Menu.LinkWebsite )

                                -- External
                                -- gui.OpenURL( cfg.Menu.LinkWebsite )
                            end
    },
    {
        enabled             = true,
        name                = 'Steam Workshop',
        description         = 'Download our addons here',
        icon                = 'vliss/vliss_btn_workshop.png',
        clr_btn_n           = Color( 145, 71, 101, 190 ),
        clr_btn_h           = Color( 145, 71, 101, 240 ),
        clr_txt_n           = Color( 255, 255, 255, 255 ),
        clr_txt_h           = Color( 255, 255, 255, 255 ),
        func                = function( )
                                -- Internal
                                base:OpenExternal( cfg.Menu.TitleWorkshop, cfg.Menu.LinkWorkshop )

                                -- External
                                -- gui.OpenURL( cfg.Menu.LinkWorkshop )
                            end
    },
    {
        enabled             = true,
        name                = 'Disconnect',
        description         = 'Disconnect from our server',
        icon                = 'vliss/vliss_btn_disconnect.png',
        clr_btn_n           = Color( 124, 51, 50, 190 ),
        clr_btn_h           = Color( 124, 51, 50, 240 ),
        clr_txt_n           = Color( 255, 255, 255, 255 ),
        clr_txt_h           = Color( 255, 255, 255, 255 ),
        func                = function( )
                                RunConsoleCommand( 'disconnect' )
                            end
    }
}

/*
*   action buttons
*/

cfg.ActionsTab.Buttons =
{
    {
        enabled             = true,
        name                = 'Cleanup Props',
        description         = 'Remove all your props',
        icon                = 'vliss/vliss_btn_cleanup.png',
        clr_btn_n           = Color( 64, 105, 126, 190 ),
        clr_btn_h           = Color( 64, 105, 126, 240 ),
        clr_txt_n           = Color( 255, 255, 255, 255 ),
        clr_txt_h           = Color( 255, 255, 255, 255 ),
        func                = function( )
                                RunConsoleCommand('gmod_cleanup')
                            end
    },
    {
        enabled             = true,
        name                = 'Stop Sound',
        description         = 'Clear local sounds',
        icon                = 'vliss/vliss_btn_stopsound.png',
        clr_btn_n           = Color( 64, 105, 126, 190 ),
        clr_btn_h           = Color( 64, 105, 126, 240 ),
        clr_txt_n           = Color( 255, 255, 255, 255 ),
        clr_txt_h           = Color( 255, 255, 255, 255 ),
        func                = function( )
                                RunConsoleCommand('stopsound')
                            end
    },
    {
        enabled             = true,
        name                = 'Reset Scoreboard',
        description         = 'Re-generate the scoreboard',
        icon                = 'vliss/vliss_btn_refresh.png',
        clr_btn_n           = Color( 64, 105, 126, 190 ),
        clr_btn_h           = Color( 64, 105, 126, 240 ),
        clr_txt_n           = Color( 255, 255, 255, 255 ),
        clr_txt_h           = Color( 255, 255, 255, 255 ),
        func                = function( )
                                RunConsoleCommand('vliss_init')
                            end
    },
}

/*
*   control buttons
*
*   allows you to configure certain quick-action buttons
*   that a player can see in the scoreboard.
*
*   these help players access other features on your server by
*   simply clicking the button.
*
*   you can also execute commands on players by forcing them to
*   run a say command. It's the same as them doing an action.
*
*       @ex : RunConsoleCommand( 'say', '/placelaws' )
*/

cfg.ControlsTab.Buttons =
{
    {
        enabled             = true,
        control             = 'Q',
        description         = 'Context Menu',
        color               = Color( 124, 51, 50, 190 ),
        colorHover          = Color( 124, 51, 50, 240 ),
        func                = function( )
                                RunConsoleCommand( '+menu_context' )

                                if vliss_sb_init then vliss_sb_init:SetVisible( false ) end
                            end
    },
    {
        enabled             = true,
        control             = 'Z',
        description         = 'Undo',
        color               = Color( 163, 135, 79, 190 ),
        colorHover          = Color( 163, 135, 79, 240 ),
        func                = function( )
                                RunConsoleCommand( 'undo' )
                            end
    },
    {
        enabled             = true,
        control             = 'C',
        description         = 'PAC Editor',
        color               = Color( 64, 105, 126, 190 ),
        colorHover          = Color( 64, 105, 126, 240 ),
        func                = function( )
                                RunConsoleCommand( '+menu' )
                            end
    },
    {
        enabled             = true,
        control             = 'F4',
        description         = 'Pointshop',
        color               = Color( 145, 71, 101, 190 ),
        colorHover          = Color( 145, 71, 101, 240 ),
        func                = function( )
                                RunConsoleCommand( '+menu' )
                            end
    }
}
