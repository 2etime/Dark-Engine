
import MetalKit

class Graphics {
    public static var VertexDescriptors: VertexDescriptorLibrary!
    public static var RenderPipelineDescriptors: RenderPipelineDescriptorLibrary!
    public static var RenderPipelineStates: RenderPipelineStateLibrary!
    public static var VertexShaders: VertexShaderLibrary!
    public static var FragmentShaders: FragmentShaderLibrary!
    public static var DepthStencilStates: DepthStencilStateLibrary!

    public static func Initialize(){
        self.VertexShaders = VertexShaderLibrary()
        self.FragmentShaders = FragmentShaderLibrary()
        self.VertexDescriptors = VertexDescriptorLibrary()
        self.RenderPipelineDescriptors = RenderPipelineDescriptorLibrary()
        self.RenderPipelineStates = RenderPipelineStateLibrary()
        self.DepthStencilStates = DepthStencilStateLibrary()
    }
    
}
