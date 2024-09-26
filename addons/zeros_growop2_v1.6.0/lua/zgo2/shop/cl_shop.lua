/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

zgo2 = zgo2 or {}
zgo2.Shop = zgo2.Shop or {}

/*
	Called from the server to tell the client what category and itemid this entity is bound to
*/
net.Receive("zgo2.Shop.Update", function(len,ply)
    zclib.Debug_Net("zgo2.Shop.Update", len)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

	local ent = net.ReadEntity()
	if not IsValid(ent) then return end
	if not ent:IsValid() then return end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5559b70aef9c1abf2cb1ba55b1f16f11d321a43feaba0104044967bf0f5f93a3

	local price = net.ReadUInt(32)
	if not price then return end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432

	ent.zgo2_shop_price = price
end)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 392e0b69f013fac88b0ca32a370aadaa85d42104a0c169250a82c12e4c6498ab
