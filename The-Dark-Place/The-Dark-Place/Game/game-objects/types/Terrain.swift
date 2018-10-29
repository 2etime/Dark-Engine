
import MetalKit

class Terrain: Node {
    
    internal var material: Material! = Material()
    private var terrainMesh: Mesh!

    init(cellCount: Int) {
        super.init(name: "Terrain")
        terrainMesh = TerrainLoader.GenerateTerrainMesh(cellCount: cellCount)
    }

}

extension Terrain: Renderable {
    
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(Graphics.RenderPipelineStates[.TerrainTextured])
        renderCommandEncoder.setDepthStencilState(Graphics.DepthStencilStates[.Less])
        renderCommandEncoder.setCullMode(.none)

        renderCommandEncoder.setFragmentBytes(&material, length: Material.stride, index: 0)
        renderCommandEncoder.setFragmentTexture(Entities.Textures[.Grass], index: 0)
        
        terrainMesh.drawPrimitives(renderCommandEncoder)
    }
    
}

//Material Getters / Setters
extension Terrain: Materialable { }
