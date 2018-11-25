import MetalKit

public class TextMesh: Mesh{
    var instanceCount: Int = 1
    var minBounds: float3 = float3(0)
    var maxBounds: float3 = float3(0)
    var cubeBoundsMesh: CubeBoundsMesh!
    
    var vertexBuffer: MTLBuffer!
    var vertexCount: Int!
    var textMeshData: TextMeshData!
    
    var fontFileName: String!
    var fontTextureType: TextureTypes!
    
    init(fontMapFileName: String, fontTextureType: TextureTypes, text: String) {
        createBuffers(text: text)
    }
    
    private func createBuffers(text: String) {
        let textMeshData = TextMeshData(text: text)
        self.vertexCount = textMeshData.vertexCount
        self.vertexBuffer = DarkEngine.Device.makeBuffer(bytes: textMeshData.vertices, length: Vertex.stride(textMeshData.vertexCount), options: [])!
    }
    
    func drawPrimitives(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: vertexCount)
        renderCommandEncoder.setFragmentTexture(Entities.Textures[fontTextureType], index: 0)
        
        renderCommandEncoder.drawPrimitives(type: .triangle,
                                            vertexStart: 0,
                                            vertexCount: vertexCount,
                                            instanceCount: instanceCount)
    }

}


class TextMeshData {
    private var _vertices: [Vertex] = []
    public var vertices: [Vertex] { return _vertices }
    public var vertexCount: Int { return vertices.count }
    
    init(text: String) {
        
    }
    
}
