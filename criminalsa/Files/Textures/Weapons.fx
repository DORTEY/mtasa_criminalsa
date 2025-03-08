texture WeaponSkin;

technique TexReplace
{
    pass P0
    {
        Texture[0] = WeaponSkin;
    }
}