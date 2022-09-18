import SwiftUI
import Foundation
import TensorFlowLiteTaskVision

struct CaptureScreenView: View {
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject private var detectionResultModel :DetectionResultModel
    @EnvironmentObject private var settings: CameraSettings
    
    @StateObject private var camera = CameraModel() // 再描画しても状態を保持
    @StateObject private var sealDetector = SealDetector()
    
    @State var showingSettings = false
    @State private var selection = 0
    
    var body: some View {
        NavigationView{
            VStack{
                Picker("", selection: $selection) {
                    Text("シール").tag(0).foregroundColor(.white)
                    Text("リスト").tag(1).foregroundColor(.white)
                }.pickerStyle(.segmented)
                    .padding(10)
                    .opacity(camera.capturedUiImage != nil ? 1.0 : 0.0)
                
                ZStack{
                    // 撮影画像
                    if let image = camera.capturedUiImage {
                        if selection == 0 {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxHeight: .infinity)
                            
                            // 検出結果を重ねる
                            if sealDetector.detections != nil {
                                DetectionResultView(
                                    detections: sealDetector.detections!,
                                    imageSize: camera.capturedUiImage!.size,
                                    showScore: settings.showScore
                                )
                            }
                        }else{
                            let seals = sealDetector.detections?.map({ detection in
                                SealConverter.labelToSeal(label: detection.categories.first?.label ?? "")
                            })
                            SealsScreenView(seals: seals ?? [])
                        }
                    }else{
                        // プレビュー
                        ZStack(alignment: .center){
                            PreviewView(camera: camera, aspectRatio: 3/4)
                            Rectangle()
                                .stroke(lineWidth: 1)
                                .foregroundColor(.red)
                                .aspectRatio(2/3, contentMode: .fit)
                                .padding(20)
                        }
                    }
                }.onAppear(){
                    UISegmentedControl.appearance().setTitleTextAttributes(
                        [.foregroundColor : UIColor.white], for: .normal
                    )
                    UISegmentedControl.appearance().setTitleTextAttributes(
                        [.foregroundColor : UIColor.black], for: .selected
                    )
                    UISegmentedControl.appearance().backgroundColor = UIColor.darkGray
                    UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.white
                    
                    camera.setupCaptureSession()
                }.aspectRatio(3/4, contentMode: ContentMode.fit)
                Spacer()
                if(camera.captured){
                    HStack{
                        Spacer()
                        CircleButton(
                            image: Image(systemName: "checkmark"),
                            label: "OK",
                            color: Color("PrimaryColor"),
                            action: {
                                detectionResultModel.image = camera.capturedUiImage
                                detectionResultModel.detections = sealDetector.detections
                                close()
                            }
                        )
                        Spacer().overlay(
                            IconButton(
                                image: Image(systemName: "camera"),
                                label: "とりなおす",
                                action: {
                                    camera.restart()
                                }
                            )
                        )
                    }.padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                }else{
                    HStack{
                        Spacer()
                        ShutterButton(action: {
                            camera.onCaptured = onCaptured
                            camera.capture()
                        })
                        Spacer().overlay(
                            SwitchCameraButton(action: {
                                camera.switchPosition()
                            })
                        )
                    }.padding(20)
                }
            }.background(.black)
                .navigationBarTitle("とる")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(
                    leading: ZStack{
                        SettingsButton{
                            showingSettings = true
                        }
                    },
                    trailing: CloseButton(action: {
                        close()
                    }))
        }.sheet(isPresented: $showingSettings) {
            CameraSettingsScreenView()
                .onDisappear(){
                    if let image = camera.capturedUiImage {
                        detectionResultModel.detections = nil
                        sealDetector.detect(image: image, threshold: settings.threshold)
                    }
                }
        }
    }
    
    func onCaptured(uiImage: UIImage) {
        sealDetector.detect(image: uiImage, threshold: settings.threshold)
    }
    
    func close(){
        camera.onCaptured = nil
        camera.stop()
        dismiss()
    }
}
