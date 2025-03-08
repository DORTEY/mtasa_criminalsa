texture CustomLights;

technique TexReplace
{
    pass P0
    {
        Texture[0] = CustomLights;
    }
}
