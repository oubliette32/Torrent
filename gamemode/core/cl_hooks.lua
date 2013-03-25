
local wireframe = CreateMaterial( "WireframeMat", "Wireframe", {
	["$basetexture"] = "models/wireframe",
	["$ignorez"] = 1
});

hook.Add( "PostDrawEffects", "PDH", function()

	if ( TR.SpawnMenu && TR.SpawnMenu.Open ) then 

		for _, ent in pairs( TR.SpawnMenu.BackPanel.SelectedEntities or {} ) do 

			cam.Start3D(EyePos(),EyeAngles());

				render.MaterialOverride( wireframe );

				local col = Color( 128, 255, 128, 150 );

				render.SetColorModulation(col.r/255,col.g/255,col.b/255);
				render.SetBlend(col.a/255);

				ent:DrawModel();

				render.MaterialOverride(nil);

			cam.End3D();

		end

	end		

end);