import Foundation
import AVFoundation
import SwiftUI

struct PreviewView: UIViewRepresentable {
    @ObservedObject var camera: CamearaManager
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        camera.preview = AVCaptureVideoPreviewLayer(session: camera.captureSession)
        camera.preview.frame = view.frame
        
        camera.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(camera.preview)
        
        camera.captureSession.startRunning()
        
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
