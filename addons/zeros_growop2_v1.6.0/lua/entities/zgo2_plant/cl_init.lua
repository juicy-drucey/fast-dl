/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

include("shared.lua")

function ENT:Initialize()
	zgo2.Plant.Initialize(self)
end

function ENT:Draw()
	zgo2.Plant.OnDraw(self)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

function ENT:Think()
	zgo2.Plant.OnThink(self)
	self:SetNextClientThink(CurTime() + 1)
    return true
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 3198271ffe3580e77dcdbbfd2ed320261e012e96aa33dd1da5d29f0b668843bb
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

function ENT:OnRemove()
	zgo2.Plant.OnRemove(self)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5559b70aef9c1abf2cb1ba55b1f16f11d321a43feaba0104044967bf0f5f93a3
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821
