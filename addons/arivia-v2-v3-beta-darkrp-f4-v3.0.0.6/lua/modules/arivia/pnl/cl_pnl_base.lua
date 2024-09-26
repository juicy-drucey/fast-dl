/*
*   @package        : rcore
*   @module         : arivia
*   @author         : Richard [http://steamcommunity.com/profiles/76561198135875727]
*   @copyright      : (c) 2015 - 2021
*   @website        : https://rlib.io
*   @docs           : https://arivia.rlib.io
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

local base                  = rlib
local access                = base.a
local helper                = base.h
local design                = base.d
local ui                    = base.i
local mats                  = base.m
local cvar                  = base.v

/*
*   module calls
*/

local mod, pf       	    = base.modules:req( 'arivia' )
local cfg               	= base.modules:cfg( mod )

/*
*	localized plugin
*/

local handle                = mod.handle

/*
*   Localized translation func
*/

local function ln( ... )
    return base:translate( mod, ... )
end

/*
*	prefix ids
*/

local function pref( str, suffix )
    local state = not suffix and mod or isstring( suffix ) and suffix or false
    return base.get:pref( str, state )
end

/*
*	localized mat func
*/

local function mat( id )
    return mats:call( mod, id )
end

/*
*   panel
*/

local PANEL                 = { }

/*
*   initialize
*/

function PANEL:Init( )

    /*
    *   validate pl
    */

    if not helper.ok.ply( LocalPlayer( ) ) then return end
    local pl = LocalPlayer( )

    /*
    *   parent pnl
    */

    self                            = ui.get( self                          )
    :setup                          (                                       )
    :nodraw                         (                                       )
    :size                           ( self.w, self.h                        )
    :center                         (                                       )
    :notitle                        (                                       )
    :showclose                      ( false                                 )
    :popup                          (                                       )
    :pos                            ( self.pos_x, self.pos_y                )

    /*
    *   bg
    */

    self.ct_bg                      = ui.rlib( mod, 'pnl_bg', self          )
    :fill                           ( 'm', 0                                )

    /*
    *	left > container
    */

    self.ct_l 	                    = ui.new( 'pnl', self.ct_bg             )
    :left                           ( 'm', 0                                )
    :wide                           ( cfg.general.panels.left_w             )
    :register                       ( '$pnl_left', mod                      )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, h, self.clr_pnl_left )
                                        design.box( w - 1, 0, w, h, self.clr_sep )
                                    end )

    /*
    *	left > spacer
    */

    self.ct_l_spr 	                = ui.new( 'pnl', self.ct_bg, 1          )
    :left                           ( 'm', 0                                )
    :wide                           ( 0                                     )

    /*
    *	left > tabs
    */

    self.ct_l_tabs 	                = ui.new( 'pnl', self.ct_l              )
    :top                            ( 'm', 0                                )
    :tall                           ( 40                                    )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, h, self.clr_pnl_tabs )
                                        design.box( 0, h - 0.3, w, 1, self.clr_sep )
                                    end )

    /*
    *	left > inner container
    *
    *   main left container to hold tab buttons
    */

    self.ct_l_i 	                = ui.new( 'pnl', self.ct_l, 1           )
    :fill                           ( 'm', 0, 2, 0, 0                       )

    /*
    *	left > menu > store
    *
    *   container holds buttons for jobs, entities, shipments, etc.
    */

    self.mnu_store 	                = ui.new( 'pnl', self.ct_l_i, 1         )
    :left                           ( 'm', 0                                )
    :wide                           ( cfg.general.panels.left_w             )
    :register                       ( '$mnu_store', mod                     )

    /*
    *	left > menu > network
    *
    *   container that holds buttons for network website, donations, rules, etc.
    */

    local mnu_network 	            = ui.new( 'pnl', self.ct_l, 1           )
    :fill                           ( 'm', 0, 2, 0, 0                       )
    :hide                           (                                       )
    :register                       ( '$mnu_net', mod                       )

                                    /*
                                    *	tab > info > populate
                                    */

                                    self:LoadNetwork( mnu_network )

    /*
    *	left > menu > actions
    *
    *   quick commands sidebar
    */

    local mnu_acts 	                = ui.new( 'pnl', self.ct_l, 1           )
    :fill                           ( 'm', 0, 2, 0, 0                       )
    :hide                           (                                       )
    :register                       ( '$mnu_acts', mod                      )

                                    /*
                                    *	tab > cmds > populate
                                    */

                                    self:LoadActions( mnu_acts )

    /*
    *	middle / main > container
    *
    *   section where actual items will display
    *       ie: jobs, entities, shipments, etc.
    */

    self.ct_main 	                = ui.new( 'pnl', self.ct_bg             )
    :fill                           ( 'm', 0                                )
    :register                       ( '$pnl_content', mod                   )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, h, handle:GetBackgroundColor( ) )
                                    end )

    /*
    *	right > container
    *
    *   holds interface close button and ticker
    */

    self.ct_r 	                    = ui.new( 'pnl', self.ct_main           )
    :top                            ( 'm', 0, 0, 0, 0                       )
    :tall                           ( 40                                    )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, h, self.clr_pnl_header )
                                        design.box( 0, h - 0.3, w, 1, self.clr_sep )
                                    end )

    /*
    *   ticker
    */

    self.ct_ticker                  = ui.rlib( mod, 'pnl_ticker', self.ct_r, 1 )
    :fill                           ( 'm', 0, 3, 0                          )
    :align		                    ( 4 			                        )

    /*
    *   btn > toggle sidebar
    */

    self.b_toggle                   = ui.new( 'btn', self.ct_r              )
    :bsetup                         (                                       )
    :left                           ( 'm', 1                                )
    :wide                           ( 42                                    )
    :register                       ( '$btn_toggle', mod                    )
    :hide                           (                                       )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, h, Color( 0, 0, 0, 75 ) )
                                        if s.hover then
                                            design.box( 0, 0, w, h, Color( 0, 0, 0, 100 ) )
                                        end

                                        local clr_a     = math.abs( math.sin( CurTime( ) * 4 ) * 255 )
                                        clr_a	        = math.Clamp( clr_a, 150, 255 )

                                        local clr_btn   = ColorAlpha( cfg.ui.left.clrs.tabs_ico_s, clr_a )

                                        draw.SimpleText( '', pref( 'g_pnl_ext_tabs' ), w / 2 - 2, h / 2 + 1, clr_btn, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

                                    :oc( function( s )
                                        mod.ui:SetState( s, self )
                                    end )

    /*
    *   btn > close
    */

    self.b_close                    = ui.new( 'btn', self.ct_r              )
    :bsetup                         (                                       )
    :right                          ( 'm', 0                                )
    :size                           ( 46                                    )
    :notext                         (                                       )
    :onhover                        (                                       )
    :tooltip                        ( ln( 'tt_close_window' )               )
    :anim_click_ol                  ( Color( 255, 255, 255, 5 ), 0.4, 1, cfg.dev.bDisableAnim )

                                    :draw( function( s, w, h )
                                        local a	            = math.abs( math.sin( CurTime( ) * 3 ) * 255 )
                                        a			        = math.Clamp( a, 15, 255 )

                                        local clr_txt       = s.hover and Color( 255, 255, 255, a ) or self.cf_u.header.clrs.icons
                                        draw.SimpleText( helper.get:utf8( 'close' ), pref( 'g_hdr_exit' ), w - 15, h / 2, clr_txt, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
                                    end )

                                    :oc( function( s )
                                        mod.ui:Close( )
                                    end )

    /*
    *   btn > about
    */

    self.b_about                    = ui.new( 'btn', self.ct_r              )
    :bsetup                         (                                       )
    :right                          ( 'm', 0                                )
    :wide                           ( 32                                    )
    :notext                         (                                       )
    :onhover                        (                                       )
    :tooltip                        ( ln( 'tt_about' )                      )
    :anim_click_ol                  ( Color( 255, 255, 255, 5 ), 0.4, 1, cfg.dev.bDisableAnim )

                                    :draw( function( s, w, h )
                                        local a	        = math.abs( math.sin( CurTime( ) * 3 ) * 255 )
                                        a			    = math.Clamp( a, 15, 255 )

                                        local clr_txt   = s.hover and Color( 255, 255, 255, a ) or self.cf_u.header.clrs.icons
                                        draw.SimpleText( '', pref( 'g_ico_about' ), w / 2, h / 2, clr_txt, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

                                    :oc( function( s )
                                        if not ui:ok( self ) then return end

                                        /*
                                        *   return to last opened tab if about page currently visible
                                        */

                                        if ui:visible( '$pnl_about', mod ) then
                                            mod.ui:ClearContents( )
                                            handle.tab:CurShow( )
                                            return
                                        end

                                        /*
                                        *   action > unstageall
                                        */

                                        mod.ui:ClearContents( )

                                        /*
                                        *   get > parent pnl
                                        */

                                        local par               = ui:call( '$pnl_content', mod )
                                                                if not ui:ok( par ) then return end

                                        /*
                                        *   load about pnl
                                        */

                                        local pnl_about         = ui.rlib( mod, 'pnl_about', par        )
                                        :fill                   ( 'm', 0                                )
                                        :register               ( '$pnl_about', mod                     )
                                    end )

    /*
    *   btn > about
    */

    self.b_visible                  = ui.new( 'btn', self.ct_r              )
    :bsetup                         (                                       )
    :right                          ( 'm', 0, 0, 1, 0                       )
    :wide                           ( 38                                    )
    :notext                         (                                       )
    :onhover                        (                                       )
    :tooltip                        ( ln( 'tt_toggle_hide' )                )
    :anim_click_ol                  ( Color( 255, 255, 255, 5 ), 0.4, 1, cfg.dev.bDisableAnim )

                                    :draw( function( s, w, h )
                                        local pnl_leftbar   = ui:load( '$pnl_left', mod )
                                        local ico           = ( pnl_leftbar and ui:ok( pnl_leftbar ) ) and ui:visible( '$pnl_left', mod ) and '' or ''

                                        local a	            = math.abs( math.sin( CurTime( ) * 3 ) * 255 )
                                        a			        = math.Clamp( a, 15, 255 )

                                        local clr_txt       = s.hover and Color( 255, 255, 255, a ) or self.cf_u.header.clrs.icons
                                        draw.SimpleText( ico, pref( 'g_ico_vis' ), w / 2, h / 2, clr_txt, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

                                    :oc( function( s )
                                        mod.ui:SetState( s, self )
                                    end )

    /*
    *   btn > rehash
    */

    self.b_rehash                   = ui.new( 'btn', self.ct_r              )
    :bsetup                         (                                       )
    :right                          ( 'm', 0, 0, 1, 0                       )
    :wide                           ( 38                                    )
    :notext                         (                                       )
    :onhover                        (                                       )
    :tooltip                        ( ln( 'tt_toggle_rehash' )              )
    :anim_click_ol                  ( Color( 255, 255, 255, 5 ), 0.4, 1, cfg.dev.bDisableAnim )
    :state                          ( access:strict( LocalPlayer( ), 'rlib_root' ) and true or false )

                                    :logic( function( s )
                                        if cfg.dev.regeneration then return end
                                        ui:hide( s )
                                    end )

                                    :draw( function( s, w, h )
                                        local ico       = ''

                                        local a	        = math.abs( math.sin( CurTime( ) * 3 ) * 255 )
                                        a		        = math.Clamp( a, 15, 255 )

                                        local clr_txt   = s.hover and Color( 255, 255, 255, a ) or self.cf_u.header.clrs.icons
                                        draw.SimpleText( ico, pref( 'g_ico_rehash' ), w / 2, h / 2, clr_txt, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

                                    :oc( function( s )
                                        mod.ui:Rehash( true )
                                    end )

    /*
    *   check > display about button for specific groups
    */

    if not access:strict( pl, 'rlib_root' ) or not cfg.dev.bShowAbout then
        ui:hide( self.b_about )
    end

    /*
    *   loop > mini tabs
    *
    *   setup tabs to display at top left of interface
    *   displays buy, info, commands buttons
    */

    mod.tabs.m              = { }
    mod.tabs.first          = nil

    local i = #self:GetMint( )
    for v in helper.get.data( self:GetMint( ) ) do

        local ico_w                 = ( cfg.general.panels.left_w / i )

        /*
        *   btn > tab
        */

        local b_tabs                = ui.rlib( mod, 'elm_mtab', self.ct_l_tabs )
        :left                       ( 'm', 0                                )
        :wide                       ( ico_w                                 )
        :param                      ( 'SetText', ln( v.name ):upper( )      )
        :param                      ( 'SetTip', ln( v.tip )                 )
        :param                      ( 'SetMat', v.ico                       )
        :param                      ( 'SetMatSel', v.ico_sel                )
        :param                      ( 'SetAction', v.exec                   )

    end

    /*
    *   populate content
    */

    self:Populate( )

end

/*
*   populate content
*/

function PANEL:Populate( )
    mod.ui:UpdateStaff      ( )
    mod.ui:UpdateSettings   ( )
    self:RehashStore        ( )
end

/*
*   staff > open
*
*   updates the staff list and opens the interface
*/

function PANEL:StaffOpen( )
    mod.ui:UpdateStaff      ( )
    mod.ui:ClearContents    ( )

    ui:stage( '$pnl_staff', mod )
end

/*
*   CreateStoreBtn
*
*   @param  : tbl v
*   @param  : pnl par
*   @param  : pnl b
*/

function PANEL:CreateStoreBtn( v )

    local pnl_par                   = self.mnu_store
    local pnl_content               = self.tab_store
                                    if not ui:ok( pnl_content ) then return end

    /*
    *   localization
    */

    local m_icon                    = mat( v.icon )
    local clr_btn_txt_n             = v.clrs.tab.btn_txt_n
    local clr_btn_box_n             = v.clrs.tab.btn_box_n
    local clr_btn_box_s             = v.clrs.tab.btn_box_s
    local clr_btn_box_h             = v.clrs.tab.btn_box_h
    local clr_mat                   = v.clrs.tab.btn_mat
    local clr_lin_cor               = self.cf_n.clrs.corner_lines

    local lbl_name                  = v.name:upper( )
    local lbl_desc                  = v.desc:upper( )

    /*
    *   declare > content width
    *
    *   all store tabs require specified widths
    *   otherwise item slots will be different sizes
    */

    handle:SetTabWidth              ( pnl_content:GetWide( ) )

    /*
    *   store > btn > type
    *
    *   creates buttons :   jobs, entities, shipments, weapons, etc.
    */

    local b_type                    = ui.new( 'btn', pnl_par                )
    :bsetup                         (                                       )
    :top                            ( 'm', 0, 0, 1, 2                       )
    :tall                           ( 50                                    )
    :setupanim                      ( 'OnHoverFill', 7, rlib.i.OnHover      )
    :register                       ( '$' .. v.id, mod                      )

                                    :oc( function( s )

                                        /*
                                        *   find existing panel by id
                                        *       ie: jobs, ents, weps, etc.
                                        */

                                        local pnl = handle.tab:GetByKey( v.id )

                                        /*
                                        *   create new panel if handle.tab:GetByKey returns nil
                                        */

                                        if not pnl then
                                            pnl = vgui.Create( v.pnl, pnl_content )
                                        end

                                        /*
                                        *   clear all existing main panels
                                        */

                                        mod.ui:ClearContents( )

                                        /*
                                        *   register button
                                        *
                                        *   create / update tab pnl id
                                        *   set active tab
                                        */

                                        handle.tab:Register     ( pnl, v.id     )
                                        handle.tab:CurSetShow   ( v.id          )

                                        self:InvalidateChildren( )
                                    end )

                                    :draw( function( s, w, h )
                                        local ctab          = handle.tab:CurGet( )

                                        local clr_btn       = ctab == v.id and clr_btn_box_s or clr_btn_box_n
                                        local clr_txt       = clr_btn_txt_n

                                        local a	            = math.abs( math.sin( CurTime( ) * 2 ) * 255 )
                                        a			        = math.Clamp( a, 100, 255 )

                                        design.box( 0, 0, w, h, Color( clr_btn.r, clr_btn.g, clr_btn.b, ctab == v.id and a or clr_btn.a ) )

                                        /*
                                        *	corner lines
                                        */

                                        if self.cf_n.btn_show_cornerlines then
                                            local sz_lpnl           = w - 1
                                            local sz_h              = h

                                            -- top left
                                            design.line( 0, 15, 0, 0, clr_lin_cor )
                                            design.line( 15, 0, 0, 0, clr_lin_cor )

                                            -- bottom right
                                            design.line( sz_lpnl, sz_h - 1, sz_lpnl - 15, sz_h - 1, clr_lin_cor )
                                            design.line( sz_lpnl, sz_h - 15, sz_lpnl, sz_h, clr_lin_cor )
                                        end

                                        if s.hover then
                                            self:HoverFill( s, w, h, clr_btn_box_h )
                                        end

                                        design.mat( 6, 12, 25, 25, m_icon, clr_mat )

                                        draw.SimpleText( lbl_name, pref( 'nav_button_name' ), 40, s:GetTall( ) * .35, clr_txt, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( lbl_desc, pref( 'nav_button_desc' ), 40, s:GetTall( ) * .65, clr_txt, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   first tab loaded
    *
    *   defines the first tab loaded in case their last opened tab
    *   is not available with the current job
    */

    if not mod.tabs.first then
        mod.tabs.first = v.id
    end

    /*
    *   first load
    *
    *   registers the first tab loaded so we dont end up with a blank
    *   store content panel
    */

    if not self.bFirstLoad and handle.tab:CurGet( ) == v.id then
        local pnl           = vgui.Create( v.pnl, pnl_content )
        handle.tab:Register ( pnl, v.id )

        self.bFirstLoad     = true
    end

end

/*
*   RehashStoreContent
*
*   refreshes the content pnl of a store menu item by id
*
*   id options:     jobs
*                   ents
*                   weps
*                   ship
*                   vehc
*                   food
*                   ammo
*
*   @param  : str id
*/

function PANEL:RehashStoreContent( id )
    if not isstring( id ) then return end

    local old               = handle.tab:GetByKey( id )
                            ui:destroy( old )

    local tbl               = handle.tab:GetConfig( id )
    local new               = vgui.Create( tbl.pnl, self.tab_store )
    handle.tab:Register     ( new, id )
end

/*
*   RehashStore
*/

function PANEL:RehashStore( )

    /*
    *   reset first load
    *
    *   ensures first tab is re-populated
    */

    self.bFirstLoad                 = false

    /*
    *   cleanup
    */

    ui:unstage                      ( '$mnu_net',       mod                 )
    ui:dispatch                     ( '$mnu_store',     mod                 )
    ui:dispatch                     ( '$tab_store',     mod                 )

    /*
    *   tab > store
    *
    *   adds the store tabs to the left side under mini tabs
    */

    self.mnu_store                  = ui.new( 'pnl', self.ct_l_i, 1         )
    :left                           ( 'p', 2, 0, 2, 0                       )
    :sz                             ( cfg.general.panels.left_w, 0          )
    :register                       ( '$mnu_store', mod                     )

    /*
    *   tab > store > content
    *
    *   store content panels to right of tabs.
    *   where data is shown for each store tab
    */

    self.tab_store                  = ui.new( 'pnl', self.ct_main, 1        )
    :fill                           ( 'm', 0                                )
    :sz                             ( self:GetWide( ) - 230, 0              )
    :register                       ( '$tab_store', mod                     )

    /*
    *   tabs
    */

    self:CreateMnu_Jobs( )
    self:CreateMnu_Weps( )
    self:CreateMnu_Ammo( )
    self:CreateMnu_Food( )
    self:CreateMnu_Ship( )
    self:CreateMnu_Ents( )
    self:CreateMnu_Vehc( )

    /*
    *   dispatch > sub panels
    */

    ui:dispatch( '$pnl_staff',      mod )
    ui:dispatch( '$pnl_settings',   mod )

    /*
    *   show > last player opened tab
    */

    handle.tab:CurShow( )

    /*
    *   developer > load time
    */

    if cfg.dev.regeneration then
        print( ln( 'dev_loadtime', timex.secs.ms( mod.loadtime ) ) )
    end

    /*
    *   no tabs loaded
    */

    if not mod.tabs.first then
        self:NoResults( )
    end
end

/*
*   create store menu > jobs
*/

function PANEL:CreateMnu_Jobs( )
    if self.cf_t.jobs.bEnabled then
        self:CreateStoreBtn     ( self.cf_t.jobs )
    end
end

/*
*   create store menu > weapons
*
*   @return : int
*/

function PANEL:CreateMnu_Weps( )
    local i = mod.weps:Viewable( ) or 0

    if i ~= 0 and self.cf_t.weapons.bEnabled then
        self:CreateStoreBtn     ( self.cf_t.weapons )
    end

    return i
end

/*
*   create store menu > ammo
*
*   @return : int
*/

function PANEL:CreateMnu_Ammo( )
    local i = mod.ammo:Viewable( )

    if i ~= 0 and self.cf_t.ammo.bEnabled then
        self:CreateStoreBtn     ( self.cf_t.ammo )
    end

    return i
end

/*
*   create store menu > food
*
*   @return : int
*/

function PANEL:CreateMnu_Food( )
    local i = mod.food:Viewable( )

    if i ~= 0 and self.cf_t.food.bEnabled then
        self:CreateStoreBtn     ( self.cf_t.food )
    end

    return i
end

/*
*   create store menu > shipments
*
*   @return : int
*/

function PANEL:CreateMnu_Ship( )
    local i = mod.ship:Viewable( )

    if i ~= 0 and self.cf_t.shipments.bEnabled then
        self:CreateStoreBtn     ( self.cf_t.shipments )
    end

    return i
end

/*
*   create store menu > ents
*
*   @return : int
*/

function PANEL:CreateMnu_Ents( )
    local i = mod.ents:Viewable( )

    if i ~= 0 and self.cf_t.entities.bEnabled then
        self:CreateStoreBtn     ( self.cf_t.entities )
    end

    return i
end

/*
*   create store menu > vehicles
*
*   @return : int
*/

function PANEL:CreateMnu_Vehc( )
    local i = mod.vehc:Viewable( )

    if i ~= 0 and self.cf_t.vehicles.bEnabled then
        self:CreateStoreBtn     ( self.cf_t.vehicles )
    end

    return i
end

/*
*   Get navigation categories
*
*   @return : tbl
*/

function PANEL:CleanPanels( )
    mod.ui:ClearContents( )
    mod.ui:HideMenus( )
end

/*
*   get mini tabs
*
*   top left red tabs
*
*   @return : tbl
*/

function PANEL:GetMint( )

    /*
    *   nav > categories
    */

    local cats =
    {
        {
            id          = 'buy',
            name        = 'tab_cats_buy_name',
            tip         = 'tab_cats_buy_tip',
            ico         = 'tab_mini_buy_01',
            ico_sel     = 'nav_cats_buy_02',
            exec        = function( )
                            self:CleanPanels( )

                            ui:stage( '$mnu_store', mod )
                            handle.tab:CurShow( )
                        end,
        },
        {
            id          = 'actions',
            name        = 'tab_cats_act_name',
            tip         = 'tab_cats_act_tip',
            ico         = 'tab_mini_act_01',
            exec        = function( )
                            self:CleanPanels( )

                            ui:stage( '$mnu_acts', mod )
                            handle.tab:CurShow( )
                        end,
        },
        {
            id          = 'settings',
            name        = 'tab_cats_settings_name',
            tip         = 'tab_cats_settings_tip',
            ico         = 'tab_mini_settings_01',
            exec        = function( )
                            self:CleanPanels( )

                            ui:stage( '$mnu_acts', mod )
                            mod.ui:UpdateSettings( )
                            ui:stage( '$pnl_settings', mod )
                        end,
        },
        {
            id          = 'info',
            name        = 'tab_cats_info_name',
            tip         = 'tab_cats_info_tip',
            ico         = 'tab_mini_info_01',
            exec        = function( )
                            self:CleanPanels( )

                            ui:stage( '$mnu_net', mod )
                            self:StaffOpen( )
                        end,
        },
    }

    return cats

end

/*
*   LoadNetwork
*
*   @param  : pnl pnl
*/

function PANEL:LoadNetwork( pnl )

    /*
    *	pnl > validate
    */

    if not ui:ok( pnl ) then return end

    /*
    *	loop > nav > info
    */

    mod.tabs.n = { }
    for v in helper.get.data( cfg.nav.list ) do

        /*
        *	infobtn > check enabled
        */

        if not v.enabled then continue end

        /*
        *   declare > settings
        */

        local d_name                = ln( v.name ):upper( )
        local d_desc                = ln( v.desc ):upper( )
        local d_icon                = mat( v.icon )
        local bShowIcon             = self.cf_n.btn_show_icon
        local bShowDesc             = self.cf_n.btn_show_desc
        local bPanelClear           = false

        /*
        *	infobtn > parent
        */

        self.b_nav                  = ui.new( 'btn', pnl                    )
        :bsetup                     (                                       )
        :top                        ( 'm', 2, 0, 3, 2                       )
        :tall                       ( 50                                    )
        :onhover                    (                                       )
        :setupanim                  ( 'OnHoverFill', 7, rlib.i.OnHover      )
        :anim_click_ol              ( Color( 255, 255, 255, 5 ), 0.4, 1, cfg.dev.bDisableAnim )

                                    :oc( function( s )
                                        self:ClearSelected( )

                                        if not v.bNoClear and v.bIntegrated then
                                            bPanelClear = true
                                        end

                                        if bPanelClear then
                                            mod.ui:ClearContents( )
                                        end

                                        if not v.exec then return end
                                        v.exec( self )

                                        s.selected = true
                                    end )

                                    :draw( function( s, w, h )
                                        local clr_btn       = ( s.selected and v.clrs.box_s ) or v.clrs.box_n
                                        local clr_txt       = v.clrs.txt_n

                                        local a	            = math.abs( math.sin( CurTime( ) * 2 ) * 255 )
                                        a			        = math.Clamp( a, 100, 255 )

                                        design.box( 0, 0, w, h, Color( clr_btn.r, clr_btn.g, clr_btn.b, s.selected and a or clr_btn.a ) )

                                        /*
                                        *	corner lines
                                        */

                                        if self.cf_n.btn_show_cornerlines then
                                            local sz_lpnl           = w - 1
                                            local sz_h              = h
                                            local clr_lines_corner  = self.cf_n.clrs.corner_lines

                                            -- top left
                                            surface.SetDrawColor    ( clr_lines_corner )
                                            surface.DrawLine        ( 0, 15, 0, 0 )
                                            surface.DrawLine        ( 15, 0, 0, 0 )

                                            -- bottom right
                                            surface.SetDrawColor    ( clr_lines_corner )
                                            surface.DrawLine        ( sz_lpnl, sz_h - 1, sz_lpnl - 15, sz_h - 1 )
                                            surface.DrawLine        ( sz_lpnl, sz_h - 15, sz_lpnl, sz_h )
                                        end

                                        if s.hover then
                                            self:HoverFill( s, w, h, v.clrs.box_h )
                                        end

                                        local pos_w         = bShowIcon and 40 or 15
                                        local pos_h         = bShowDesc and ( h / 2 - 8 ) or h / 2

                                        if bShowIcon and v.icon then
                                            design.imat( 5, ( h / 2 ) - ( 25 / 2 ) + 1, 25, 25, d_icon, clr_txt )
                                        end

                                        draw.SimpleText( d_name, pref( 'nav_button_name' ), pos_w, pos_h, clr_txt, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                        if bShowDesc then
                                            draw.SimpleText( d_desc, pref( 'nav_button_desc' ), pos_w, h / 2 + 8, clr_txt, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                        end
                                    end )

        /*
        *   register > nav
        */

        table.insert( mod.tabs.n, self.b_nav )

    end

end

/*
*   ClearSelected
*/

function PANEL:ClearSelected( )
    for b in helper.get.data( mod.tabs.n ) do
        b.selected = false
    end
end

/*
*   LoadActions
*
*   @param  : pnl par
*/

function PANEL:LoadActions( par )
    if not ui:ok( par ) then return end

    local actions           = ui.rlib( mod, 'pnl_actions', par, 1   )
    :fill                   ( 'm', 0, 0, 0, 0                       )
end

/*
*   OnKeyCodePressed
*
*   @param  : enum key
*/

function PANEL:OnKeyCodePressed( key )
    if key ~= KEY_F4 then return end
    DarkRP.toggleF4Menu( )
end

/*
*	NoResults
*/

function PANEL:NoResults( )

    /*
    *   no results > parent
    */

    local par                       = ui.new( 'pnl', self.ct_main, 1        )
    :fill                           (                                       )
    :register                       ( '$tab_store_nores', mod               )

    /*
    *   no results > sub
    */

    local sub                       = ui.new( 'pnl', par                    )
    :fill                           ( 'm', 0, 0, 0, 0                       )
    :tall                           ( 36                                    )

                                    :draw( function( s, w, h )
                                        draw.SimpleText( ln( 'lst_results_404' ), pref( 'slot_results_none_404' ), w / 2, h / 2 - 135, Color( 158, 60, 58, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( '', pref( 'slot_results_none_ico' ), w / 2, h / 2 - 35, Color( 255, 255, 255, 20 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( ln( 'lst_results_none' ), pref( 'slot_results_none_msg' ), w / 2, h / 2 + 50, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

end

/*
*   Paint
*
*   @param  : int w
*   @param  : int h
*/

function PANEL:Think( w, h )
    if ui:visible( '$pnl_mviewer', mod ) then
        self:SetAlpha( self.cfg_nofocus_fade )
    else
        self:SetAlpha( 255 )
    end
end

/*
*   HoverFill
*
*   animation to make buttons appear as if they are being filled
*   with color when player hovers over
*
*   @param  : pnl s
*   @param  : int w
*   @param  : int h
*   @param  : clr clr
*/

function PANEL:HoverFill( s, w, h, clr )
    if cfg.dev.bDisableAnim then
        design.box( 0, 0, w, h, clr )
        return
    end

    local x, y, fw, fh = 0, 0, math.Round( w * s.OnHoverFill ), h
    design.box( x, y, fw, fh, clr )
end

/*
*   Declarations
*
*   all definitions associated to this panel
*/

function PANEL:_Declare( )

    /*
    *	declare > configs
    */

    self.cf_u                       = cfg.ui
    self.cf_n                       = cfg.nav.general
    self.cf_t                       = cfg.tabs

    /*
    *   declare > size
    */

    self.w, self.h                  = ScrW( ) * .85, ScrH( ) * .83
    self.pos_x, self.pos_y          = ( ScrW( ) / 2 ) - ( self.w / 2 ), ( ScrH( ) / 2 ) - ( self.h / 2 ) + 25

    /*
    *	declare > misc
    */

    self.cfg_nofocus_fade           = cfg.dev.anim_fade_nofocus or 50

    /*
    *	declare > general
    */

    self.bFirstLoad                 = false

    /*
    *   bg > filter > declarations
    */

    self.m_bg                       = isstring( cfg.bg.material.file ) and Material( cfg.bg.material.file ) or nil
    self.m_clr                      = IsColor( cfg.bg.material.clr ) and cfg.bg.material.clr or Color( 255, 255, 255, 255 )
    self.m_blur_i                   = isnumber( cfg.bg.filter.blur_power ) and cfg.bg.filter.blur_power or 2

end

/*
*   _Colorize
*/

function PANEL:_Colorize( )
    self.clr_pnl_root               = self.cf_u.main.clrs.panel
    self.clr_sep                    = self.cf_u.main.clrs.separator
    self.clr_pnl_left               = self.cf_u.left.clrs.panel
    self.clr_pnl_tabs               = self.cf_u.left.clrs.tabs_pnl_main
    self.clr_pnl_header             = self.cf_u.header.clrs.panel
end

/*
*   _Call
*/

function PANEL:_Call( )
    handle.tab:Reset( )
end

/*
*   register
*/

ui:create( mod, 'base', PANEL, 'frm' )