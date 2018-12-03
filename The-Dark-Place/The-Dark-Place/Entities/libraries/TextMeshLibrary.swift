
import MetalKit

class TextMeshLibrary {
    
    private var library: [String : TextMesh] = [:]
    
    init(){
        fillLibrary()
    }
    
    func fillLibrary() {
        library.updateValue(TextMesh(text: "ABCDEFGHIJKLMNOPQRSTUVWXYZ", fontType: .OperatorFont, fontSize: 3), forKey: "Alphabet")
    }
    
    subscript(_ index: String) -> Mesh {
        return (library[index])!
    }
    
}

class TextMesh: Mesh {
    var instanceCount: Int = 0
    var minBounds: float3 = float3(0)
    var maxBounds: float3 = float3(0)
    var cubeBoundsMesh: CubeBoundsMesh!
    
    var vertexCount: Int = 0
    var vertexBuffer: MTLBuffer!
    var vertices: [Vertex] = []
    
    var spaceWidth: Float! = 0.1
    var font: Font!
    
    init(text: String, fontType: FontTypes, fontSize: Float) {
        font = Entities.Fonts[fontType]
        var cursor: float2 = float2(0)
        for stringCharacter in text {
            if(stringCharacter == " "){
                cursor.x += spaceWidth * fontSize
            }else {
                let character = font.getCharacter(String(stringCharacter))
                character.generateVertices(cursor: cursor, fontSize: fontSize)
                vertices.append(contentsOf: character.vertices)
                cursor.x += character.xAdvance * fontSize
            }
        }
        generateBuffer()
    }
    
    func generateBuffer() {
        self.vertexCount = vertices.count
        self.vertexBuffer = DarkEngine.Device.makeBuffer(bytes: vertices,
                                                    length: Vertex.stride(vertices.count),
                                                    options: [])
    }

    func drawPrimitives(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(Graphics.RenderPipelineStates[.Text])
        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.setFragmentSamplerState(Graphics.SamplerStates[.Linear], index: 0)
        renderCommandEncoder.setFragmentTexture(font.texture, index: 0)
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertexCount)
    }
}
