
import MetalKit

class TextMeshLibrary: Library<String, TextMesh>  {
    
    private var library: [String : TextMesh] = [:]
    
    func addTextMesh(key: String,
                     text: String,
                     fontType: FontTypes,
                     fontSize: Float,
                     isCentered: Bool = false,
                     maxLineLength: Float = 1,
                     margin: float4 = float4(0))->TextMesh {
        let textMesh = TextMesh(text: text,
                                fontType: fontType,
                                fontSize: fontSize,
                                isCentered: isCentered,
                                maxLineLength: maxLineLength,
                                margin: margin)
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
    
    var lineHeight: Float!
    var fontType: FontTypes!
    var fontSize: Float!
    var currentText: String!
    var totalWidth: Float = 0
    var maxLineLength: Float!
    var isCentered: Bool!
    var marginLeft: Float = 0
    var marginRight: Float = 0
    var marginTop: Float = 0
    var marginBottom: Float = 0
    
    var lines: [Line] = []
    
    init(text: String,
         fontType: FontTypes,
         fontSize: Float,
         isCentered: Bool = false,
         maxLineLength: Float = 1.0,
         margin: float4 = float4(0)) {
        self.fontType = fontType
        self.fontSize = fontSize
        self.currentText = text
        self.maxLineLength = maxLineLength
        self.isCentered = isCentered
        self.marginTop = margin.x
        self.marginRight = margin.y
        self.marginBottom = margin.z
        self.marginLeft = margin.w
        generateLines()
        generateTextVertices()
        generateBuffer()
    }
    
    func updateText(text: String) {
        self.currentText = text
        generateLines()
        generateTextVertices()
        generateBuffer()
    }
    
    func updateFont(fontType: FontTypes) {
        self.fontType = fontType
        generateLines()
        generateTextVertices()
        updateBuffer()
    }
    
    func updateFontSize(size: Float){
        self.fontSize = size
        generateLines()
        generateTextVertices()
        updateBuffer()
    }
    
    func generateLines() {
        lines = []
        let font = Entities.Fonts[fontType]
        var currentLine: Line = Line(spaceWidth: font.spaceWidth, fontSize: fontSize, maxLineLength: maxLineLength)
        var currentWord: Word = Word(fontSize: fontSize)
        var addedLastLine: Bool = false
        for stringCharacter in currentText {
            if(stringCharacter == "\n"){
                lines.append(currentLine)
                currentLine.addWord(word: currentWord)
                currentLine = Line(spaceWidth: font.spaceWidth, fontSize: fontSize, maxLineLength: maxLineLength)
                currentWord = Word(fontSize: fontSize)
            }else {
                if(stringCharacter != " ") {
                    addedLastLine = false
                    let character = font.getCharacter(String(stringCharacter))
                    currentWord.addCharacter(character)
                } else {
                    if(currentLine.canAddWord(word: currentWord, marginRight: marginRight)){
                        addedLastLine = true
                        currentLine.addWord(word: currentWord)
                        currentWord = Word(fontSize: fontSize)
                    }else {
                        lines.append(currentLine)
                        currentLine = Line(spaceWidth: font.spaceWidth, fontSize: fontSize, maxLineLength: maxLineLength)
                        currentLine.addWord(word: currentWord)
                        currentWord = Word(fontSize: fontSize)
                    }
                }
            }
        }
        if(!addedLastLine) {
            if(currentLine.canAddWord(word: currentWord, marginRight: marginRight)){
                currentLine.addWord(word: currentWord)
            }else {
                lines.append(currentLine)
                currentLine = Line(spaceWidth: font.spaceWidth, fontSize: fontSize, maxLineLength: maxLineLength)
                currentLine.addWord(word: currentWord)
            }
            lines.append(currentLine)
        }
    }

    func generateTextVertices() {
        vertices = []
        let font = Entities.Fonts[fontType]
        self.spaceWidth = font.spaceWidth
        var cursor: float2 = float2(marginLeft, marginTop)
        cursor.y += 0.15
        for line in lines {
            if(self.isCentered){
                cursor.x = (line.maxLength - line.currentLineLength) / 2
            }
            for word in line.words {
                for character in word.characters {
                    vertices.append(contentsOf: character.generateVertices(cursor: cursor,
                                                                           fontSize: fontSize))
                    cursor.x += character.xAdvance * fontSize
                }
                cursor.x += spaceWidth * fontSize
            }
            cursor.y -= 0.03 * fontSize
            cursor.x = marginLeft
        }
    }
    
    private func updateBuffer() {
        let x = vertexBuffer.contents().bindMemory(to: Vertex.self, capacity: vertexCount)
        x.assign(from: vertices, count: vertexCount)
    }
    
    func generateBuffer() {
        self.vertexBuffer = nil
        self.vertexCount = vertices.count
        self.vertexBuffer = DarkEngine.Device.makeBuffer(bytes: vertices,
                                                         length: Vertex.stride(vertices.count),
                                                         options: [])
    }

    func drawPrimitives(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        let font = Entities.Fonts[fontType]
        switch font.fontGraphicStyle! {
        case .Basic:
            renderCommandEncoder.setRenderPipelineState(Graphics.RenderPipelineStates[.BasicFont])
        case .FieldDistanced:
            renderCommandEncoder.setRenderPipelineState(Graphics.RenderPipelineStates[.FieldDistanceFont])
        }

        renderCommandEncoder.setFragmentSamplerState(Graphics.SamplerStates[.Linear], index: 0)
        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.setFragmentTexture(Entities.Fonts[fontType].texture, index: 0)
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertexCount)
    }
}

class Line {
    var maxLength: Float = 0
    var spaceSize: Float = 0
    
    var words: [Word] = []
    var currentLineLength: Float = 0
    
    init(spaceWidth: Float, fontSize: Float, maxLineLength: Float){
        self.maxLength = maxLineLength
        self.spaceSize = spaceWidth * fontSize
    }
    
    func canAddWord(word: Word, marginRight: Float)->Bool {
        var additionalLength = word.wordWidth
        additionalLength += !words.isEmpty ? spaceSize : 0
        return currentLineLength + additionalLength + marginRight <= maxLength
    }
    
    func addWord(word: Word) {
        var additionalLength = word.wordWidth
        additionalLength += !words.isEmpty ? spaceSize : 0
        words.append(word)
        currentLineLength += additionalLength
    }
}

class Word {
    
    var characters: [CharacterData] = []
    var wordWidth: Float = 0
    var fontSize: Float = 0
    init(fontSize: Float) {
        self.fontSize = fontSize
    }
    
    func addCharacter(_ character: CharacterData) {
        self.wordWidth += character.xAdvance * fontSize;
        self.characters.append(character)
    }
    
}
