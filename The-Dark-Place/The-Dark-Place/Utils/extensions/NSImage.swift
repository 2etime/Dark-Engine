
import MetalKit

extension NSImage {
    var CGImage: CGImage {
        get {
            let imageData = self.tiffRepresentation
            let source = CGImageSourceCreateWithData(imageData! as CFData, nil).unsafelyUnwrapped
            let maskRef = CGImageSourceCreateImageAtIndex(source, 0, nil)
            return maskRef.unsafelyUnwrapped
        }
    }
}
