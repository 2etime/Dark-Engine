import MetalKit

enum FragmentShaderTypes {
    case Basic
    case Skybox
    case TerrainTextured
    case TerrainMultiTextured
    case Bounding
    case BasicFont
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
        library.updateValue(Shader(label: "Terrain Multi Textured Fragment Shader",
                                   functionName: "terrain_multi_textured_fragment_shader"),
                            forKey: .TerrainMultiTextured)
        library.updateValue(Shader(label: "Bounding Fragment Shader",
                                   functionName: "bounding_fragment_shader"),
                            forKey: .Bounding)
        library.updateValue(Shader(label: "Basic Font Fragment Shader",
                                   functionName: "basic_font_fragment"),
                            forKey: .BasicFont)
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
