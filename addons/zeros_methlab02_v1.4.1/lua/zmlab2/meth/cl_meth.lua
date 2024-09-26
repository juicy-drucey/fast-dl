/*
    Addon id: a36a6eee-6041-4541-9849-360baff995a2
    Version: v1.4.1 (stable)
*/

if SERVER then return end
zmlab2 = zmlab2 or {}
zmlab2.Meth = zmlab2.Meth or {}

function zmlab2.Meth.Initialize(Meth)
    timer.Simple(0.1,function()
        if not IsValid(Meth) then return end
        Meth.Initialized = true
        zmlab2.Meth.UpdateMethMaterial(Meth)
    end)
end

function zmlab2.Meth.Draw(Meth)

    if Meth.Initialized and zclib.util.InDistance(Meth:GetPos(), LocalPlayer():GetPos(), 500) and zclib.Convar.Get("zmlab2_cl_drawui") == 1 then
        // Update the material once it gets drawn
        if Meth.LastDraw and CurTime() > (Meth.LastDraw + 0.1) then
            zmlab2.Meth.UpdateMethMaterial(Meth)
        end

        Meth.LastDraw = CurTime()

        zmlab2.Meth.DrawHUD(Meth:GetPos() + Vector(0,0,15),0.1,Meth:GetMethType(),Meth:GetMethAmount(),Meth:GetMethQuality())
    end
end

function zmlab2.Meth.UpdateMethMaterial(Meth)
    //zclib.Debug("zmlab2.Meth.UpdateMethMaterial")
    local MethMat = zmlab2.Meth.GetMaterial(Meth:GetMethType(),Meth:GetMethQuality())
    Meth:SetSubMaterial(0, "!" .. MethMat)
end

                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 6934fa9aa9cae346d9d98f13a34cb65a9923e0c6860723630bc61c5cbd5ae93a


local Effect_Type = 1
local Effect_Quality = 1
local Effect_Duration = 0
local EffectStrength = 0
local AudioSwitch = true
local NextEffect = 0

//Starts our screeneffect
net.Receive("zmlab2_Meth_Consum", function(len)
    local newEffectType = net.ReadUInt(16)
    Effect_Quality = net.ReadUInt(16)
    Effect_Duration = net.ReadUInt(16)


    // Stop the current music
    if LocalPlayer().zmlab2_MethMusic and newEffectType ~= Effect_Type then
        LocalPlayer().zmlab2_MethMusic:Stop()
        LocalPlayer().zmlab2_MethMusic = nil
    end

    Effect_Type = newEffectType

    EffectStrength = (1 / zmlab2.config.Meth.MaxDuration) * Effect_Duration
    EffectStrength = EffectStrength * ((1 / 100) * Effect_Quality)

    if LocalPlayer().zmlab2_MethMusic then
        LocalPlayer().zmlab2_MethMusic:ChangeVolume(EffectStrength, 0)
    end

    zmlab2.Meth.ScreenEffect_Start()
end)

function zmlab2.Meth.ScreenEffect_Start()
    zclib.Hook.Remove("RenderScreenspaceEffects", "zmlab2_Meth")
    zclib.Hook.Add("RenderScreenspaceEffects", "zmlab2_Meth",zmlab2.Meth.ScreenEffect_Logic)
end

function zmlab2.Meth.ScreenEffect_Stop()
    LocalPlayer():SetDSP(0)
    Effect_Type = 1
    Effect_Quality = 1
    Effect_Duration = 0
    EffectStrength = 0
    AudioSwitch = true
    NextEffect = 0
    zclib.Hook.Remove("RenderScreenspaceEffects", "zmlab2_Meth")

    if LocalPlayer().zmlab2_MethMusic then LocalPlayer().zmlab2_MethMusic:Stop() end
end

local lastSoundStop
function zmlab2.Meth.Music()
    local ply = LocalPlayer()
    local MethData = zmlab2.config.MethTypes[Effect_Type]
    if MethData and MethData.visuals and MethData.visuals.music and Effect_Duration > 0 then

        if ply.zmlab2_MethMusic == nil then
            ply.zmlab2_MethMusic = CreateSound(ply, "zmlab2_meth_music_" .. Effect_Type)
        end

        if ply.zmlab2_MethMusic:IsPlaying() == false then
            ply.zmlab2_MethMusic:Play()
            ply.zmlab2_MethMusic:ChangeVolume(0, 0)
            ply.zmlab2_MethMusic:ChangeVolume(EffectStrength, 2)
        end
    else
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 26dae7d76e41fa1a07cc1df9ca15aaa8a69611b8a8ac7b7fe6f2c87d405dd477

        if IsValid(ply.zmlab2_MethMusic) and ply.zmlab2_MethMusic:IsPlaying() == true then
            ply.zmlab2_MethMusic:ChangeVolume(0, 2)
            if ((lastSoundStop or CurTime()) > CurTime()) then return end
            lastSoundStop = CurTime() + 3

            timer.Simple(2, function()
                if (IsValid(ply)) then
                    ply.zmlab2_MethMusic:Stop()
                end
            end)
        end
    end
end

function zmlab2.Meth.ScreenEffect_Logic()

    if IsValid(LocalPlayer()) and LocalPlayer():Alive() == false then
        zmlab2.Meth.ScreenEffect_Stop()
        return
    end

    zmlab2.Meth.Music()

    if Effect_Duration > 0 then
        local methData = zmlab2.config.MethTypes[Effect_Type]
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

        Effect_Duration = math.Clamp(Effect_Duration - (1 * FrameTime()), 0, zmlab2.config.Meth.MaxDuration)

        local qual_fract = (1 / 100) * Effect_Quality

        local alpha = (1 / zmlab2.config.Meth.MaxDuration) * Effect_Duration
        alpha = alpha * qual_fract

        EffectStrength = alpha

        if AudioSwitch == true then
            LocalPlayer():SetDSP(3)
            AudioSwitch = false
        end

        // We only create the effects every so often and only if Effect_Duration is above a certain value
        if methData.visuals and methData.visuals.effect and CurTime() > NextEffect and Effect_Duration > 5 then

            local count = math.Clamp(math.Round(10 * EffectStrength),1,3)

            for i = 1, count do
                zclib.Effect.ParticleEffectAttach(methData.visuals.effect,PATTACH_ABSORIGIN_FOLLOW,LocalPlayer(), 0)
            end

            local delay = math.Clamp(2 - (2 * EffectStrength), 1, 5)
            NextEffect = CurTime() + delay
        end

        local h,s,v = ColorToHSV(methData.color)
        v = 0.5
        s = math.Clamp(s,0.15,1)
        local col = HSVToColor(h,s,v)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- a423d64e09a7ff35771e274d2c802c4d68af8d151714a29b1df4c0432d376358

        local r,g,b = ((1 / 255) * col.r) * alpha,((1 / 255) * col.g) * alpha,((1 / 255) * col.b) * alpha

        if methData.visuals and methData.visuals.Bloom then
            DrawBloom(alpha * 0.3, alpha * 2, alpha * 8, alpha * 8, 15, 1,r,g,b)
        end

        if methData.visuals and methData.visuals.MotionBlur then
            DrawMotionBlur(0.1 * alpha, alpha, 0)
        end

        if methData.visuals and methData.visuals.MaterialOverlay then
            DrawMaterialOverlay(methData.visuals.MaterialOverlay, -0.2 * alpha)
        end

        local tab = {}
        tab["$pp_colour_colour"] = 0.5
        tab["$pp_colour_contrast"] = math.Clamp(1 * alpha, 1, 2)
        tab["$pp_colour_brightness"] = math.Clamp(-0.3 * alpha, -1, 1)
        tab["$pp_colour_addr"] = r
        tab["$pp_colour_addg"] = g
        tab["$pp_colour_addb"] = b
        tab["$pp_colour_mulg"] = 0
        tab["$pp_colour_mulr"] = 0
        tab["$pp_colour_mulb"] = 0
        DrawColorModify(tab)
    else
        zmlab2.Meth.ScreenEffect_Stop()
    end
end

zmlab2.Meth.Colors = {}
function zmlab2.Meth.DrawHUD(pos,scale,m_type,m_amount,m_quality)
    local methData = zmlab2.config.MethTypes[m_type]
    if methData == nil then return end

    // Creates a slightly darker version of the meth color
    if zmlab2.Meth.Colors[m_type] == nil then
        local h,s,v = ColorToHSV(methData.color)
        v = 0.4
        local col = HSVToColor(h,s,v)
        zmlab2.Meth.Colors[m_type] = col
    end

    cam.Start3D2D(pos, Angle(0, LocalPlayer():EyeAngles().y - 90, 90), scale)
        draw.RoundedBox(0, -100, -30, 200, 100, zclib.colors["black_a200"])

        if not isstring(methData.name) then return end

        local font = zclib.GetFont("zmlab2_font02")
        if not font then return end
        
        local txtSize = zclib.util.GetTextSize(methData.name, font)

        if txtSize > 200 then font = zclib.GetFont("zmlab2_font01") end
        draw.SimpleText(methData.name, font, 0, 0, methData.color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

        zclib.util.DrawOutlinedBox(-100, -30, 200, 100, 2, methData.color)

        draw.SimpleText(m_amount .. zmlab2.config.UoM, zclib.GetFont("zmlab2_font01"), -50, 50, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        zclib.util.DrawOutlinedBox(-100, 30, 100, 40, 2, methData.color)

        draw.SimpleText(m_quality .. "%", zclib.GetFont("zmlab2_font01"), 50, 50, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        zclib.util.DrawOutlinedBox(0, 30, 100, 40, 2, methData.color)
    cam.End3D2D()
end
