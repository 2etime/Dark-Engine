import MetalKit

enum VertexShaderTypes {
    case Basic
    case Skybox
    case Terrain
}

class VertexShaderLibrary: Library<VertexShaderTypes, MTLFunction> {
    private var library: [VertexShaderTypes : Shader] = [:]

    override func fillLibrary() {
        library.updateValue(Shader(label: "Basic Vertex Shader",
                                   functionName: "basic_vertex_shader"),
                            forKey: .Basic)
        library.updateValue(Shader(label: "Skybox Vertex Shader",
                                   functionName: "skybox_vertex"),
                            forKey: .Skybox)
        library.updateValue(Shader(label: "Terrain Vertex Shader",
                                   functionName: "terrain_vertex_shader"),
                            forKey: .Terrain)
    }
    
    override subscript(_ type: VertexShaderTypes) -> MTLFunction {
        return (library[type]?.function)!
    }
}

private class Shader {
    var name: String = ""
    var functionName: String = ""
    var function: MTLFunction!
    
    init(label: String, functionName: String) {
        self.function = DarkEngine.DefaultLibrary.makeFunction(name: functionName)
        self.function.label = label
    }
}

