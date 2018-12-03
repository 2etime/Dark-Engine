
import MetalKit

class TextMeshLibrary: Library<String, TextMesh>  {
    
    private var library: [String : TextMesh] = [:]
    
    override func fillLibrary() {

    }
    
    override subscript(_ index: String) -> TextMesh {
        return (library[index])!
    }
    
    subscript(_ text: String, fontType: FontTypes, fontSize: Float)->TextMesh {
        var result: TextMesh? = library[text]
        if(result == nil){
            result = TextMesh(text: text, fontType: fontType, fontSize: fontSize)
        }
        return result!
    }
    
}

class TextMesh: Mesh {
    var instanceCount: Int = 0
    var minBounds: float3 = float3(0)
    var maxBounds: float3 = float3(0)
    var cubeBoundsMesh: CubeBoundsMesh!
    
    var vertexCount: Int = 0
    var vertexBuffer: MTLBuffer!
    var vertices: [Vertex]!
    
    var spaceWidth: Float!
    var font: Font!
    
    var totalWidth: Float = 0
    
    init(text: String, fontType: FontTypes, fontSize: Float) {
        generateText(text: text, fontType: fontType, fontSize: fontSize)
        generateBuffer()
    }
    
    func generateText(text: String, fontType: FontTypes, fontSize: Float) {
        vertices = []
        font = Entities.Fonts[fontType]
        self.spaceWidth = font.spaceWidth
        var cursor: float2 = float2(0)
        for stringCharacter in text {
            if(stringCharacter == " "){
                cursor.x += spaceWidth * fontSize
            }else {
                let character = font.getCharacter(String(stringCharacter))
                vertices.append(contentsOf: character.generateVertices(cursor: cursor, fontSize: fontSize))
                cursor.x += character.xAdvance * fontSize
                totalWidth += character.xAdvance * fontSize
            }
        }
    }
    
    func generateBuffer() {
        self.vertexCount = vertices.count
        self.vertexBuffer = DarkEngine.Device.makeBuffer(bytes: vertices,
                                                    length: Vertex.stride(vertices.count),
                                                    options: [])
    }

    func drawPrimitives(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(Graphics.RenderPipelineStates[.Text])
        renderCommandEncoder.setFragmentSamplerState(Graphics.SamplerStates[.Linear], index: 0)
        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.setFragmentTexture(font.texture, index: 0)
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertexCount)
    }
}
