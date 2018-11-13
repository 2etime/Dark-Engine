
import MetalKit

class Terrain: Node {
    
    internal var material: Material! = Material()
    private var terrainMesh: Mesh!
    private var terrainSize: Int32 = 0

    init(cellCount: Int) {
        super.init(name: "Terrain")
        self.terrainSize = Int32(cellCount)
        terrainMesh = TerrainLoader.GenerateTerrainMesh(cellCount: cellCount)
    }

}

extension Terrain: Renderable {
    
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        if(false){
            renderCommandEncoder.setRenderPipelineState(Graphics.RenderPipelineStates[.TerrainTextured])
            renderCommandEncoder.setDepthStencilState(Graphics.DepthStencilStates[.Less])
            renderCommandEncoder.setFragmentBytes(&material, length: Material.stride, index: 0)
            renderCommandEncoder.setFragmentTexture(Entities.Textures[.Grass], index: 0)
            renderCommandEncoder.setFragmentSamplerState(Graphics.SamplerStates[.Linear_Repeat], index: 0)
        }else {
            renderCommandEncoder.setRenderPipelineState(Graphics.RenderPipelineStates[.TerrainMultiTextured])
            renderCommandEncoder.setDepthStencilState(Graphics.DepthStencilStates[.Less])
            
            renderCommandEncoder.setFragmentBytes(&material, length: Material.stride, index: 0)
            renderCommandEncoder.setFragmentBytes(&terrainSize, length: Int32.stride, index: 2)
            
            renderCommandEncoder.setFragmentTexture(Entities.Textures[.Grass], index: 0) //background
            renderCommandEncoder.setFragmentTexture(Entities.Textures[.Grass], index: 1) //r
            renderCommandEncoder.setFragmentTexture(Entities.Textures[.Grass], index: 2) //g
            renderCommandEncoder.setFragmentTexture(Entities.Textures[.Grass], index: 3) //b
            renderCommandEncoder.setFragmentTexture(Entities.Textures[.BlendMap], index: 4) //blend
            
            renderCommandEncoder.setFragmentSamplerState(Graphics.SamplerStates[.Linear_Repeat], index: 0)
            renderCommandEncoder.setFragmentSamplerState(Graphics.SamplerStates[.Linear], index: 1)
        }

        
        terrainMesh.drawPrimitives(renderCommandEncoder)
    }
    
}

//Material Getters / Setters
extension Terrain: Materialable { }
