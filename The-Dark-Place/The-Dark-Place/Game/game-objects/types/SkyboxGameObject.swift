import MetalKit

class SkyboxGameObject: Node {
    var meshes: [MTKMesh] = Array()
    var materials: [MTLBuffer] = Array()
    private var _skyMap: MTLTexture!
    private var renderPipelineDescriptor: MTLRenderPipelineDescriptor!
    private var renderPipelineState: MTLRenderPipelineState!
    
    override init() {
        super.init()
        
        createMesh()
        createSkyMap()

    }
    
    private func createSkyMap(){
        let imageNames = [
            "sky_right.png", //py //right
            "sky_left.png", //px //left
            "sky_top.png", //nx //top
            "sky_bottom.png", //nz //bottom
            "sky_back.png", //ny//back
            "sky_front.png" //pz//front
        ]
        _skyMap = textureCubeWithImagesNamed(imageNameArray: imageNames)
    }
    
    
    private func createMesh(){
        let bufferAllocator = MTKMeshBufferAllocator(device: DarkEngine.Device)
        let mesh = MDLMesh.newBox(withDimensions: float3(2),
                                  segments: vector_uint3(1, 1, 1),
                                  geometryType: MDLGeometryType.triangles,
                                  inwardNormals: true,
                                  allocator: bufferAllocator)
        do {
            try meshes = [MTKMesh.init(mesh: mesh, device: DarkEngine.Device)]
        } catch let error {
            print("Unable to load mesh for new box: \(error)")
        }
    }
    
    func createPipelineStateDescriptor(vertex: String, fragment: String) -> MTLRenderPipelineDescriptor {
        let defaultLibrary = DarkEngine.Device.makeDefaultLibrary()!
        let vertexProgram = defaultLibrary.makeFunction(name: vertex)!
        let fragmentProgram = defaultLibrary.makeFunction(name: fragment)!
        
        let pipelineStateDescriptor = MTLRenderPipelineDescriptor()
        pipelineStateDescriptor.vertexFunction = vertexProgram
        pipelineStateDescriptor.fragmentFunction = fragmentProgram
        pipelineStateDescriptor.colorAttachments[0].pixelFormat = .bgr10a2Unorm
        pipelineStateDescriptor.sampleCount = 1
        pipelineStateDescriptor.depthAttachmentPixelFormat = .depth32Float
        
        return pipelineStateDescriptor
    }
    
    func textureCubeWithImagesNamed(imageNameArray: [String])->MTLTexture?{
        //Grab the first texture to generate a texture descriptor
        let firstTexture = createTexture(textureName: imageNameArray.first!)
        let cubeSize = firstTexture?.width ?? 0
        let textureDescritpor = MTLTextureDescriptor.textureCubeDescriptor(pixelFormat: .bgra8Unorm, size: cubeSize, mipmapped: false)
        let result = DarkEngine.Device.makeTexture(descriptor: textureDescritpor)
 
        for slice in 0..<6 {
            let imageName = imageNameArray[slice]
            let texture = createTexture(textureName: imageName)
            let height = texture?.height
            let width = texture?.width
    
            let rowBytes = width! * 4
            let length = rowBytes * height!
            let bgraBytes = [UInt8](repeating: 0, count: length)
            let region = MTLRegionMake2D(0, 0, width!, height!) //Grab the whole texture. ex: start at origin (0,0), go to width/height (1024,1024)
            texture?.getBytes(UnsafeMutableRawPointer(mutating: bgraBytes), bytesPerRow: rowBytes, from: region, mipmapLevel: 0)
            
            result?.replace(region: MTLRegionMake2D(0, 0, cubeSize, cubeSize),
                            mipmapLevel: 0,
                            slice: slice,
                            withBytes: bgraBytes,
                            bytesPerRow: rowBytes,
                            bytesPerImage: bgraBytes.count)
        }
        
        return result
    }

    public func createTexture(textureName: String)->MTLTexture?{
        var result: MTLTexture?
        
        let url = Bundle.main.url(forResource: textureName, withExtension: nil)
        let textureLoader = MTKTextureLoader(device: DarkEngine.Device)
        
        let options = [MTKTextureLoader.Option.origin : MTKTextureLoader.Origin.topLeft]
        
        do{
            result = try textureLoader.newTexture(URL: url!, options: options)
        }catch let error as NSError {
            print("ERROR::CREATE::TEXTURE::__\(textureName)__::\(error)")
            
        }
        
        return result
    }
}

extension SkyboxGameObject: Renderable {
    
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(Graphics.RenderPipelineStates[.Skybox])
        renderCommandEncoder.setDepthStencilState(Graphics.DepthStencilStates[.DontWrite])
        renderCommandEncoder.setFrontFacing(.clockwise)
        renderCommandEncoder.setCullMode(.front)
        
        renderCommandEncoder.setFragmentTexture(_skyMap, index: 0)
        
        for mesh in meshes {
            let vertexBuffer = mesh.vertexBuffers[0]
            renderCommandEncoder.setVertexBuffer(vertexBuffer.buffer, offset: vertexBuffer.offset, index: 0)
            
            for submesh in mesh.submeshes {
                renderCommandEncoder.drawIndexedPrimitives(type: submesh.primitiveType,
                                                     indexCount: submesh.indexCount,
                                                     indexType: submesh.indexType,
                                                     indexBuffer: submesh.indexBuffer.buffer,
                                                     indexBufferOffset: submesh.indexBuffer.offset)
            }
        }
    }
    
}
