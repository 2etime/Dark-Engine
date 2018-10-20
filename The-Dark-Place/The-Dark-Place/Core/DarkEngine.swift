import MetalKit

class DarkEngine {
    
    private static var _device: MTLDevice!
    private static var _commandQueue: MTLCommandQueue!
    
    public static func Ignite(_ device: MTLDevice) {
        self._device = device
        self._commandQueue = device.makeCommandQueue()
    }
    
}


//Getters / Setters
extension DarkEngine {
    public static var Device: MTLDevice {
        return _device
    }
    
    public static var CommandQueue: MTLCommandQueue {
        return _commandQueue
    }
}
