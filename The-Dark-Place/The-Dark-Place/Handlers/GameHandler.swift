
import MetalKit

class GameHandler {
    // The max number of command buffers in flight
    let MaxBuffersInFlight: Int = 3
    
    // Number of vertices in our 2D fairy model
    let NumFairyVertices: Int = 7
    
    // Number of "fairy" lights in scene
    static let NumLights: Int = 256
    
    // 30% of lights are around the tree
    // 40% of lights are on the ground inside the columns
    // 30% of lights are around the outside of the columns
    let TreeLights: Int = Int(Double(NumLights) * 0.3)
    let GroundLights: Int = Int(Double(NumLights) * 0.4)
    let ColumnLights: Int = Int(Double(NumLights) * 0.3)
    
    // Projection Matrix Constants
    let NearPlane: Float = 1.0
    let FarPlane: Float = 150.0
    
    //------------------------- GAME HANDLER CODE -------------------------\\
    private var _inFlightSemaphore: DispatchSemaphore!
    private var _view: MTKView!
    
    init(_ view: MTKView){
        self._view = view
        self._inFlightSemaphore = DispatchSemaphore(value: MaxBuffersInFlight)
    }
    
    public func updateGameView(_ width: Float, _ height: Float) {
        GameView.Width = width
        GameView.Height = height
    }
    
    public func updateGameTime(_ deltaTime: Float) {
        GameTime.UpdateTime(deltaTime)
    }
    
    public func tickGame(_ renderCommandEncoder: MTLRenderCommandEncoder){
       
    }
    
}






//import MetalKit
//
//class GameHandler {
//
//    private static var _sceneManager: SceneManager!
//
//    public static func Initialize() {
//        self._sceneManager = SceneManager(.Playground)
//    }
//
//    public static func UpdateGameView(_ aspectRatio: Float) {
//        GameView.AspectRatio = aspectRatio
//    }
//
//    public static func UpdateGameTime(_ deltaTime: Float) {
//        GameTime.UpdateTime(deltaTime)
//    }
//
//    public static func TickGame(_ renderCommandEncoder: MTLRenderCommandEncoder){
//        _sceneManager.tickCurrentScene(renderCommandEncoder)
//    }
//
//}


