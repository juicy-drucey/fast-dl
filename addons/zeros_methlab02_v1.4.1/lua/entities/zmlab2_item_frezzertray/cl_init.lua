/*
    Addon id: a36a6eee-6041-4541-9849-360baff995a2
    Version: v1.4.1 (stable)
*/

include("shared.lua")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

function ENT:Initialize()
	zmlab2.FrezzerTray.Initialize(self)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 26dae7d76e41fa1a07cc1df9ca15aaa8a69611b8a8ac7b7fe6f2c87d405dd477
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

function ENT:DrawTranslucent()
	self:Draw()
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

function ENT:Draw()
	self:DrawModel()
	zmlab2.FrezzerTray.Draw(self)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821
