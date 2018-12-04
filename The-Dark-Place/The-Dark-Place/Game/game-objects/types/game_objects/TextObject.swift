import MetalKit
import Foundation

class TextObject: Node {
    
    var guid: String!
    var textMesh: TextMesh!
    var fontType: FontTypes!
    var fontSize: Float!
    var currentText: String!
    var projectionMatrix: matrix_float4x4!
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
        self.projectionMatrix = matrix_float4x4.orthographic(width: 1, height: 1, near: -1, far: 1)
        self.textMesh = Entities.TextMeshes.addTextMesh(key: guid,
                                                        text: initialText,
                                                        fontType: fontType,
                                                        fontSize: fontSize,
                                                        isCentered: isCentered,
                                                        maxLineLength: maxLineLength,
                                                        margin: margin)
    }
    
    public func updateText(_ text: String) {
        Entities.TextMeshes[guid].updateText(text: text)
    }
    
    public func updateFont(_ fontType: FontTypes){
        Entities.TextMeshes[guid].updateFont(fontType: fontType)
    }
    
}

extension TextObject: Renderable {
    func doZPass(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        
    }
    
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setVertexBytes(&projectionMatrix, length: matrix_float4x4.stride, index: 1)
        textMesh.drawPrimitives(renderCommandEncoder)
    }
}
