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

local PANEL = {}

function PANEL:Init( )

    self.PanelServerlistBox = vgui.Create('DPanel', self)
    self.PanelServerlistBox:Dock(BOTTOM)
    self.PanelServerlistBox:SetTall(60)
    self.PanelServerlistBox.Paint = function( s, w, h )
        draw.RoundedBox(0, 0, 0, w, h, cfg.servers.general.clrs.pnl_main )
    end

    local i = 0
    for k, v in pairs( cfg.servers.list ) do

        surface.SetFont             ( 'VlissFontButtonItem' )
        local sizex, sizey          = surface.GetTextSize(string.upper(v.hostname))
        local mat                   = false

        self.b_serv                 = vgui.Create( 'DButton', self.PanelServerlistBox )
        self.b_serv:SetText         ( '' )
        self.b_serv:SetSize         ( sizex + 20, 60 )
        self.b_serv:Dock            ( LEFT )
        self.b_serv:DockMargin      ( 5, 0, 0, 0 )

        if v.icon and cfg.servers.general.icons_text then
            mat = Material(v.icon, 'noclamp smooth')
            self.b_serv:SetSize(self.b_serv:GetWide( ) + 32, self.b_serv:GetTall( ))
        elseif v.icon and cfg.servers.general.icons_only then
            mat = Material(v.icon, 'noclamp smooth')
            self.b_serv:SetSize(64, self.b_serv:GetTall( ))
        end

        self.b_serv.Paint = function( s, w, h )
            local color             = cfg.servers.general.clrs.btn_list_box_n
            local txtColor          = cfg.servers.general.clrs.btn_list_txt_n

            if s:IsHovered( ) or s:IsDown( ) then
                color               = cfg.servers.general.clrs.btn_list_box_h
                txtColor            = cfg.servers.general.clrs.btn_list_txt_n
            end

            surface.SetDrawColor    ( color )
            surface.DrawRect        ( 0, 0, w, h )

            if mat and (cfg.servers.general.icons_text or cfg.servers.general.icons_only) then
                surface.SetDrawColor(txtColor)
                surface.SetMaterial(mat)
            end

            if cfg.servers.general.icons_text and mat then
                surface.DrawTexturedRect(5, 14, 32, 32)
                draw.SimpleText(string.upper(v.hostname), 'VlissFontButtonItem', s:GetWide( ) / 2 + 16, s:GetTall( ) / 2, txtColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            elseif cfg.servers.general.icons_only and mat then
                surface.DrawTexturedRect(17, 14, 32, 32)
            else
                draw.SimpleText(string.upper(v.hostname), 'VlissFontButtonItem', s:GetWide( ) / 2, s:GetTall( ) / 2, txtColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
        end

        self.b_serv.DoClick = function( )
            self.ct_bg = vgui.Create('DPanel')
            self.ct_bg:Dock(FILL)
            self.ct_bg:DockMargin(0, 0, 0, 0)
            self.ct_bg.Paint = function( s, w, h )
                if vliss.core.BackgroundBlurEnabled then
                    DrawBlurPanel( s, 3 )
                end
                draw.RoundedBox( 0, 0, 0, w, h, cfg.servers.general.clrs.pnl_diag_fade )
            end

            self.ct_par = vgui.Create( 'DFrame' )
            self.ct_par:SetTitle( '' )
            self.ct_par:SetSize( 420, 185 )
            self.ct_par:SetDraggable( false )
            self.ct_par:ShowCloseButton( false )
            self.ct_par:Center( )
            self.ct_par:MakePopup( )
            self.ct_par.Paint = function( s, w, h )
                if vliss.core.BackgroundBlurEnabled then
                    DrawBlurPanel( s )
                end
                draw.RoundedBox( 4, 0, 0, w, h, cfg.servers.general.clrs.pnl_diag_main )
            end
            self.ct_par.OnKeyCodePressed = function( )
                if IsValid(self.ct_bg) then self.ct_bg:Remove( ) end
                if IsValid(self.ct_par) then self.ct_par:Remove( ) end
            end

            self.lbl_title = vgui.Create('DLabel', self.ct_par)
            self.lbl_title:Dock(TOP)
            self.lbl_title:DockMargin(10, 0, 1, 0)
            self.lbl_title:SetFont( 'vliss_cwserv_name' )
            self.lbl_title:SetTextColor( cfg.staffcard.clrs.txt_pl_name )
            self.lbl_title:SizeToContents( )
            self.lbl_title:SetText('Connect to ' .. v.hostname .. '?')

            self.lbl_msg = vgui.Create('DLabel', self.ct_par)
            self.lbl_msg:Dock(TOP)
            self.lbl_msg:SetTall( 80 )
            self.lbl_msg:DockMargin(10, 0, 5, 0)
            self.lbl_msg:SetFont( 'vliss_cwserv_desc' )
            self.lbl_msg:SetTextColor( cfg.staffcard.clrs.txt_pl_name )
            self.lbl_msg:SetWrap( true )
            self.lbl_msg:SetText('Are you sure you want to connect to ' .. v.ip .. '?\n\nYou will be connected automatically.')

            self.ct_sub = vgui.Create('DPanel', self.ct_par)
            self.ct_sub:Dock(BOTTOM)
            self.ct_sub:DockMargin(5, 10, 5, 10)
            self.ct_sub:SetTall( 32 )
            self.ct_sub.Paint = function( s, w, h ) end

            self.b_conn = vgui.Create( 'DButton', self.ct_sub )
            self.b_conn:Dock( LEFT )
            self.b_conn:SetWide( 260 )
            self.b_conn:DockMargin( 0, 0, 5, 0 )
            self.b_conn:SetText( 'Connect' )
            self.b_conn:SetFont( 'vliss_cwserv_btn_copy' )
            self.b_conn:SetTextColor( cfg.servers.general.clrs.btn_diag_txt_ok )
            self.b_conn.Paint = function( s, w, h )
                draw.RoundedBox( 4, 0, 0, w, h, cfg.servers.general.clrs.btn_diag_box_ok )
                if s:IsHovered( ) then
                    draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 0, 0, 100 ) )
                end
            end
            self.b_conn.DoClick = function( )
                if IsValid( self.ct_bg ) then self.ct_bg:Remove( ) end
                if IsValid( self.ct_par ) then self.ct_par:Remove( ) end
                LocalPlayer( ):ConCommand( 'connect ' .. v.ip )
            end

            self.b_close = vgui.Create( 'DButton', self.ct_sub )
            self.b_close:Dock( FILL )
            self.b_close:DockMargin( 5, 0, 0, 0 )
            self.b_close:SetWide(200)
            self.b_close:SetText( 'Stay' )
            self.b_close:SetFont( 'vliss_cwserv_btn_copy' )
            self.b_close:SetTextColor( cfg.servers.general.clrs.btn_diag_txt_no )
            self.b_close.Paint = function( s, w, h )
                draw.RoundedBox( 4, 0, 0, w, h, cfg.servers.general.clrs.btn_diag_box_no )
                if s:IsHovered( ) then
                    draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 0, 0, 100 ) )
                end
            end
            self.b_close.DoClick = function( s )
                if IsValid( self.ct_bg ) then self.ct_bg:Remove( ) end
                if IsValid( self.ct_par ) then self.ct_par:Remove( ) end
            end

        end

        i = i + 1
    end
end

vgui.Register( 'vliss_panel_serverconn', PANEL, 'EditablePanel' )