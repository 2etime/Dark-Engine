
import MetalKit

class Graphics {
    public static var VertexDescriptors: VertexDescriptorLibrary!
    public static var RenderPipelineStates: RenderPipelineStateLibrary!
    public static var RenderPassDescriptors: RenderPassDescriptorLibrary!
    public static var VertexShaders: VertexShaderLibrary!
    public static var FragmentShaders: FragmentShaderLibrary!
    public static var DepthStencilStates: DepthStencilStateLibrary!
    public static var SamplerStates: SamplerStateLibrary!

    public static func Initialize(){
        self.VertexShaders = VertexShaderLibrary()
        self.FragmentShaders = FragmentShaderLibrary()
        self.SamplerStates = SamplerStateLibrary()
        self.VertexDescriptors = VertexDescriptorLibrary()
        self.RenderPipelineStates = RenderPipelineStateLibrary()
        self.DepthStencilStates = DepthStencilStateLibrary()
        self.RenderPassDescriptors = RenderPassDescriptorLibrary()
    }
    
}
