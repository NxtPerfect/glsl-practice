/* Draw a circle in the middle of the screen
*/

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord.xy/iResolution.xy;
    
    uv -= .5;
    uv *= iResolution.xy/iResolution.y;
    
    float d = length(uv);
    float c = d;
    
    if (d < .3) c = 1.;
    else c = 0.;

    // Output to screen
    fragColor = vec4(vec3(c), 1.0);
}
