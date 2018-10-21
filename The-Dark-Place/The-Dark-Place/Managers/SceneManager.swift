
import MetalKit

public enum SceneTypes {
    case Playground
}

class SceneManager {

    private var _currentScene: Scene!
    
    init(_ sceneType: SceneTypes){
        switch sceneType {
        case .Playground:
            _currentScene = PlaygroundScene()
        }
    }
    
    private func updateScene(_ deltaTime: Float){
        _currentScene.update(deltaTime)
    }
    
    private func renderScene(_ renderCommandEncoder: MTLRenderCommandEncoder){
        _currentScene.render(renderCommandEncoder)
    }
    
    public func tickCurrentScene(_ renderCommandEncoder: MTLRenderCommandEncoder, _ deltaTime: Float){
        updateScene(deltaTime)
        renderScene(renderCommandEncoder)
    }

}
