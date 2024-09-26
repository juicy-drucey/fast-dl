/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

include("shared.lua")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 3198271ffe3580e77dcdbbfd2ed320261e012e96aa33dd1da5d29f0b668843bb
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 392e0b69f013fac88b0ca32a370aadaa85d42104a0c169250a82c12e4c6498ab

function ENT:Initialize()
	zgo2.Lamp.Initialize(self)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

function ENT:Draw()
	self:DrawModel()
	zgo2.Lamp.OnDraw(self)
end

function ENT:Think()
	zgo2.Lamp.OnThink(self)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 392e0b69f013fac88b0ca32a370aadaa85d42104a0c169250a82c12e4c6498ab

function ENT:OnRemove()
	zgo2.Lamp.OnRemove(self)
end
