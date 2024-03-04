/* Playing around with triangle
 ** Creates drop from top right to bottom left, going through middle
 ** Where it's a triangle, along the line of black/white
*/

#define PI 3.14
#define TWO_PI 6.28

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    //vec2 uv = fragCoord/iResolution.xy;

    // Output to screen
    //fragColor = vec4(uv.x, uv.y, 0.0, 1.0);
    
    vec2 st = ( 2.* fragCoord - iResolution.xy)/iResolution.y;
    vec3 color = vec3(0.0);
    float d = 0.0;
    
    // Number of sides of your shape
    int N = 3;
  
    // Calculate distance from center
    float a = atan(st.x,st.y)+PI;
    float r = (TWO_PI)/float(N);
  
    // Shaping function that modulate the distance
    d = cos(floor(.5+a/r)*r-a)*length(st+tan(iTime));
  
    //color = vec3(1.0-smoothstep(.4,.41,d));
    color = vec3(smoothstep(.6*uv.x,.6*uv.y,d));
  
    fragColor = vec4(color,1.0);
}
