
import MetalKit

class Node {

    private var children: [Node] = []
    
    func addChild(_ child: Node) {
        children.append(child)
    }
    
    func render(_ renderCommandEncoder: MTLRenderCommandEncoder){
        for child in children {
            child.render(renderCommandEncoder)
        }
        
        if let renderable = self as? Renderable {
            renderable.doRender(renderCommandEncoder)
        }
    }
    
}
