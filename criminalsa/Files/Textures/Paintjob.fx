texture CustomPaint;

technique TexReplace
{
    pass P0
    {
        Texture[0] = CustomPaint;
    }
}
