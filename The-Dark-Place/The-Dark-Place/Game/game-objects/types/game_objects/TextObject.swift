import MetalKit

class TextObject: Node {
    
    var textMesh: TextMesh!
    var fontType: FontTypes!
    var fontSize: Float!
    var currentText: String!
    var projectionMatrix: matrix_float4x4!
    init(initialText: String, fontType: FontTypes, fontSize: Float) {
        super.init()
        self.fontType = fontType
        self.fontSize = fontSize
        self.currentText = initialText
        self.projectionMatrix = matrix_float4x4.orthographic(width: 1, height: 1, near: -1, far: 1)
        textMesh = Entities.TextMeshes[initialText, fontType, fontSize]
        self.offset.x = -textMesh.totalWidth / 2
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
        renderCommandEncoder.setVertexBytes(&projectionMatrix, length: matrix_float4x4.stride, index: 1)
        textMesh.drawPrimitives(renderCommandEncoder)
    }
}
