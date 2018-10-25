import MetalKit

class DarkEngine {
    private static var _device: MTLDevice!
    private static var _commandQueue: MTLCommandQueue!
    private static var _defaultLibrary: MTLLibrary!
    
    public static func Ignite(_ device: MTLDevice) {
        self._device = device
        self._commandQueue = device.makeCommandQueue()
        self._defaultLibrary = device.makeDefaultLibrary()
        
        Graphics.Initialize()
        Entities.Initialize()
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
    
    public static var DefaultLibrary: MTLLibrary {
        return _defaultLibrary
    }
}
