
import MetalKit

class PlaygroundScene: Scene {

    private var _object = Cube()
    
    override func setupCameras() {
        setCurrentCamera(.Debug)
    }
    
    var terrain = SingleTextureTerrain(.Grass)
    var lightThing = Cube()

    var textObject: TextObject!
    
    override func buildScene() {
        
        //Setup Camera
        currentCamera.setPositionZ(5)
        currentCamera.setPositionY(1)
        
        //Add Lights
        lightData.color = lightThing.getColor().xyz
        lightData.position = float3(0,500,500)
//        lightThing.setScale(0.2)
//        addChild(lightThing)
        
        textObject = TextObject(initialText: "  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer hendrerit velit pulvinar leo dictum, ut sodales sapien vulputate. Nulla accumsan massa dolor, quis tincidunt ante imperdiet ut. In convallis dignissim euismod. Fusce tortor augue, pharetra sit amet mattis a, pharetra quis nulla. Phasellus venenatis, elit a varius aliquet, erat lacus luctus tellus, nec condimentum odio purus at purus. Donec vitae mauris a tellus convallis hendrerit. Proin viverra vel leo vitae interdum. Proin dui velit, pharetra ac nunc a, mattis vulputate arcu. In quam odio, facilisis at mauris et, blandit venenatis orci. Praesent scelerisque mauris nibh, eu rhoncus mi rutrum at.\n\n    Ut pulvinar leo at orci ornare, eget gravida libero tristique. Mauris facilisis ex non tellus ultricies pellentesque. Donec bibendum tellus vitae fermentum posuere. Nulla at convallis nisi, at feugiat sapien. Pellentesque at sodales arcu, congue posuere purus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Curabitur vitae mi suscipit, venenatis velit id, iaculis justo. Duis et dapibus purus. Etiam varius nibh lacus, eu volutpat ligula ullamcorper eu. Nunc ornare urna et venenatis posuere. Ut lobortis maximus bibendum.\n\n    Nunc ultricies elit id fringilla varius. Nullam viverra gravida nisi, in mollis tellus ullamcorper ac. Integer luctus auctor cursus. Integer non eros faucibus, dignissim ipsum ut, maximus purus. Integer ac viverra leo. Mauris ultrices ultricies turpis ut porta. Nam consequat, ex eu maximus blandit, neque nibh porta diam, eget porttitor dui massa quis magna. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis pharetra lacus rutrum, aliquet dolor sit amet, commodo dui. Cras mattis convallis ligula, nec ultricies ligula imperdiet at. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla ac nisl eu nibh suscipit sagittis. Sed gravida mollis pulvinar. Mauris sollicitudin nulla eget pellentesque hendrerit.\n\n   Etiam id diam neque. Maecenas in libero ac lorem hendrerit sodales semper nec eros. Quisque quis risus non ligula pulvinar posuere at quis magna. Curabitur fermentum non nisi non auctor. Suspendisse potenti. Cras tincidunt orci nec nunc condimentum molestie. Suspendisse ultrices ultricies facilisis. Vivamus semper, felis et aliquet maximus, felis erat imperdiet magna, nec mollis ante lectus vel lacus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Integer pharetra lacinia sagittis.\n\n   Nulla mauris nibh, sagittis sit amet lobortis nec, porta non nulla. Nullam convallis urna metus, a mattis lorem volutpat ut. Aenean sem dolor, pharetra at odio non, viverra venenatis nunc. Morbi sed dignissim diam. Quisque at ipsum est. Aenean ut euismod lectus. Ut id viverra quam, vitae facilisis dui. Fusce lobortis ex ut eros pharetra, eu posuere ipsum ultrices. Sed ac rhoncus ligula. Quisque imperdiet finibus sapien ut consectetur. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nunc tincidunt, ipsum ac fermentum sollicitudin, nisl nisl luctus massa, in efficitur tellus metus ut libero.",
                                fontType: .CandaraFont,
                                fontSize: 1,
                                isCentered: false)
        
        addChild(textObject)
    }
    
    var size: Float = 2
    override func onUpdate() {
        if(Keyboard.IsKeyPressed(.space)){
            textObject.updateFontSize(size)
            size += 0.1
        }
        if(Keyboard.IsKeyPressed(.upArrow)){
            currentCamera.moveZ(-GameTime.DeltaTime * 2)
        }
        
        if(Keyboard.IsKeyPressed(.downArrow)){
            currentCamera.moveZ(GameTime.DeltaTime * 2)
        }
        
        if(Keyboard.IsKeyPressed(.leftArrow)){
            currentCamera.moveX(-GameTime.DeltaTime * 2)
        }
        
        if(Keyboard.IsKeyPressed(.rightArrow)){
            currentCamera.moveX(GameTime.DeltaTime * 2)
        }
        
        if(Keyboard.IsKeyPressed(.q)){
            currentCamera.moveY(GameTime.DeltaTime * 2)
        }
        
        if(Keyboard.IsKeyPressed(.a)){
            currentCamera.moveY(-GameTime.DeltaTime * 2)
        }
        
        if(Mouse.IsMouseButtonPressed(button: .left)){
            currentCamera.doPitch(Mouse.GetDY() * 0.05)
            currentCamera.doYaw(Mouse.GetDX() * 0.05)
        }
    }
    
}
