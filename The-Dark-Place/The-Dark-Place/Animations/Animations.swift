import MetalKit

class Animations {
    private static var _spriteSheetLibrary: SpriteSheetLibrary!
    
    public static var Animation2D: Animation2DLibrary!
    
    public static func Initialize(){
        self._spriteSheetLibrary = SpriteSheetLibrary()
        
        self.Animation2D = Animation2DLibrary(spriteSheetLibrary: _spriteSheetLibrary)
    }
}
