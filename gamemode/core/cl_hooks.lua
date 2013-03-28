/*
 *  Torrent - 2013 Illuminati Productions
 *
 *  This product is licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *  
 */
 
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