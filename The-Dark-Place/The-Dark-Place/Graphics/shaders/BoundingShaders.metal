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


vertex RasterizerData bounding_vertex_shader(VertexIn vertexIn [[ stage_in ]],
                                           constant SceneConstants &sceneConstants [[ buffer(1) ]],
                                           constant ModelConstants &modelConstants [[ buffer(2) ]]) {
    RasterizerData rd;
    
    float4 offsetPosition = float4(vertexIn.position, 1) + float4(modelConstants.offset, 0);
    float4 worldPosition = modelConstants.modelMatrix  * offsetPosition;
    float4 position = sceneConstants.projectionMatrix * sceneConstants.viewMatrix * worldPosition;
    rd.position = position;
    rd.textureCoordinate = vertexIn.textureCoordinate;
    return rd;
}

fragment half4 bounding_fragment_shader(RasterizerData rd [[ stage_in ]]){
    float4 color = float4(1,0,0,1);
   
    if(rd.textureCoordinate.x < 0.007 || rd.textureCoordinate.y < 0.007 || rd.textureCoordinate.x > 0.993 || rd.textureCoordinate.y > 0.993){
        return half4(1,0,0,1);
    }else {
        discard_fragment();
    }
    
    return half4(0);
}

