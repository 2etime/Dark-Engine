
import MetalKit

class TextMeshLibrary: Library<String, TextMesh>  {
    
    private var library: [String : TextMesh] = [:]
    
    func addTextMesh(key: String, text: String, fontType: FontTypes, fontSize: Float)->TextMesh {
        let textMesh = TextMesh(text: text, fontType: fontType, fontSize: fontSize)
        library.updateValue(textMesh, forKey: key)
        return textMesh
    }
    
    override subscript(_ index: String) -> TextMesh {
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
    var vertices: [Vertex]!
    
    var spaceWidth: Float!
    
    var fontType: FontTypes!
    var fontSize: Float!
    var currentText: String!
    var totalWidth: Float = 0
    
    init(text: String, fontType: FontTypes, fontSize: Float) {
        self.fontType = fontType
        self.fontSize = fontSize
        self.currentText = text
        generateTextVertices()
        generateBuffer()
    }
    
    func updateText(text: String) {
        self.currentText = text
        generateTextVertices()
        updateBuffer()
    }
    
    func updateFont(fontType: FontTypes) {
        self.fontType = fontType
        generateTextVertices()
        updateBuffer()
    }
    
    func generateTextVertices() {
        vertices = []
        let font = Entities.Fonts[fontType]
        self.spaceWidth = font.spaceWidth
        var cursor: float2 = float2(0)
        for stringCharacter in currentText {
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
    
    private func updateBuffer() {
        let x = vertexBuffer.contents().bindMemory(to: Vertex.self, capacity: vertexCount)
        x.assign(from: vertices, count: vertexCount)
    }
    
    func generateBuffer() {
        self.vertexCount = vertices.count
        self.vertexBuffer = DarkEngine.Device.makeBuffer(bytes: vertices,
                                                    length: Vertex.stride(vertices.count),
                                                    options: [])
    }

    func drawPrimitives(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(Graphics.RenderPipelineStates[.Text])
        renderCommandEncoder.setFragmentSamplerState(Graphics.SamplerStates[.Nearest], index: 0)
        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.setFragmentTexture(Entities.Fonts[fontType].texture, index: 0)
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertexCount)
    }
}
