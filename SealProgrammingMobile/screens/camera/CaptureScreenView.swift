import SwiftUI


struct CaptureScreenView: View {
    @EnvironmentObject private var deviceManager :DeviceManager
    @StateObject private var camera = CamearaManager() // 再描画しても状態を保持
    
    var body: some View {
        ZStack{
            PreviewView(camera: camera)
                .ignoresSafeArea(.all, edges: .all)
        }.onAppear(){
            camera.setupCaptureSession()
        }
    }
}
