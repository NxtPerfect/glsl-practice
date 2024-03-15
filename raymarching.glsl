#define MAX_STEPS 100
#define MAX_DISTANCE 100.
#define SURFACE_DISTANCE .01

float GetDistance(vec3 p) {
  vec4 sphere = vec4(0, 1, 6, 1); // distance x,y,z and radius
  float sphere_distance = length(p-sphere.xyz) - sphere.w;
  float plane_distance = p.y;

  float distance = min(sphere_distance, plane_distance);

  return distance;
}

float RayMarch(vec3 ray_origin, vec3 ray_direction) {
  float distance_origin = 0.;

  for(int i = 0; i < MAX_STEPS; i++){
    vec3 p = ray_origin + ray_direction * distance_origin;
    float distance_scene = GetDistance(p);
    distance_origin += distance_scene;
    if (distance_origin > MAX_DISTANCE || distance_origin < SURFACE_DISTANCE) {
      break;
    }
  }

  return distance_origin;
}

vec3 GetNormal(vec3 p) {
  float distance = GetDistance(p);
  vec2 e = vec2(.01, 0);

  vec3 n = distance - vec3(
    GetDistance(p-e.xyy), // same as vec3(.01, 0, 0);
    GetDistance(p-e.yxy),
    GetDistance(p-e.yyx)
  );

  return normalize(n);
}

float GetLight(vec3 p) {
  vec3 lightPosition = vec3(0, 5, 6);
  lightPosition.xz = vec2(sin(iTime), cos(iTime))*2.; // move the light in circle
  vec3 light = normalize(lightPosition - p);
  vec3 normal = GetNormal(p);

  float diffuse = clamp(dot(normal, light), 0., 1.);

  // Shadows
  float distance = RayMarch(p+normal*SURFACE_DISTANCE*2., light);
  if (distance < length(lightPosition - p)) diffuse *= .1;
  return diffuse;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = (fragCoord - .5*iResolution.xy)/iResolution.y;

    // Time varying pixel color
    vec3 color = vec3(0);
    vec3 ray_origin = vec3(0, 1, 0);
    vec3 ray_direction = normalize(vec3(uv.x, uv.y, 1));

    float distance = RayMarch(ray_origin, ray_direction);

    vec3 p = ray_origin + ray_direction * distance;

    float diffuse = GetLight(p);
    distance /= 6.;
    color = vec3(diffuse);

    // Output to screen
    fragColor = vec4(color,1.0);
}
