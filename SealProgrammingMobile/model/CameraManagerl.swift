import AVFoundation

class CamearaManager : ObservableObject{
    @Published var captureSession: AVCaptureSession = AVCaptureSession()
    @Published var output: AVCaptureOutput = AVCapturePhotoOutput()
    @Published var preview: AVCaptureVideoPreviewLayer!
    
    func setupCaptureSession(){
        captureSession.beginConfiguration() // 設定開始
        
        // デバイス選択
        guard let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera],
                                                            mediaType: AVMediaType.video,
                                                            position: .unspecified)
            .devices.first(where: { $0.position == .back }),
              let input = try? AVCaptureDeviceInput(device: device) else { return }

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
}
