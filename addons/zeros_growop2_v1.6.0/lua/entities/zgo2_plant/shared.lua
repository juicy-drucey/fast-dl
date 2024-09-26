/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

ENT.Type                    = "anim"
ENT.Base                    = "base_anim"
ENT.AutomaticFrameAdvance   = false
ENT.PrintName               = "Plant"
ENT.Author                  = "ZeroChain"
ENT.Category                = "Zeros GrowOP 2"
ENT.Spawnable               = false
ENT.AdminSpawnable          = false
ENT.Model                   = "models/zerochain/props_growop2/zgo2_plant01.mdl"
ENT.RenderGroup             = RENDERGROUP_TRANSLUCENT
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 3198271ffe3580e77dcdbbfd2ed320261e012e96aa33dd1da5d29f0b668843bb
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

function ENT:SetupDataTables()
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5559b70aef9c1abf2cb1ba55b1f16f11d321a43feaba0104044967bf0f5f93a3

	// Id to the plant config
	self:NetworkVar("Int", 0, "PlantID")

	// How much THC do we currently have
	self:NetworkVar("Int", 3, "GrowCompletedTime")

	// Time in seconds till its fully grown
	self:NetworkVar("Int", 1, "GrowProgress")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b

	// Amount of light the plant is getting
	self:NetworkVar("Int", 2, "LightLevel")
	/*
		0 = No Light
		1 = Enough Light
		2 = Too much light
		3 = Wrong Color
	*/
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

	if (SERVER) then
		self:SetPlantID(0)
		self:SetGrowProgress(0)
		self:SetLightLevel(0)
		self:SetGrowCompletedTime(0)
	end
end

function ENT:CanProperty(ply)
    return ply:IsSuperAdmin()
end

function ENT:CanTool(ply, tab, str)
    return ply:IsSuperAdmin()
end

function ENT:CanDrive(ply)
    return false
end
