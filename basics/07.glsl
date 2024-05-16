/* White triangle from right side pointing to left side 
 * red circle in the center
*/

float col(vec2 a, vec2 b, vec2 uv) {
    float cos1 = dot(a, uv);
    float cos2 = dot(b, uv);
    float cos3 = dot(a, b);
    
    return float ((cos1 >= cos3)) * float ((cos2 >= cos3));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord) {

    vec2 uv = fragCoord / iResolution.xy;
    
    vec2 a = vec2(1., 0.);
    vec2 b = vec2(0., .5);
    vec2 c = vec2(1., 1.);
    
    vec2 ab = a - b;
    vec2 ac = a - c;
    vec2 bc = b - c;
    
    float q1 = col(normalize(ab), normalize(ac), -normalize(uv-a));
    float q2 = col(normalize(ab), normalize(bc), -normalize(uv-b));
    
    vec3 triangleColor = vec3(1., 1., 1.);
    float triangle = q1-q2;
    
    float circleRadius = .25;
    vec2 circleCenter = vec2(.5, .5);
    float aspectRatio = iResolution.x / iResolution.y;
    float maxDimension = max(iResolution.x, iResolution.y);
    float distanceToCenter = length(uv * vec2(aspectRatio, 1.0) - circleCenter * vec2(aspectRatio, 1.0))*maxDimension;
    vec3 circleColor = vec3(1., 0., 0.);
    float circle = smoothstep(circleRadius * maxDimension, (circleRadius + 0.01) * maxDimension, distanceToCenter);
    
    
    vec3 col = mix(circleColor, triangleColor * triangle, circle);
    fragColor = vec4(col, 1.);
}
