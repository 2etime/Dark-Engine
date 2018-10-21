
import MetalKit

class Camera_Debug: Camera {

    override func doUpdate() {
        self.doRoll(GameTime.DeltaTime)
    }
    
}
