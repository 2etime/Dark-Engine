
import MetalKit

public enum FontTypes {
    case Luminari
    case OperatorFont
}

class FontLibrary: Library<FontTypes, Font> {
    
    private var library: [FontTypes : Font] = [:]
    
    override func fillLibrary() {
        library.updateValue(Font("OperatorFont", textureType: .OperatorFont), forKey: .OperatorFont)
        library.updateValue(Font("Luminari", textureType: .Luminari), forKey: .Luminari)
    }
    
    override subscript(_ type: FontTypes) -> Font {
        return (library[type])!
    }
}

class Font {
    private let DESIRED_PADDING: Int = 3
    
    private let PAD_TOP: Int = 0
    private let PAD_LEFT: Int = 1
    private let PAD_BOTTOM: Int = 2
    private let PAD_RIGHT: Int = 3
    
    private var imageWidth: Int = 0
    private var imageHeight: Int = 0
    
    private var paddingLeft: Int = 0
    private var paddingRight: Int = 0
    private var paddingTop: Int = 0
    private var paddingBottom: Int = 0
    
    private var paddingWidth: Int = 0
    private var paddingHeight: Int = 0
    
    var spaceWidth: Float = 0
    var texture: MTLTexture!
    
    private var verticalPerPixelSize: Float = 0
    private var horizontalPerPixelSize: Float = 0
    
    private var characterDict: [Int:CharacterData] = [:]
   
    init(_ fontFileName: String, textureType: TextureTypes) {
        texture = Entities.Textures[textureType]
        let reader = BufferedFileReader(bundleFileName: fontFileName)
        
        while(reader.hasNextLine){
            let fontLineData = FontLineData(reader.nextLine()!)
            switch fontLineData.name.lowercased() {
            case "info":
                loadPaddingData(fontLineData: fontLineData)
                break
            case "common":
                loadLineSizes(fontLineData: fontLineData)
                break
            case "char":
                let value = loadCharacterData(fontLineData: fontLineData)
                let key = value?.id
                if(key != nil){
                    characterDict.updateValue(value!, forKey: key!)
                }
                break
            default:
                break
            }
        }
    }
    
    private func loadLineSizes(fontLineData: FontLineData) {
        let defaultLineHeight: Float = 0.03
        
        let lineHeightPixels: Float = Float(fontLineData["lineHeight"]!)! - Float(paddingHeight)
        self.verticalPerPixelSize = defaultLineHeight / lineHeightPixels
        self.horizontalPerPixelSize = verticalPerPixelSize / GameView.AspectRatio
        self.imageWidth = Int(fontLineData["scaleW"]!)!
        self.imageHeight = Int(fontLineData["scaleH"]!)!
    }
    
    private func loadPaddingData(fontLineData: FontLineData) {
        let padding = fontLineData["padding"]?.toIntArray()
        self.paddingLeft = padding?[PAD_LEFT] ?? 0
        self.paddingRight = padding?[PAD_RIGHT] ?? 0
        self.paddingTop = padding?[PAD_TOP] ?? 0
        self.paddingBottom = padding?[PAD_BOTTOM] ?? 0
        self.paddingWidth = self.paddingLeft + self.paddingRight
        self.paddingHeight = self.paddingTop + self.paddingBottom
    }
    
    private func loadCharacterData(fontLineData: FontLineData)->CharacterData? {
        let id = fontLineData["id"]!.intValue

        if(id == 32) {
            self.spaceWidth = Float(fontLineData["xadvance"]!.intValue - paddingWidth) * Float(horizontalPerPixelSize)
            return nil
        }
        let xTex = Float(fontLineData["x"]!.intValue + (self.paddingLeft - DESIRED_PADDING)) / Float(self.imageWidth)
        let yTex = Float(fontLineData["y"]!.intValue + (self.paddingTop - DESIRED_PADDING)) / Float(self.imageHeight)
        let width = fontLineData["width"]!.intValue - (paddingWidth - ( DESIRED_PADDING))
        let height = fontLineData["height"]!.intValue - (paddingHeight - (DESIRED_PADDING))
        
        let quadWidth: Float = Float(width) * horizontalPerPixelSize
        let quadHeight: Float = Float(height) * verticalPerPixelSize
        
        let xTexSize: Float = Float(width) / Float(imageWidth)
        let yTexSize: Float = Float(height) / Float(imageHeight)
        
        let xOffset = Float(fontLineData["xoffset"]!.intValue + paddingLeft - DESIRED_PADDING) * Float(horizontalPerPixelSize)
        let yOffset = Float(fontLineData["yoffset"]!.intValue + paddingTop - DESIRED_PADDING) * Float(verticalPerPixelSize)
        
        let xAdvance = Float(fontLineData["xadvance"]!.intValue) * horizontalPerPixelSize
        
        return CharacterData(id: id,
                             xTextureCoord: xTex, yTextureCoord: yTex,
                             xTextureSize: xTexSize, yTextureSize: yTexSize,
                             xOffset: xOffset, yOffset: yOffset,
                             sizeX: quadWidth, sizeY: quadHeight,
                             xAdvance: xAdvance)
    }
    
    public func getCharacter(_ char: String)->CharacterData {
        let code = char.asciiCode
        return characterDict[code]!
    }
}

private class FontLineData {
    private var _name: String = "No Name"
    public var name: String {
        return _name
    }
    private var _lineValues: [String: String] = [:]
    
    init(_ line: String) {
        for part in line.split(" ") {
            let valuePairs = part.split("=")
            if(valuePairs.count == 2){
                _lineValues.updateValue(valuePairs[1], forKey: valuePairs[0])
            }else if(valuePairs.count > 0) {
                _name = valuePairs[0]
            }
        }
    }
    
    subscript(_ key: String)->String? {
        if(_lineValues.keys.contains(key)){
            return _lineValues[key]
        }else {
            return nil
        }
    }
}

public class CharacterData {
    var id: Int!
    var xTextureCoord: Float!
    var yTextureCoord: Float!
    var xMaxTextureCoord: Float!
    var yMaxTextureCoord: Float!
    var xOffset: Float!
    var yOffset: Float!
    var sizeX: Float!
    var sizeY: Float!
    var xAdvance: Float!
    
    init(id: Int,
         xTextureCoord: Float, yTextureCoord: Float,
         xTextureSize: Float, yTextureSize: Float,
         xOffset: Float, yOffset: Float,
         sizeX: Float, sizeY: Float,
         xAdvance: Float) {
        self.id = id
        self.xTextureCoord = xTextureCoord
        self.yTextureCoord = yTextureCoord
        self.xOffset = xOffset
        self.yOffset = yOffset
        self.sizeX = sizeX
        self.sizeY = sizeY
        self.xMaxTextureCoord = xTextureSize + xTextureCoord
        self.yMaxTextureCoord = yTextureSize + yTextureCoord
        self.xAdvance = xAdvance
    }
    
    func generateVertices(cursor: float2, fontSize: Float)->[Vertex] {
        let xPos: Float = cursor.x + (xOffset * fontSize) 
        let yPos: Float = cursor.y + (yOffset * fontSize)
        let maxXPos: Float = xPos + (sizeX * fontSize)
        let maxYPos: Float = yPos + (sizeY * fontSize)
        
        let xTex: Float = xTextureCoord
        let yTex: Float = yTextureCoord
        let maxXTex: Float = xMaxTextureCoord
        let maxYTex: Float = yMaxTextureCoord
        
        let position1 = float3(xPos, yPos, 0)
        let textureCoord1 = float2(xTex, maxYTex)
        let vertex1 = Vertex(position: position1, normal: float3(0), textureCoordinate: textureCoord1)
        
        let position2 = float3(xPos, maxYPos, 0)
        let textureCoord2 = float2(xTex, yTex)
        let vertex2 = Vertex(position: position2, normal: float3(0), textureCoordinate: textureCoord2)
        
        let position3 = float3(maxXPos, maxYPos, 0)
        let textureCoord3 = float2(maxXTex, yTex)
        let vertex3 = Vertex(position: position3, normal: float3(0), textureCoordinate: textureCoord3)
        
        let position4 = float3(maxXPos, maxYPos, 0)
        let textureCoord4 = float2(maxXTex, yTex)
        let vertex4 = Vertex(position: position4, normal: float3(0), textureCoordinate: textureCoord4)
        
        let position5 = float3(xPos, yPos, 0)
        let textureCoord5 = float2(xTex, maxYTex)
        let vertex5 = Vertex(position: position5, normal: float3(0), textureCoordinate: textureCoord5)
        
        let position6 = float3(maxXPos, yPos, 0)
        let textureCoord6 = float2(maxXTex, maxYTex)
        let vertex6 = Vertex(position: position6, normal: float3(0), textureCoordinate: textureCoord6)
    
        return [vertex1, vertex2, vertex3, vertex4, vertex5, vertex6]
    }
    
    
}


