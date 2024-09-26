/*
    Addon id: a36a6eee-6041-4541-9849-360baff995a2
    Version: v1.4.1 (stable)
*/

local Game = {}

/*
	Called once the minigame starts
*/
function Game:OnStart(Machine,ply)

	// Once someone responds to the minigame we remove the default fail.
	// NOTE We wanna give the player as much time as possible for it but we need to make sure the machien doesent softlock one the player disconnects or dies
	if SERVER then

		// Remove fail timer
		zclib.Timer.Remove("zmlab2_MiniGame_" .. Machine:EntIndex())

		// If the minigame was not completed in 50 seconds then we consider this a fail
		local timerid = "zmlab2_Fallback_" .. Machine:EntIndex()
	    zclib.Timer.Remove(timerid)
	    zclib.Timer.Create(timerid,50,1,function()
	        if IsValid(Machine) then
				zmlab2.MiniGame.Reset(Machine)
				zmlab2.MiniGame.Punishment(Machine,Machine:GetMethType())
	        end
	    end)
	end
end

/*
	Creates the interface
*/
function Game:Interface(Machine,ply)

	local window = vgui.Create("DFrame")
	window:SetSize(600 * zclib.wM, 300 * zclib.hM)
    window:Center()
    window:MakePopup()
    window:ShowCloseButton(false)
    window:SetTitle("")
    window:SetDraggable(true)
    window:SetSizable(false)
    window:DockPadding(0, 0, 0, 0)

	/*
        0 = Wait
        1 = PreviewSequence
        2 = Player repeats the sequence
    */
    window.GamePhase = 0
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 26dae7d76e41fa1a07cc1df9ca15aaa8a69611b8a8ac7b7fe6f2c87d405dd477

    window.StartTime = CurTime()
    window.PlayMusic = true
    window.ActiveSequenceID = 1

    // Generate the button sequence
    window.Sequence_Length = 4
    if IsValid(Machine) and Machine:GetClass() == "zmlab2_machine_filter" then
        local difficulty = zmlab2.Meth.GetDifficulty(Machine:GetMethType())
        local extraCount = (3 / 10) * difficulty
        window.Sequence_Length = 2 + math.Round(extraCount)
    end
    window.ButtonSequence = {}
    for i = 1, window.Sequence_Length do table.insert(window.ButtonSequence, math.random(1, 3)) end

    // Lets create the buttons
    window.ActionButtons = {}
    local ButtonCount = 3
    local size = 580 / 3
    local BtnContainer = vgui.Create("DPanel", window)
    BtnContainer:Dock(FILL)
    BtnContainer:DockMargin(10 * zclib.wM,120 * zclib.hM,10 * zclib.wM,10 * zclib.hM)
    BtnContainer.Paint = function(s, w, h) end
    window.BtnContainer = BtnContainer

    local function AddButton(id,color)
        local btn = vgui.Create("DButton", BtnContainer)
        btn:SetAutoDelete(true)
        btn:SetSize(size * zclib.wM, size * zclib.hM)
        btn:SetText("")
        btn.Paint = function(s, w, h)
            //draw.RoundedBox(0, 0, 0, w, h, color)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 6934fa9aa9cae346d9d98f13a34cb65a9923e0c6860723630bc61c5cbd5ae93a

            surface.SetDrawColor(color)
            surface.SetMaterial(zclib.Materials.Get("item_bg"))
            surface.DrawTexturedRect(0 * zclib.wM, 0 * zclib.hM, w, h)

            if btn.Preview then
                local Pulse = 1 - math.Clamp((1 / 0.5) * (btn.Preview - CurTime()),0,1)
                surface.SetDrawColor(255,255,255,255 * (1-Pulse))
                surface.SetMaterial(zclib.Materials.Get("radial_shadow"))
                surface.DrawTexturedRectRotated(w / 2, h / 2, w * Pulse, h * Pulse, 0)
                zclib.util.DrawOutlinedBox(0 * zclib.wM, 0 * zclib.hM, w, h, 6, zmlab2.colors["orange01"])

                if btn.Preview - CurTime() <= 0 then
                    btn.Preview = nil
                end
            else
                zclib.util.DrawOutlinedBox(0 * zclib.wM, 0 * zclib.hM, w, h, 6, color_white)
                if window.GamePhase < 2 then
                    draw.RoundedBox(0, 0, 0, w, h, zclib.colors["black_a200"])
                else
                    if s:IsHovered() then
                        draw.RoundedBox(0, 0, 0, w, h, zmlab2.colors["white02"])
                    end
                end
            end
        end
        btn.DoClick = function(s)
            if window.GamePhase < 2 then return end
            window:OnButtonPress(s.ButtonID)
        end

        if id == 1 then
            btn:Dock(LEFT)
        elseif id == 2 then
            btn:Dock(FILL)
            btn:DockMargin(10 * zclib.wM, 0 * zclib.hM, 10 * zclib.wM, 0 * zclib.hM)
        else
            btn:Dock(RIGHT)
        end

        btn.ButtonID = id
        window.ActionButtons[id] = btn
    end
    for i = 1, ButtonCount do AddButton(i, HSVToColor((360 / ButtonCount) * i, 1, 1)) end

    timer.Simple(3,function()
        if not IsValid(window) then return end
        window:PreviewSequence()
    end)


	// Shows the player which button to press and in which order
	window.PreviewSequence = function(s)
	    window.GamePhase = 1
	    local timerid = "zmlab2_Filter_MiniGame_PreviewSequence_Timer"
	    zclib.Timer.Remove(timerid)

	    local PreviewID = 1
	    zclib.Timer.Create(timerid,1,0,function()
	        if PreviewID > table.Count(window.ButtonSequence) then
	            zclib.Timer.Remove(timerid)
	            window:StartGame()
	        end

	        local NextButtonID = window.ButtonSequence[PreviewID]
	        if IsValid(window.ActionButtons[NextButtonID]) then
	            window:PlayButtonSound(NextButtonID)
	        end

	        PreviewID = PreviewID + 1
	    end)
	end

	window.StartGame = function(s)
	    window.GamePhase = 2
	end

	window.PlayButtonSound = function(s,ButtonID)
	    window.ActionButtons[ButtonID].Preview = CurTime() + 0.5
	    if ButtonID == 1 then
	        surface.PlaySound("zmlab2/minigame_filter_button01.wav")
	    elseif ButtonID == 2 then
	        surface.PlaySound("zmlab2/minigame_filter_button02.wav")
	    elseif ButtonID == 3 then
	        surface.PlaySound("zmlab2/minigame_filter_button03.wav")
	    end
	end

	window.OnButtonPress = function(s,ButtonID)
	    local WantedID = window.ButtonSequence[window.ActiveSequenceID]

	    window:PlayButtonSound(ButtonID)

	    if WantedID == ButtonID then

	        // Next!
	        window.ActiveSequenceID = window.ActiveSequenceID + 1

	        if window.ActiveSequenceID > table.Count(window.ButtonSequence) then
	            // We are done here, you won!
	            window:OnGameWon()
	        end
	    else
	        // Abort, You failed!
	        window:OnGameFailed()
	    end
	end

	window.OnGameWon = function(s)
	    window:EndGame(true)
	end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

	window.OnGameFailed = function(s)
	    window:EndGame(false)
	end

	window.EndGame = function(s,result)
	    window.GamePhase = 3
	    if IsValid(window.BtnContainer) then
	        window.BtnContainer:Remove()
	    end

	    if result then
	        surface.PlaySound("zmlab2/minigame_won.wav")
	    else
	        surface.PlaySound("zmlab2/minigame_lost.wav")
	    end

	    local MainContainer = vgui.Create("DPanel", window)
	    MainContainer:SetAlpha(0)
	    MainContainer:Dock(FILL)
	    MainContainer.Paint = function(s, w, h)
	        draw.RoundedBox(0, 0, 0, w, h, zclib.colors["black_a200"])

	        if result then
	            draw.SimpleText(zmlab2.language["Won"], zclib.GetFont("zclib_font_large"), w / 2, h / 2, zmlab2.colors["green03"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	        else
	            draw.SimpleText(zmlab2.language["Lost"], zclib.GetFont("zclib_font_large"), w / 2, h / 2, zmlab2.colors["red02"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	        end
	    end

	    MainContainer:AlphaTo(255, 0.25, 0, function()
	        timer.Simple(1, function()
	            if not IsValid(window) then return end

				zmlab2.MiniGame.Finish(self.GameID,Machine,result)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 6934fa9aa9cae346d9d98f13a34cb65a9923e0c6860723630bc61c5cbd5ae93a

	            window:Close()
	        end)
	    end)
	end

	window.Paint = function(s,w, h)
	    surface.SetDrawColor(zmlab2.colors["blue02"])
	    surface.SetMaterial(zclib.Materials.Get("item_bg"))
	    surface.DrawTexturedRect(0 * zclib.wM, 0 * zclib.hM, w, h)

	    local CountDown = math.Clamp((window.StartTime + 3) - CurTime(),0,3)
	    if CountDown <= 0 then
	        if window.GamePhase == 1 then
	            draw.SimpleText(zmlab2.language["Remember"], zclib.GetFont("zclib_font_big"), w / 2, 60 * zclib.hM, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	        elseif window.GamePhase == 2 then
	            draw.SimpleText(zmlab2.language["Repeat"], zclib.GetFont("zclib_font_big"), w / 2, 60 * zclib.hM, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	        end
	    else
	        draw.SimpleText(math.Round(CountDown), zclib.GetFont("zclib_font_big"), w / 2, 60 * zclib.hM, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	    end

	    zclib.util.DrawOutlinedBox(0 * zclib.wM, 0 * zclib.hM, w, h, 2, color_white)
	end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 6934fa9aa9cae346d9d98f13a34cb65a9923e0c6860723630bc61c5cbd5ae93a

	window.Think = function(s)
	    if window.GamePhase == 2 and input.IsKeyDown(KEY_ESCAPE) then
	        window:Close()
	    end

	    if window.PlayMusic == true then
	        if window.Sound == nil then
	            window.Sound = CreateSound(Machine, "zmlab2_minigame_loop")
	        else
	            if window.Sound:IsPlaying() == false then
	                window.Sound:Play()
	                window.Sound:ChangeVolume(1, 1)
	            end
	        end
	    else
	        if window.Sound and window.Sound:IsPlaying() == true then
	            window.Sound:Stop()
	        end
	    end
	end

	window.Close = function(s)
	    zclib.Timer.Remove("zmlab2_Filter_MiniGame_PreviewSequence_Timer")

	    window.PlayMusic = false
	    if window.Sound and window.Sound:IsPlaying() == true then window.Sound:Stop() end

	    if IsValid(window) then
	        window:Remove()
	    end

	    if window.Sound and window.Sound:IsPlaying() == true then
	        window.Sound:Stop()
	    end
	end
end

/*
	Called once the minigame finishes
*/
function Game:OnFinish(Machine,ply,DidWin)
	if SERVER then
		// Fallback fail timer
		zclib.Timer.Remove("zmlab2_Fallback_" .. Machine:EntIndex())
	end
end

zmlab2.MiniGame.Register("memorize",Game)
