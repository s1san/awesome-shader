float Circle(vec2 uv, vec2 p, float r, float blur) {
    float d = length(uv - p);
    float c = smoothstep(r, r - blur, d);

    return c;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;

    uv -= .5;
    uv.x *= iResolution.x / iResolution.y;

    vec3 col = vec3(0.);
    float mask = Circle(uv, vec2(0.), .4, .05);

    mask -= Circle(uv, vec2(-.13, .2), .07, .01);
    mask -= Circle(uv, vec2(.13, .2), .07, .01);

    float mouth = Circle(uv, vec2(0.), .3, .02);
    mouth -= Circle(uv, vec2(0.,.1), .3, 0.02);

    mask-=mouth;

    col=vec3(1.,1.,0.)*mask;

    fragColor = vec4(vec3(col), 1.0);
}