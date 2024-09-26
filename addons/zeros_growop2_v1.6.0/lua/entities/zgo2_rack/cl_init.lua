/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

include("shared.lua")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 392e0b69f013fac88b0ca32a370aadaa85d42104a0c169250a82c12e4c6498ab
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432

function ENT:Initialize()

end

function ENT:Draw()
	self:DrawModel()
	/*
	// NOTE For debugging
	local dat = zgo2.Rack.GetData(self:GetRackID())
	for k,v in pairs(dat.PotPositions) do
		debugoverlay.Sphere(self:LocalToWorld(v),5,0.1,Color( 0, 255, 0 ),true)
	end
	*/
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

function ENT:OnRemove()
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432

end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821
