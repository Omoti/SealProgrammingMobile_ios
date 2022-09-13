import AVFoundation

class CamearaManager : ObservableObject{
    @Published var captureSession: AVCaptureSession = AVCaptureSession()
    @Published var output: AVCaptureOutput = AVCapturePhotoOutput()
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
}
