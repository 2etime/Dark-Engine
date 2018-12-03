import MetalKit

class TextObject: Node {
    
    var textMesh: TextMesh!
    var fontType: FontTypes!
    var fontSize: Float!
    var currentText: String!
    init(_ text: String, fontType: FontTypes, fontSize: Float) {
        super.init()
        self.fontType = fontType
        self.fontSize = fontSize
        self.currentText = text
        textMesh = Entities.TextMeshes[text, fontType, fontSize]
    }
    
    public func updateText(_ text: String) {
        if(text != currentText){
            textMesh = Entities.TextMeshes[text, fontType, fontSize]
            currentText = text
        }
    }
    
    override func render(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        textMesh.drawPrimitives(renderCommandEncoder)
        super.render(renderCommandEncoder)
    }
    
}
