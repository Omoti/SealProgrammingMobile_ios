import SwiftUI

struct CaptureScreenView: View {
    @EnvironmentObject private var deviceManager :DeviceManager
    @StateObject private var camera = CamearaManager() // 再描画しても状態を保持
    
    var body: some View {
        VStack{
            ZStack{
                PreviewView(camera: camera, aspectRatio: 3/4)
            }.onAppear(){
                camera.setupCaptureSession()
            }.aspectRatio(3/4, contentMode: ContentMode.fit)
            Spacer()
        }
    }
}
