
import MetalKit

enum CameraTypes {
    case Debug
    case Ortho
}

class Scene: Node {
    private var _sceneConstants = SceneConstants()
    var lightData = LightData()
    
    private var _cameras: [CameraTypes : Camera] = [:]
    private var _currentCamera: Camera!
    internal var currentCamera: Camera {
        return _currentCamera
    }
    
    var lastCamera: CameraTypes!
    var guis: [Node] = []

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
    
    func addGui(_ gui: GUIObject){
        self.guis.append(gui)
    }
    
    private func updateGuiConstants(){
        for gui in guis {
           gui.update()
        }
    }
    
    func renderGuis(_ renderCommandEncoder: MTLRenderCommandEncoder){
        setCurrentCamera(.Ortho)
        for gui in guis {
            gui.render(renderCommandEncoder)
        }
        setCurrentCamera(lastCamera)
    }
    
    internal func setCurrentCamera(_ cameraType: CameraTypes) {
        lastCamera = cameraType
        if(!_cameras.keys.contains(cameraType)) {
            switch cameraType {
            case .Debug:
                _cameras.updateValue(Camera_Debug(), forKey: cameraType)
            case .Ortho:
                _cameras.updateValue(Camera_Ortho(), forKey: cameraType)
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
        updateGuiConstants()
        super.update()
    }
    
    func setScene(_ renderCommandEncoder: MTLRenderCommandEncoder){
        renderCommandEncoder.setDepthStencilState(Graphics.DepthStencilStates[.Less])
        renderCommandEncoder.setVertexBytes(&_sceneConstants, length: SceneConstants.stride, index: 1)
        renderCommandEncoder.setFragmentBytes(&lightData, length: LightData.stride, index: 1)
    }
    
    override func render(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        setScene(renderCommandEncoder)
        super.render(renderCommandEncoder)
        renderGuis(renderCommandEncoder)
    }
}
