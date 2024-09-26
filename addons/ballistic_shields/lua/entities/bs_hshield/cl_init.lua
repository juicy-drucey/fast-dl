include('shared.lua')
include( "ballistic_shields/cl_bs_util.lua" ) 
ENT.RenderGroup = RENDERGROUP_BOTH

function ENT:Initialize()
	self.webmat = surface.GetURL(bshields.hShieldTexture, 256, 256)
end

function ENT:Draw()  
	if(bshields.hShieldTexture == "") then self:DrawModel() return end
	
	if ( self.Mat != nil ) then
		render.MaterialOverrideByIndex( 3, self.Mat )
	else
		local matdata = {
	        ["$basetexture"] = self.webmat:GetName(),
	        ["$decal"] = 1,
	        ["$translucent"] = 1
		}

		local uid = string.Replace( self.webmat:GetName(), "__vgui_texture_", "" )
		self.Mat = CreateMaterial( "bshields_webmat_"..uid, "VertexLitGeneric", matdata )
	end
	self:DrawModel()
	render.ModelMaterialOverride( nil )
end   