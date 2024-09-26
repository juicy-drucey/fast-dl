/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

/*
	Enables the use of the ShouldCollide Hook which prevents small entities like jars / weedbranches to collide.
	NOTE: This hook can cause all physics to break under certain conditions.
*/
if not zgo2.config.CollisionFix then return end

local IsWeedBranch = {["zgo2_weedbranch"] = true}
local WeedBranchCollider = {
	["zgo2_crate"] = true,
	["zgo2_clipper"] = true,
	["zgo2_dryline"] = true,
}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

zclib.Hook.Add("ShouldCollide", "zgo2.Weedbranch.ShouldCollide", function(ent1, ent2)
	if IsValid(ent1) and IsValid(ent2) then
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

		// Make sure the player can still collide with it for physgun reasons
		if IsWeedBranch[ent1:GetClass()] and ent2:IsPlayer() then return true end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5559b70aef9c1abf2cb1ba55b1f16f11d321a43feaba0104044967bf0f5f93a3

		// If the second entity is not in out WeedBranchCollider list then prevent any collision
		if IsWeedBranch[ent1:GetClass()] and not WeedBranchCollider[ent2:GetClass()] then return false end
	end
end)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5559b70aef9c1abf2cb1ba55b1f16f11d321a43feaba0104044967bf0f5f93a3
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 392e0b69f013fac88b0ca32a370aadaa85d42104a0c169250a82c12e4c6498ab
