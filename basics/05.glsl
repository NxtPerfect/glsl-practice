/* Draws blue circle in the center, on top of red triangle from the center to the right */

float col(vec2 a, vec2 b, vec2 uv) {
    float cos1 = dot(a, uv);
    float cos2 = dot(b, uv);
    float cos3 = dot(a, b);
    
    return float ((cos1 >= cos3)) * float ((cos2 >= cos3));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord) {
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord / iResolution.xy;
    
    // Triangle setup
    vec2 a = vec2(1., 1.);
    vec2 b = vec2(.5, .5);
    vec2 c = vec2(1., 0.);
    
    vec2 ab = a - b;
    vec2 ac = a - c;
    vec2 bc = b - c;
    
    // Calculate triangle color
    float q1 = col(normalize(ab), normalize(ac), -normalize(uv - a));
    float q2 = col(normalize(ab), normalize(bc), -normalize(uv - b));
    vec3 triangleColor = vec3(1., 0., 0.); // Red color
    float triangle = q1 - q2;
    
    // Calculate circle
    float circleRadius = 0.2;
    vec2 circleCenter = vec2(.5, .5);
    // Calculate distance from the center, normalizing for aspect ratio
    float aspectRatio = iResolution.x / iResolution.y;
    float maxDimension = max(iResolution.x, iResolution.y);
    float distanceToCenter = length(uv * vec2(aspectRatio, 1.0) - circleCenter * vec2(aspectRatio, 1.0)) * maxDimension;
    vec3 circleColor = vec3(0., 0., 1.);
    // Use smoothstep to create a smooth transition for the circle
    float circle = smoothstep(circleRadius * maxDimension, (circleRadius + 0.01) * maxDimension, distanceToCenter);
    
    // Combine triangle and circle colors, ensuring they don't mix
    vec3 col = mix(circleColor, triangleColor * triangle, circle);
    
    // Output to screen
    fragColor = vec4(col, 1.0);
}
