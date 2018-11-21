//
//  DepthShader.metal
//  The-Dark-Place
//
//  Created by Rick Twohy on 11/17/18.
//  Copyright © 2018 2etime. All rights reserved.
//

#include <metal_stdlib>
#include "SharedMetal.metal"
using namespace metal;


vertex RasterizerData shadow_vertex_shader(VertexIn vertexIn [[ stage_in ]],
                                          constant SceneConstants &sceneConstants [[ buffer(1) ]],
                                          constant ModelConstants &modelConstants [[ buffer(2) ]]) {
    RasterizerData rd;
    
    rd.position = sceneConstants.viewMatrix * modelConstants.modelMatrix * float4(vertexIn.position, 1.0);
    
    return rd;
}


