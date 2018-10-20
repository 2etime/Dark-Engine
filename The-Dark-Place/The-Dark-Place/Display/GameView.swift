import MetalKit

class GameView: MTKView {

    private var _renderer: Renderer!
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        self.device = MTLCreateSystemDefaultDevice()
        
        DarkEngine.Ignite(self.device!)
        
        self.clearColor = Color.ClearColors.FOREST_GREEN
        
        self.colorPixelFormat = .bgr10a2Unorm
        
        self._renderer = Renderer()
        
        self.delegate = _renderer
    }
    
}
