
import MetalKit

public enum TextMeshTypes {
    case CrazyFont_HelloWorld
}

class TextMeshLibrary: Library<TextMeshTypes, TextMesh> {
    private var library: [TextMeshTypes : TextMesh] = [:]

    override func fillLibrary() {
        library.updateValue(CrazyFont("Hello World"), forKey: .CrazyFont_HelloWorld)
    }
    
    override subscript(_ type: TextMeshTypes) -> TextMesh {
        return (library[type])!
    }
}

class CrazyFont: TextMesh {
    init(_ text: String){
        super.init(fontMapFileName: "crazyFont.fnt", fontTextureType: TextureTypes.CrazyFont, text: text)
    }
}









