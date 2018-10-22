import MetalKit

class MainView: MTKView {

    private var _renderer: Renderer!
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        self.device = MTLCreateSystemDefaultDevice()
        
        DarkEngine.Ignite(self.device!)
        
        self.clearColor = Colors.ClearColors.DARK_GRAY
        
        self.colorPixelFormat = .bgr10a2Unorm
        
        self.depthStencilPixelFormat = .depth32Float
        
        self._renderer = Renderer(self)
        
        self.delegate = _renderer
    }
    
}
