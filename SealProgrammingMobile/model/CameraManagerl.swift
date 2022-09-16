import AVFoundation
import Foundation
import SwiftUI

class CamearaManager : NSObject, ObservableObject, AVCapturePhotoCaptureDelegate{
    @Published var captureSession: AVCaptureSession = AVCaptureSession()
    @Published var output: AVCapturePhotoOutput = AVCapturePhotoOutput()
    @Published var preview: AVCaptureVideoPreviewLayer!
    @Published var captured = false
    @Published var saved = false
    @Published var capturedUiImage: UIImage? = nil

    private var input: AVCaptureInput!
    private var position: AVCaptureDevice.Position = .back
    
    func setupCaptureSession(){
        saved = false
        captureSession.beginConfiguration() // 設定開始
        
        // 4:3
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        
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
            
            DispatchQueue.main.async {
                withAnimation{self.captured.toggle()}
            }
        }
    }
    
    func restart(){
        saved = false
        capturedUiImage = nil
        DispatchQueue.global(qos: .background).async {
            self.captureSession.startRunning()
            
            DispatchQueue.main.async {
                withAnimation{self.captured.toggle()}
            }
        }
    }
    
    func photoOutput(_ _output:AVCapturePhotoOutput,didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?){
        if error != nil {
            print("photo outut error")
            return
        }
        
        captureSession.stopRunning()
        
        guard let cgImage = photo.cgImageRepresentation() else {return}
            
        self.capturedUiImage = UIImage(cgImage: cgImage, scale: 1, orientation: .right).fixedOrientation()
    }
    
    func save(){
        let image = capturedUiImage
        
        if image == nil {
            print("not captured")
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        
        saved = true
        print("saved")
    }
}
