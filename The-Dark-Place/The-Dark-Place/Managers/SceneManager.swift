
import MetalKit

public enum SceneTypes {
    case Playground
    case CastleDefense
}

class SceneManager {

    private var _currentScene: Scene!
    
    init(_ sceneType: SceneTypes){
        switch sceneType {
        case .Playground:
            _currentScene = PlaygroundScene()
        case .CastleDefense:
            _currentScene = CastleDefenseScene()
        }
    }
    
    private func updateScene(){
        _currentScene.update()
    }
    
    public func doTransparentPass(_  renderCommandEncoder: MTLRenderCommandEncoder){
        _currentScene.transparencyRender(renderCommandEncoder)
    }
    
    private func renderScene(_ renderCommandEncoder: MTLRenderCommandEncoder){
        _currentScene.render(renderCommandEncoder)
    }
    
    public func tickCurrentScene(_ commandBuffer: MTLCommandBuffer, _ passDescriptor: MTLRenderPassDescriptor){
        
        updateScene()
        
        let renderCommandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: passDescriptor)
        renderCommandEncoder?.label = "The Render Pass"
        renderScene(renderCommandEncoder!)
        doTransparentPass(renderCommandEncoder!)
        renderCommandEncoder?.endEncoding()
        
        
//        let transparentRenderCommandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: passDescriptor)
//        transparentRenderCommandEncoder?.label = "The Transparent Render Pass"
//        transparentRenderCommandEncoder?.endEncoding()
    }

}
