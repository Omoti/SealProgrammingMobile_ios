import AVFoundation
import Foundation
import SwiftUI

class CamearaManager : NSObject, ObservableObject, AVCapturePhotoCaptureDelegate{
    @Published var captureSession: AVCaptureSession = AVCaptureSession()
    @Published var output: AVCapturePhotoOutput = AVCapturePhotoOutput()
    @Published var preview: AVCaptureVideoPreviewLayer!
    @Published var captured = false
    
    private var input: AVCaptureInput!
    private var position: AVCaptureDevice.Position = .back
    
    func setupCaptureSession(){
        captureSession.beginConfiguration() // 設定開始
        
        // デバイス選択
        guard let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera],
                                                            mediaType: AVMediaType.video,
                                                            position: .unspecified)
            .devices.first(where: { $0.position == position }),
              let input = try? AVCaptureDeviceInput(device: device) else { return }

        self.input = input
        
        // インプット
        if captureSession.canAddInput(input){
            captureSession.addInput(input)
        }
        
        // アウトプット
        if captureSession.canAddOutput(output){
            captureSession.addOutput(output)
        }
        
        captureSession.commitConfiguration() // 設定完了
    }
    
    private func reset(){
        captureSession.beginConfiguration() // 設定開始
        captureSession.removeInput(input)
        captureSession.commitConfiguration() // 設定完了
    }
    
    func switchPosition() {
        if position == .back {
            position = .front
        } else {
            position = .back
        }
        
        reset()
        setupCaptureSession()
    }
    
    func stop(){
        self.captureSession.stopRunning()
    }
    
    func capture(){
        DispatchQueue.global(qos: .background).async {
            self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
            self.captureSession.stopRunning()
            
            DispatchQueue.main.async {
                withAnimation{self.captured.toggle()}
            }
        }
    }
    
    func restart(){
        DispatchQueue.global(qos: .background).async {
            self.captureSession.startRunning()
            
            DispatchQueue.main.async {
                withAnimation{self.captured.toggle()}
            }
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if error != nil {
            print("photo outut error")
            return
        }
    }
}
