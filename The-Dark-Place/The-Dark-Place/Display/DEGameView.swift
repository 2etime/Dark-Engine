import MetalKit

class GameView: MTKView {

    private var _renderer: DERenderer!
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        self.device = MTLCreateSystemDefaultDevice()
        
        DarkEngine.Ignite(self.device!)
        
        self.clearColor = DEColor.ClearColors.FOREST_GREEN
        
        self.colorPixelFormat = .bgr10a2Unorm
        
        self._renderer = DERenderer()
        
        self.delegate = _renderer
    }
    
}
