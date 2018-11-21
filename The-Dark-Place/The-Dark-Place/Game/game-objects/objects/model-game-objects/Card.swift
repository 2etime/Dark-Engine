import MetalKit

class Card: GameObject {
    var animation: Animation2D!
    init(){
        super.init(.Quad_Custom)
        
        self.animation = Animations.Animation2D[.Barbarian]
        
        self.offset.y = 1
        self.setName("Card")
        self.material.color = float4(1)
    }
    
    override func onUpdate() {
        animation.runAnimation()
    }
    
    override func render(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        setTexture(animation.getFrame())
       super.render(renderCommandEncoder)
    }
}

