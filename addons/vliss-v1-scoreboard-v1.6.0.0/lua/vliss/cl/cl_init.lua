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
*   netlib :: sms :: umsg
*
*   sends a message directly to the ply chat
*/

local function netlib_sms_umsg( len, pl )
    local msg       = net.ReadTable( )
                    if not msg then return end

    chat.AddText( unpack( msg ) )
end
net.Receive( 'vliss.sms.umsg', netlib_sms_umsg )

/*
*   blur
*/

local blur = Material( 'pp/blurscreen' )
function DrawBlurPanel( pnl, amt, heavyness )
    local x, y = pnl:LocalToScreen(0, 0)
    local scrW, scrH = ScrW( ), ScrH( )

    surface.SetDrawColor    ( 255, 255, 255 )
    surface.SetMaterial     ( blur )

    for i = 1, ( heavyness or 3 ) do
        blur:SetFloat( '$blur', ( i / 3 ) * ( amt or 6 ) )
        blur:Recompute( )

        render.UpdateScreenEffectTexture( )
        surface.DrawTexturedRect( x * -1, y * -1, scrW, scrH )
    end
end

/*
*   VlissBox
*/

function draw.VlissBox( x, y, w, h, col )
    surface.SetDrawColor(col)
    surface.DrawRect(x, y, w, h)
end

/*
*   VlissOutlinedBox
*/

function draw.VlissOutlinedBox(x, y, w, h, col, bordercol)
    surface.SetDrawColor(col)
    surface.DrawRect(x + 1, y + 1, w - 2, h - 2)
    surface.SetDrawColor(bordercol)
    surface.DrawOutlinedRect(x, y, w, h)
end

/*
*   VlissOutlinedBoxThick
*/

function draw.VlissOutlinedBoxThick( x, y, w, h, borderthick, clr )
    surface.SetDrawColor( clr )
    for i = 0, borderthick - 1 do
        surface.DrawOutlinedRect( x + i, y + i, w - i * 2, h - i * 2 )
    end
end

/*
*   VlissBoxEffects
*/

function draw.VlissBoxEffects(w, h)
    surface.SetDrawColor    ( cfg.general.clrs.btn_line )
    surface.DrawLine        ( 0, cfg.general.size_btn_line, 0, 0 )
    surface.DrawLine        ( cfg.general.size_btn_line, 0, 0, 0 )
    surface.SetDrawColor    ( cfg.general.clrs.btn_line )
    surface.DrawLine        ( w - cfg.general.size_btn_line, h - 1, w, h - 1 )
    surface.DrawLine        ( w - 1, h, w - 1, h - cfg.general.size_btn_line )
end

/*
*   DoFormatNumber
*/

function math.DoFormatNumber( number, seperator )
    number          = tonumber( number )
                    if not number then return 0 end
                    if number >= 1e14 then return tostring( number ) end

    number          = tostring( number )
    seperator       = seperator or ','

    local pointplace = string.find(number, '%.') or #number + 1
    for i = pointplace - 4, 1, -3 do
        number = number:sub( 1, i ) .. seperator .. number:sub( i + 1 )
    end

    return vliss.DarkRP.Currency .. ' ' .. number
end

/*
*   on_reload
*/

local function on_reload( )
    include('vliss/cl/cl_override.lua')
end
hook.Add( 'OnReloaded', 'vlissLoader', on_reload )

/*
*   on_gmload
*/

local function on_gmload( )
    timer.Simple( 3, function( )
        include( 'vliss/cl/cl_override.lua' )
    end )
end
hook.Add( 'PostGamemodeLoaded', 'vlissLoader', on_gmload )