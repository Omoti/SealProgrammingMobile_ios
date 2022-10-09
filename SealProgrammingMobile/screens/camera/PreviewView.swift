import Foundation
import AVFoundation
import SwiftUI

struct PreviewView: UIViewRepresentable {
    @ObservedObject var camera: CameraModel
    var aspectRatio: Double
    
    func makeUIView(context: Context) -> UIView {
        let screen = UIScreen.main.bounds
        let frame = CGRect(x: screen.minX, y: screen.minY, width: screen.width, height: screen.width / aspectRatio)
        let view = UIView(frame: frame)
        
        DispatchQueue.main.async {
            camera.preview = AVCaptureVideoPreviewLayer(session: camera.captureSession)
            camera.preview.frame = view.frame
            camera.preview.videoGravity = .resizeAspectFill
            view.layer.addSublayer(camera.preview)
            
            DispatchQueue.global(qos: .background).async {
                camera.captureSession.startRunning()
            }
        }
        
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.async {
            camera.preview.frame = uiView.frame
            print(camera.preview.frame)
        }
    }
}
