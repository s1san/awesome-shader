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

float remap01(float a,float b,float t){
    return (t-a)/(b-a);
}

float remap(float a,float b,float c,float d,float t){
    return remap01(a,b,t)*(d-c);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    float t=iGlobalTime;
    uv -= .5;
    uv.x *= iResolution.x / iResolution.y;

    vec3 col = vec3(0.);

    float mask=0.;

    float x=uv.x;

    // float m=-(x-.5)*(x+.5);
    // float m=sin(x*8.)*.1;
    // float m=sin(t)*.1;
    float m=sin(t+x*8.)*.1;
    float y=uv.y-m;

    // x+=.2;
    // x+=y;
    // x+=y*-.2;
    
    float blur=remap(-.5,.5,.01,.25,x);
    blur=pow(blur*4.,3.);

    mask=Rect(vec2(x,y),-.5,.5,-.1,.1,blur);
    col=vec3(1.,1.,1.)*mask;

    fragColor = vec4(vec3(col), 1.0);
}