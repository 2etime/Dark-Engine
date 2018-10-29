
import MetalKit

class Terrain: Node {
    
    internal var material: Material! = Material()
    var terrainMesh: Mesh!
    
    private var _vertexCount: Int = 0
    
    init(cellCount: Int) {
        super.init(name: "Terrain")
        self._vertexCount = cellCount + 1
        terrainMesh = TerrainGenerator.GenerateTerrainMesh(cellCount: cellCount)
    }

}

extension Terrain: Renderable {
    
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(Graphics.RenderPipelineStates[.TerrainTextured])
        renderCommandEncoder.setDepthStencilState(Graphics.DepthStencilStates[.Less])

        renderCommandEncoder.setFragmentBytes(&material, length: Material.stride, index: 0)
        renderCommandEncoder.setFragmentTexture(Entities.Textures[.Grass], index: 0)
        
        terrainMesh.drawPrimitives(renderCommandEncoder)
    }
    
}

//Material Getters / Setters
extension Terrain: Materialable { }
