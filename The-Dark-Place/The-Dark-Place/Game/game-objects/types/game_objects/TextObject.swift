import MetalKit

class TextObject: Node {
    
    var textMesh: TextMesh!
    var fontType: FontTypes!
    var fontSize: Float!
    var currentText: String!
    init(initialText: String, fontType: FontTypes, fontSize: Float) {
        super.init()
        self.fontType = fontType
        self.fontSize = fontSize
        self.currentText = initialText
        textMesh = Entities.TextMeshes[initialText, fontType, fontSize]
        self.offset.x = 0
    }
    
    public func updateText(_ text: String) {
        if(text != currentText){
            textMesh = Entities.TextMeshes[text, fontType, fontSize]
            currentText = text
        }
    }
    
}

extension TextObject: Renderable {
    func doZPass(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        
    }
    
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        textMesh.drawPrimitives(renderCommandEncoder)
    }
}
