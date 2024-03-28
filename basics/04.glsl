/* Triangle from center to right

float col(vec2 a, vec2 b, vec2 uv)
{
    float cos1 = dot(a, uv);
    float cos2 = dot(b, uv);
    float cos3 = dot(a, b);
  
    return float ((cos1) >= (cos3)) * float ((cos2) >= (cos3));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;

    vec2 a = vec2(1., 1.);
    vec2 b = vec2(0.5, 0.5);
    vec2 c = vec2(1., 0.);
  
    vec2 ab = a - b;
  
    vec2 ac = a - c;
  
    vec2 bc = b - c;
  
    float q1 = col(normalize(ab), normalize(ac), -normalize(uv - a));
  
    float q2 = col(normalize(ab), normalize(bc), -normalize(uv - b));
    
    vec3 col = vec3(q1 - q2);
    
    
    fragColor = vec4(col, 1.0);
  
}
