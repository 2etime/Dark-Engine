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
        let textureLoader = MTKTextureLoader(device: DarkEngine.Device)
        let textureLoaderOptions = [
            MTKTextureLoader.Option.origin: MTKTextureLoader.Origin.topLeft
            //            MTKTextureLoader.Option.textureStorageMode : MTLStorageMode.private
        ]
        do{
            _skyMap = try textureLoader.newTexture(name: "Sky",
                                                   scaleFactor: 1.0,
                                                   bundle: nil,
                                                   options: textureLoaderOptions)
        }catch{
            print(error)
        }
        
        let imageNames = ["sky_back.png",
                          "sky_bottom.png",
                          "sky_front.png",
                          "sky_left.png",
                          "sky_right.png",
                          "sky_top.png"]
        let _ = textureCubeWithImagesNamed(imageNameArray: imageNames)
        
//        NSArray *imageNames = @[@"px", @"nx", @"py", @"ny", @"pz", @"nz"];
//        self.cubeTexture = [MBETextureLoader textureCubeWithImagesNamed:imageNames device:self.device];
    }
    
    
    private func createMesh(){
        let bufferAllocator = MTKMeshBufferAllocator(device: DarkEngine.Device)
//        let mesh = MDLMesh.newEllipsoid(withRadii: float3(150),
//                                                 radialSegments: 20,
//                                                 verticalSegments: 20,
//                                                 geometryType: .triangles,
//                                                 inwardNormals: true,
//                                                 hemisphere: false,
//                                                 allocator: bufferAllocator)
//
//
        let mesh = MDLMesh.newBox(withDimensions: float3(1),
                                  segments: vector_uint3(1, 1, 1),
                                  geometryType: MDLGeometryType.triangles,
                                  inwardNormals: true,
                                  allocator: bufferAllocator)
        do {
            try meshes = [MTKMesh.init(mesh: mesh, device: DarkEngine.Device)]
        } catch let error {
            print("Unable to load mesh for new box: \(error)")
        }
        
        let pipelineStateDescriptor = createPipelineStateDescriptor(vertex: "skybox_vertex", fragment: "skybox_fragment")
        pipelineStateDescriptor.vertexDescriptor = MTKMetalVertexDescriptorFromModelIO(mesh.vertexDescriptor)
        do{
            renderPipelineState = try DarkEngine.Device.makeRenderPipelineState(descriptor: pipelineStateDescriptor)
        }catch{
            
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
        
        
        return nil
    }
    
//    + (id<MTLTexture>)textureCubeWithImagesNamed:(NSArray *)imageNameArray device:(id<MTLDevice>)device
//    {
//    NSAssert(imageNameArray.count == 6, @"Cube texture can only be created from exactly six images");
//
//    UIImage *firstImage = [UIImage imageNamed:[imageNameArray firstObject]];
//    const CGFloat cubeSize = firstImage.size.width * firstImage.scale;
//
//    const NSUInteger bytesPerPixel = 4;
//    const NSUInteger bytesPerRow = bytesPerPixel * cubeSize;
//    const NSUInteger bytesPerImage = bytesPerRow * cubeSize;
//
//    MTLRegion region = MTLRegionMake2D(0, 0, cubeSize, cubeSize);
//
//    MTLTextureDescriptor *textureDescriptor = [MTLTextureDescriptor textureCubeDescriptorWithPixelFormat:MTLPixelFormatRGBA8Unorm
//    size:cubeSize
//    mipmapped:NO];
//
//    id<MTLTexture> texture = [device newTextureWithDescriptor:textureDescriptor];
//
//    for (size_t slice = 0; slice < 6; ++slice)
//    {
//    NSString *imageName = imageNameArray[slice];
//    UIImage *image = [UIImage imageNamed:imageName];
//    uint8_t *imageData = [self dataForImage:image];
//
//    NSAssert(image.size.width == cubeSize && image.size.height == cubeSize, @"Cube map images must be square and uniformly-sized");
//
//    [texture replaceRegion:region
//    mipmapLevel:0
//    slice:slice
//    withBytes:imageData
//    bytesPerRow:bytesPerRow
//    bytesPerImage:bytesPerImage];
//    free(imageData);
//    }
//
//    return texture;
//    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}











extension SkyboxGameObject: Renderable {
    
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(renderPipelineState)
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
