texture VehicleWindowTexture;

technique TexReplace
{
	pass P0
	{
		Texture[0] = VehicleWindowTexture;
	}
}