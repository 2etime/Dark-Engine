import MetalKit
import Foundation

class TextObject: Node {
    
    var guid: String!
    var textMesh: TextMesh!
    var fontType: FontTypes!
    var fontSize: Float!
    var currentText: String!
    
    var textData = TextData()
    init(initialText: String,
         fontType: FontTypes,
         fontSize: Float,
         isCentered: Bool = false,
         maxLineLength: Float = 1.0,
         margin: float4 = float4(0)) {
        super.init()
        self.guid = NSUUID().uuidString
        self.fontType = fontType
        self.fontSize = fontSize
        self.currentText = initialText
        self.textMesh = Entities.TextMeshes.addTextMesh(key: guid,
                                                        text: initialText,
                                                        fontType: fontType,
                                                        fontSize: fontSize,
                                                        isCentered: isCentered,
                                                        maxLineLength: maxLineLength,
                                                        margin: margin)
        textData = TextData()
        textData.edge = 0.02
        textData.width = 0.51
        self.offset.y -= 0.15
    }
    
    public func updateText(_ text: String) {
        Entities.TextMeshes[guid].updateText(text: text)
    }
    
    public func updateFont(_ fontType: FontTypes){
        Entities.TextMeshes[guid].updateFont(fontType: fontType)
    }
    
    public func updateFontSize(_ size: Float){
        Entities.TextMeshes[guid].updateFontSize(size: size)
    }
}

extension TextObject: Renderable {
    func doZPass(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        
    }
    
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setFragmentBytes(&textData, length: TextData.stride, index: 1)
        textMesh.drawPrimitives(renderCommandEncoder)
    }
}
