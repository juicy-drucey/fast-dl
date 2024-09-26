/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
SWEP.Weight = 5

function SWEP:Initialize()
	zgo2.Bong.Initialize(self)
end

function SWEP:Holster(swep)
	return zgo2.Bong.Holster(self)
end

function SWEP:Deploy()
	return zgo2.Bong.Deploy(self)
end

function SWEP:PrimaryAttack()
	zgo2.Bong.PrimaryAttack(self)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b

function SWEP:Think()
	zgo2.Bong.Think(self)
end

function SWEP:SecondaryAttack()
	zgo2.Bong.SecondaryAttack(self)
end

function SWEP:Reload()
	zgo2.Bong.Reload(self)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 392e0b69f013fac88b0ca32a370aadaa85d42104a0c169250a82c12e4c6498ab
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b

function SWEP:ShouldDropOnDie()
	return false
end
