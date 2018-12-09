
import MetalKit

class TerrainGameObject: Node {
    
    internal var material: Material! = Material()
    private var terrainMesh: Mesh!
    private var terrainSize: Int32 = 0
    private var multiTerrainTexture: MultiTerrainTexture! = nil
    private var textureType: TextureTypes = TextureTypes.None

    init(cellCount: Int, textureType: TextureTypes = TextureTypes.None) {
        super.init(name: "Terrain")
        self.terrainSize = Int32(cellCount)
        self.textureType = textureType
        self.terrainMesh = TerrainLoader.GenerateTerrainMesh(cellCount: cellCount)
    }
    
    func setMultiTerrainTexture(_ multiTerrainTexture: MultiTerrainTexture){
        self.multiTerrainTexture = multiTerrainTexture
    }
    
    func setTerrainTexture(_ textureType: TextureTypes){
        self.textureType = textureType
    }

}

extension TerrainGameObject: Renderable {

    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setFragmentBytes(&material, length: Material.stride, index: 0)
        renderCommandEncoder.setDepthStencilState(Graphics.DepthStencilStates[.Less])

        if(multiTerrainTexture != nil){
            renderCommandEncoder.setRenderPipelineState(Graphics.RenderPipelineStates[.TerrainMultiTextured])
            renderCommandEncoder.setFragmentBytes(&terrainSize, length: Int32.stride, index: 2)
            multiTerrainTexture.renderTextures(renderCommandEncoder)
        } else {
            renderCommandEncoder.setRenderPipelineState(Graphics.RenderPipelineStates[.TerrainTextured])
            renderCommandEncoder.setFragmentSamplerState(Graphics.SamplerStates[.Linear_Repeat], index: 0)
            renderCommandEncoder.setFragmentTexture(Entities.Textures[textureType], index: 0)
        }

        terrainMesh.drawPrimitives(renderCommandEncoder)
    }
    
}

//Material Getters / Setters
extension TerrainGameObject: Materialable { }
