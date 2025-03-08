texture WeaponCrosshair;

technique TexReplace
{
    pass P0
    {
        Texture[0] = WeaponCrosshair;
    }
}