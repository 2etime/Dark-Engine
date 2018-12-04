
import MetalKit

class TextMeshLibrary: Library<String, TextMesh>  {
    
    private var library: [String : TextMesh] = [:]
    
    func addTextMesh(key: String, text: String, fontType: FontTypes, fontSize: Float,maxLineLength: Float = 1)->TextMesh {
        let textMesh = TextMesh(text: text, fontType: fontType, fontSize: fontSize, maxLineLength: maxLineLength)
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
    
    var lines: [Line] = []
    
    init(text: String, fontType: FontTypes, fontSize: Float, maxLineLength: Float = 1.0) {
        self.fontType = fontType
        self.fontSize = fontSize
        self.currentText = text
        self.maxLineLength = maxLineLength
        generateLines()
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
    
    func generateLines() {
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
                    if(currentLine.canAddWord(word: currentWord)){
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
            lines.append(currentLine)
        }
    }

//    private void completeStructure(List<Line> lines, Line currentLine, Word currentWord, GUIText text) {
//    boolean added = currentLine.attemptToAddWord(currentWord);
//    if (!added) {
//    lines.add(currentLine);
//    currentLine = new Line(metaData.getSpaceWidth(), text.getFontSize(), text.getMaxLineSize());
//    currentLine.attemptToAddWord(currentWord);
//    }
//    lines.add(currentLine);
//    }
    
//    func generateTextVertices() {
//        vertices = []
//        var isSpaced: Bool = false
//        let font = Entities.Fonts[fontType]
//        self.spaceWidth = font.spaceWidth
//        var cursor: float2 = float2(0)
//        for stringCharacter in currentText {
//            if(stringCharacter == "\n"){
//                cursor.y -= 0.03 * fontSize
//                cursor.x = 0
//            }else if(stringCharacter == " "){
//                isSpaced = true
//                cursor.x += spaceWidth * fontSize
//            }else {
//                let character = font.getCharacter(String(stringCharacter))
//                if(isSpaced && (cursor.x + character.xAdvance) * fontSize >= maxLineLength - 0.01){
//                    cursor.y -= 0.03 * fontSize
//                    cursor.x = 0
//                }
//                isSpaced = false
//                vertices.append(contentsOf: character.generateVertices(cursor: cursor,
//                                                                       fontSize: fontSize))
//                cursor.x += character.xAdvance * fontSize
//                totalWidth += character.xAdvance * fontSize
//            }
//        }
//    }
    
    func generateTextVertices() {
        vertices = []
        let font = Entities.Fonts[fontType]
        self.spaceWidth = font.spaceWidth
        var cursor: float2 = float2(0)
        for line in lines {
            cursor.y -= 0.03 * fontSize
            cursor.x = 0
            for word in line.words {
                for character in word.characters {
                    vertices.append(contentsOf: character.generateVertices(cursor: cursor,
                                                                           fontSize: fontSize))
                    cursor.x += character.xAdvance * fontSize
                }
                cursor.x += spaceWidth * fontSize
            }
        }
    }
    
    private func updateBuffer() {
        let x = vertexBuffer.contents().bindMemory(to: Vertex.self, capacity: vertexCount)
        x.assign(from: vertices, count: vertexCount)
    }
    
    func generateBuffer() {
        if(vertices.count > 0){
            self.vertexCount = vertices.count
        }else{
            self.vertices.append(Vertex(position: float3(0), normal: float3(0), textureCoordinate: float2(0)))
        }
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

class Line {
    var maxLength: Float = 0
    var spaceSize: Float = 0
    
    var words: [Word] = []
    var currentLineLength: Float = 0
    
    init(spaceWidth: Float, fontSize: Float, maxLineLength: Float){
        self.maxLength = maxLineLength
        self.spaceSize = spaceWidth * fontSize
    }
    
    func canAddWord(word: Word)->Bool {
        var additionalLength = word.wordWidth
        additionalLength += !words.isEmpty ? spaceSize : 0
        return currentLineLength + additionalLength <= maxLength
    }
    
    func addWord(word: Word) {
        var additionalLength = word.wordWidth
        additionalLength += spaceSize
        currentLineLength += additionalLength
        words.append(word)
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
