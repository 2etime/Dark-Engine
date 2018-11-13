
import MetalKit


class MultiTerrainTexture {
    var backgroundTextureType: TextureTypes!
    var blendMapTextureType: TextureTypes!
    var rTextureTextureType: TextureTypes!
    var gTextureTextureType: TextureTypes!
    var bTextureTextureType: TextureTypes!

    init(_ backgroundTextureType: TextureTypes,
         _ blendMapTextureType: TextureTypes,
         _ rTextureTextureType: TextureTypes,
         _ gTextureTextureType: TextureTypes,
         _ bTextureTextureType: TextureTypes){
        self.backgroundTextureType = backgroundTextureType
        self.blendMapTextureType = blendMapTextureType
        self.rTextureTextureType = rTextureTextureType
        self.gTextureTextureType = gTextureTextureType
        self.bTextureTextureType = bTextureTextureType
    }
    
    func renderTextures(_ renderCommandEncoder: MTLRenderCommandEncoder){
        renderCommandEncoder.setFragmentSamplerState(Graphics.SamplerStates[.Linear_Repeat], index: 0)
        renderCommandEncoder.setFragmentSamplerState(Graphics.SamplerStates[.Linear], index: 1)
        
        renderCommandEncoder.setFragmentTexture(Entities.Textures[backgroundTextureType], index: 0)
        renderCommandEncoder.setFragmentTexture(Entities.Textures[rTextureTextureType], index: 1)
        renderCommandEncoder.setFragmentTexture(Entities.Textures[gTextureTextureType], index: 2)
        renderCommandEncoder.setFragmentTexture(Entities.Textures[bTextureTextureType], index: 3)
        renderCommandEncoder.setFragmentTexture(Entities.Textures[blendMapTextureType], index: 4)
    }
}
