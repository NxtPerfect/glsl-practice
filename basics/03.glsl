/* Moving smooth noise
*/

float noise(vec2 p) {
    return fract(sin(p.x*847.+p.y*760.)*7027.);
}

float smoothNoise(vec2 uv) {
    vec2 lv = fract(uv);
    vec2 id = floor(uv);
    
    // our own smoothing
    lv = lv*lv*(3.-2.*lv);
    
    // get bottom left, bottom right
    // of each cell
    // and mix them together
    float bl = noise(id);
    float br = noise(id+vec2(1,0));
    float b = mix(bl, br, lv.x);
    
    // get top left, top right
    // of each cell
    // and mix them together
    float tl = noise(id+vec2(0,1));
    float tr = noise(id+vec2(1,1));
    float t = mix(tl, tr, lv.x);
    
    // Mixes top and bottom into noise map
    return mix(b, t, lv.y);
}

float SmoothNoise(vec2 uv) {
    float c = smoothNoise(uv*4.);
    c += smoothNoise(uv*8.)*.5;
    c += smoothNoise(uv*16.)*.25;
    c += smoothNoise(uv*32.)*.125;
    c += smoothNoise(uv*64.)*.0625;
    
    return c / 2.;
}


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord.xy/iResolution.xy;
    
    // create noise from screen
    //float c = noise(uv);

    uv += iTime*.1;
    float c = SmoothNoise(uv);
    
    //for(float i = 0.; i < 2.; i++){
    //  c += SmoothNoise(uv*4.*i)*(1./(i*2.));
    //}
    //c /= 2.;
    
    vec3 col = vec3(c);
    
    fragColor = vec4(col, 1.0);
}
