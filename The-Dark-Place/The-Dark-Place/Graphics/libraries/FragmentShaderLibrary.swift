import MetalKit

enum FragmentShaderTypes {
    case Basic
    case Skybox
    case TerrainTextured
}

class FragmentShaderLibrary: Library<FragmentShaderTypes, MTLFunction> {
    private var library: [FragmentShaderTypes : Shader] = [:]
    
    override func fillLibrary() {
        library.updateValue(Shader(label: "Basic Fragment Shader",
                                   functionName: "basic_fragment_shader"),
                            forKey: .Basic)
        library.updateValue(Shader(label: "Skybox Fragment Shader",
                                   functionName: "skybox_fragment"),
                            forKey: .Skybox)
        library.updateValue(Shader(label: "Terrain Textured Fragment Shader",
                                   functionName: "terrain_textured_fragment_shader"),
                            forKey: .TerrainTextured)
    }
    
    override subscript(_ type: FragmentShaderTypes) -> MTLFunction {
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
