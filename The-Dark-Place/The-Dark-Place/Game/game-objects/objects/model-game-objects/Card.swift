import MetalKit

class Card: GameObject {
    init(){
        super.init(.Quad_Custom)
        self.setName("Card")
        self.material.color = float4(1)
    }
}

