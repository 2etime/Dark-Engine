
import MetalKit

enum CameraTypes {
    case Debug
}

class Scene: Node {
    private var _sceneConstants = SceneConstants()
    var lightData = LightData()
    
    private var _cameras: [CameraTypes : Camera] = [:]
    private var _currentCamera: Camera!
    internal var currentCamera: Camera {
        return _currentCamera
    }

    override init() {
        super.init(name: "Scene")
        setupCameras()
        buildScene()
    }
    
    internal func buildScene(){
        //Implement on scene classes
    }
    
    internal func setupCameras(){
        //Implement on scene classes
    }
    
    internal func setCurrentCamera(_ cameraType: CameraTypes) {
        if(!_cameras.keys.contains(cameraType)) {
            switch cameraType {
            case .Debug:
                _cameras.updateValue(Camera_Debug(), forKey: cameraType)
            }
        }
        _currentCamera = _cameras[cameraType]
    }
    
    private func updateCameras(){
        for camera in _cameras.values {
            camera.doUpdate()
        }
    }
    
    private func updateSceneConstants(){
        _sceneConstants.viewMatrix = self._currentCamera.viewMatrix
        _sceneConstants.inverseViewMatrix = simd_inverse(self.currentCamera.viewMatrix) 
        _sceneConstants.projectionMatrix = self._currentCamera.projectionMatrix
    }
    
    override func update() {
        updateCameras()
        updateSceneConstants()
        super.update()
    }
    
    override func render(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setDepthStencilState(Graphics.DepthStencilStates[.Less])
        renderCommandEncoder.setVertexBytes(&_sceneConstants, length: SceneConstants.stride, index: 1)
        renderCommandEncoder.setFragmentBytes(&lightData, length: LightData.stride, index: 1)
        super.render(renderCommandEncoder)
    }
}
