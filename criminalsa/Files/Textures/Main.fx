texture Tex;
technique textures
{
    pass P0
    {
        Texture[0] = Tex;
	    AlphaBlendEnable = TRUE;
    }
}