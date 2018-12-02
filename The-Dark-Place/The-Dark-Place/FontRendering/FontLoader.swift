import simd
import Foundation

class FontLoader {
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
    
    private var spaceWidth: Float = 0
    
    private var verticalPerPixelSize: Float = 0
    private var horizontalPerPixelSize: Float = 0
    
    private var characterDict: [Int:FontCharacter] = [:]

    init(fontFileName: String) {
        
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
    
    public func getFontCharacter(_ word: String, fontSize: Float)->[Vertex]{
        let codes = word.asciiCodes
        var vertices: [Vertex] = []
        var cursor: float2 = float2(0)
        for code in codes {
            if(code == 32){
                cursor.x += spaceWidth * fontSize * 2
            }else {
                let character = characterDict[code]!
                character.generateVertices(cursor: cursor, fontSize: fontSize)
                cursor.x += character.xAdvance * fontSize
                vertices.append(contentsOf: character.vertices)
            }
        }
        return vertices
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
    
    private func loadCharacterData(fontLineData: FontLineData)->FontCharacter? {
        let id = fontLineData["id"]!.intValue
        if(id == 32) {
            self.spaceWidth = Float(fontLineData["xadvance"]!.intValue - paddingWidth) * Float(horizontalPerPixelSize)
            return nil
        }
        let xTex = Float(fontLineData["x"]!.intValue + (self.paddingLeft - DESIRED_PADDING)) / Float(self.imageWidth)
        let yTex = Float(fontLineData["y"]!.intValue + (self.paddingTop - DESIRED_PADDING)) / Float(self.imageHeight)
        let width = fontLineData["width"]!.intValue - (paddingWidth - (2 * DESIRED_PADDING))
        let height = fontLineData["height"]!.intValue - (paddingHeight - (2 * DESIRED_PADDING))
        
        let quadWidth: Float = Float(width) * horizontalPerPixelSize
        let quadHeight: Float = Float(height) * verticalPerPixelSize
        
        let xTexSize: Float = Float(width) / Float(imageWidth)
        let yTexSize: Float = Float(height) / Float(imageHeight)
        
        let xOffset = Float(fontLineData["xoffset"]!.intValue + paddingLeft - DESIRED_PADDING) * Float(horizontalPerPixelSize)
        let yOffset = Float(fontLineData["yoffset"]!.intValue + paddingTop - DESIRED_PADDING) * Float(verticalPerPixelSize)
        
        let xAdvance = Float(fontLineData["xadvance"]!.intValue - paddingWidth) * horizontalPerPixelSize

        return FontCharacter(id: id,
                             xTextureCoord: xTex, yTextureCoord: yTex,
                             xTextureSize: xTexSize, yTextureSize: yTexSize,
                             xOffset: xOffset, yOffset: yOffset,
                             sizeX: quadWidth, sizeY: quadHeight,
                             xAdvance: xAdvance)
    }
    
}

private class FontLineData {
    //Key=char value
    //Value=attribute value
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
