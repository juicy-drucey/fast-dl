/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

zgo2 = zgo2 or {}
zgo2.Backpack = zgo2.Backpack or {}
zgo2.Backpack.List = zgo2.Backpack.List or {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

/*

	The backpack swep can be used to transport weed
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b

*/
zgo2.Backpack.Offsets = {}
zgo2.Backpack.Offsets["default"] = {	Vector(-2,-7.2,-3.2),	Angle(-8,0,0),	0.9}
zgo2.Backpack.Offsets["models/player/corpse1.mdl"] = Vector(-2,-7,0)
zgo2.Backpack.Offsets["models/player/monk.mdl"] = Vector(-2,-7,-1)
zgo2.Backpack.Offsets["models/player/police_fem.mdl"] = Vector(-2,-8,0)
zgo2.Backpack.Offsets["models/player/gman_high.mdl"] = {	Vector(-2,-8,-1),	Angle(0,0,0),	1}
zgo2.Backpack.Offsets["models/player/alyx.mdl"] = {	Vector(-2,-6.6,-1),	Angle(3,0,0),	0.8}
zgo2.Backpack.Offsets["models/player/group01/female_01.mdl"] = {	Vector(-2,-6.6,-1),	Angle(3,0,0),	0.8}
zgo2.Backpack.Offsets["models/player/group01/female_02.mdl"] = {	Vector(-2,-6.6,-1),	Angle(3,0,0),	0.8}
zgo2.Backpack.Offsets["models/player/group01/female_03.mdl"] = {	Vector(-2,-6.6,-1),	Angle(3,0,0),	0.8}
zgo2.Backpack.Offsets["models/player/group01/female_04.mdl"] = {	Vector(-2,-6.6,-1),	Angle(3,0,0),	0.8}
zgo2.Backpack.Offsets["models/player/group01/female_05.mdl"] = {	Vector(-2,-6.6,-1),	Angle(3,0,0),	0.8}
zgo2.Backpack.Offsets["models/player/group01/female_06.mdl"] = {	Vector(-2,-6.6,-1),	Angle(3,0,0),	0.8}
zgo2.Backpack.Offsets["models/player/group03m/female_06.mdl"] = {	Vector(-2,-6.6,-1),	Angle(3,0,0),	0.8}
zgo2.Backpack.Offsets["models/player/group03/female_01.mdl"] = {	Vector(-2,-6.6,-1),	Angle(3,0,0),	0.8}
zgo2.Backpack.Offsets["models/player/group03/female_02.mdl"] = {	Vector(-2,-6.6,-1),	Angle(3,0,0),	0.8}
zgo2.Backpack.Offsets["models/player/group03/female_03.mdl"] = {	Vector(-2,-6.6,-1),	Angle(3,0,0),	0.8}
zgo2.Backpack.Offsets["models/player/group03/female_04.mdl"] = {	Vector(-2,-6.6,-1),	Angle(3,0,0),	0.8}
zgo2.Backpack.Offsets["models/player/group03/female_05.mdl"] = {	Vector(-2,-6.6,-1),	Angle(3,0,0),	0.8}
zgo2.Backpack.Offsets["models/player/group03/female_06.mdl"] = {	Vector(-2,-6.6,-1),	Angle(3,0,0),	0.8}
zgo2.Backpack.Offsets["models/player/group03m/female_01.mdl"] = {	Vector(-2,-6.6,-1),	Angle(3,0,0),	0.8}
zgo2.Backpack.Offsets["models/player/group03m/female_02.mdl"] = {	Vector(-2,-6.6,-1),	Angle(3,0,0),	0.8}
zgo2.Backpack.Offsets["models/player/group03m/female_03.mdl"] = {	Vector(-2,-6.6,-1),	Angle(3,0,0),	0.8}
zgo2.Backpack.Offsets["models/player/group03m/female_04.mdl"] = {	Vector(-2,-6.6,-1),	Angle(3,0,0),	0.8}
zgo2.Backpack.Offsets["models/player/group03m/female_05.mdl"] = {	Vector(-2,-6.6,-1),	Angle(3,0,0),	0.8}
zgo2.Backpack.Offsets["models/player/group03m/female_06.mdl"] = {	Vector(-2,-6.6,-1),	Angle(3,0,0),	0.8}
zgo2.Backpack.Offsets["models/player/police_fem.mdl"] = {	Vector(-2,-6.6,-1),	Angle(3,0,0),	0.8}
zgo2.Backpack.Offsets["models/player/mossman.mdl"] = {	Vector(-2,-6.7,-1),	Angle(4,0,0),	0.8}
zgo2.Backpack.Offsets["models/player/mossman_arctic.mdl"] = {	Vector(-2,-6.7,-1),	Angle(4,0,0),	0.8}
zgo2.Backpack.Offsets["models/player/p2_chell.mdl"] = {	Vector(-2,-5.7,-0.3),	Angle(0,0,0),	0.75}
zgo2.Backpack.Offsets["models/player/arctic.mdl"] = {	Vector(-2,-7,-1),	Angle(-10,0,0),	0.9}
zgo2.Backpack.Offsets["models/player/barney.mdl"] = {	Vector(-2,-7,-2),	Angle(-10,0,0),	0.9}
zgo2.Backpack.Offsets["models/player/breen.mdl"] = {	Vector(-2,-6,-2),	Angle(-10,0,0),	0.8}
zgo2.Backpack.Offsets["models/player/barney.mdl"] = {	Vector(-2,-7,-2),	Angle(-10,0,0),	0.9}
zgo2.Backpack.Offsets["models/player/barney.mdl"] = {	Vector(-2,-7,-2),	Angle(-10,0,0),	0.9}
zgo2.Backpack.Offsets["models/player/barney.mdl"] = {	Vector(-2,-7,-2),	Angle(-10,0,0),	0.9}
zgo2.Backpack.Offsets["models/player/barney.mdl"] = {	Vector(-2,-7,-2),	Angle(-10,0,0),	0.9}
zgo2.Backpack.Offsets["models/player/barney.mdl"] = {	Vector(-2,-7,-2),	Angle(-10,0,0),	0.9}
zgo2.Backpack.Offsets["models/player/barney.mdl"] = {	Vector(-2,-7,-2),	Angle(-10,0,0),	0.9}
zgo2.Backpack.Offsets["models/player/phoenix.mdl"] = {	Vector(-2,-7,0),	Angle(-12,0,0),	0.9}
zgo2.Backpack.Offsets["models/player/combine_super_soldier.mdl"] = {	Vector(-2,-7,0),	Angle(-12,0,0),	0.9}
zgo2.Backpack.Offsets["models/player/combine_soldier_prisonguard.mdl"] = {	Vector(-2,-7,0),	Angle(-12,0,0),	0.9}
zgo2.Backpack.Offsets["models/player/combine_soldier.mdl"] = {	Vector(-2,-7,0),	Angle(-12,0,0),	0.9}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5559b70aef9c1abf2cb1ba55b1f16f11d321a43feaba0104044967bf0f5f93a3



/*

	Here we can register custom items for the Backpack, this serves as a method to overwrite certain checks

*/
zgo2.Backpack.Items = {}
function zgo2.Backpack.RegisterItem(id, data) zgo2.Backpack.Items[ id ] = data end

/*
zgo2.Backpack.RegisterItem("entity_class",{
	CanPickUp = function(ent) return true end,
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

	CanDrop = function(ply, data)
		return true
	end,
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5559b70aef9c1abf2cb1ba55b1f16f11d321a43feaba0104044967bf0f5f93a3

	GetData = function(slot_data)
		return { key = val, otherkey = val }
	end,

	DisplayOverwrite = function(itm,SlotData)
		local CustomImagePanel = vgui.Create("Panel")
		return CustomImagePanel
	end
})
*/

/*
zgo2.Backpack.RegisterItem("prop_physics",{
	CanPickUp = function(ent) return true end,
	CanDrop = function(ply, data) return true end
})
*/
