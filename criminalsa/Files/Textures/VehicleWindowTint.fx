struct VS_OUTPUT
{
    float2 texCoord : TEXCOORD0;
    float4 vertexColor : COLOR0;
};

sampler2D glassTexture;
float4 WindowTintColor;
float alphaThreshold;
float darknessFactor;

float4 PS_Main(VS_OUTPUT input) : COLOR
{
    float4 originalColor = tex2D(glassTexture, input.texCoord);

    float vertexAlpha = input.vertexColor.a;

    float4 darkenedTintColor = WindowTintColor * darknessFactor;

    if (vertexAlpha < alphaThreshold && originalColor.a > alphaThreshold)
    {
        return lerp(originalColor * input.vertexColor, darkenedTintColor, 0.5);
    }
    else
    {
        return originalColor * input.vertexColor;
    }
}

technique TintedGlass
{
    pass P0
    {
        PixelShader = compile ps_2_0 PS_Main();
    }
}
