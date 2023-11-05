float Circle(vec2 uv, vec2 p, float r, float blur) {
    float d = length(uv - p);
    float c = smoothstep(r, r - blur, d);

    return c;
}

float Smiley(vec2 uv,vec2 p,float size){
    uv-=p;
    uv/=size;

    float mask = Circle(uv, vec2(0.), .4, .01);

    mask -= Circle(uv, vec2(-.13, .2), .07, .01);
    mask -= Circle(uv, vec2(.13, .2), .07, .01);

    float mouth = Circle(uv, vec2(0.), .3, .02);
    mouth -= Circle(uv, vec2(0.,.1), .3, 0.02);

    mask-=mouth;

    return mask;
}

float Band(float t,float start,float end,float blur){
    float step1=smoothstep(start-blur,start+blur,t);
    float step2=smoothstep(end+blur,end-blur,t);

    return step1*step2;
}

float Rect(vec2 uv,float left,float right,float bottom,float top,float blur){
    float band1=Band(uv.x,left,right,blur);
    float band2=Band(uv.y,bottom,top,blur);

    return band1*band2;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;

    uv -= .5;
    uv.x *= iResolution.x / iResolution.y;

    vec3 col = vec3(0.);

    float mask=0.;
    
    // Smiley(uv,vec2(0.,0.05),.5);
    mask=Rect(uv,-.2,.2,-.3,.3,.01);

    col=vec3(1.,1.,1.)*mask;

    fragColor = vec4(vec3(col), 1.0);
}