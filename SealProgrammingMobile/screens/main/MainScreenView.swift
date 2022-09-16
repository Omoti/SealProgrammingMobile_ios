import Foundation
import SwiftUI
import TensorFlowLiteTaskVision

struct MainScreenView: View{
    @EnvironmentObject private var deviceModel :DeviceModel
    @EnvironmentObject private var detectionResultModel :DetectionResultModel
    
    @State var showingImagePicker = false
    @State var showingCameraPicker = false
    @State var showingCaptureScreenView = false
    @State var showingDeviceScreenView = false
    
    //@State var pickedImage: UIImage?
    
    
    var body:some View{
        NavigationView{
            VStack(alignment: .center) {
                ZStack{
                    if let image = detectionResultModel.image {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .background(Color.white)
                            .frame(maxHeight: .infinity)
                        
                        if let detections = detectionResultModel.detections {
                            DetectionResultView(detections: detections, imageSize: image.size)
                        }
                    }else{
                        VStack{
                            Spacer()
                            Text("シールプログラミングへようこそ")
                            Spacer()
                        }.background(Color.white)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                    }
                }.aspectRatio(3/4, contentMode: ContentMode.fit)
                    .background(Color.white)
                Spacer()
                HStack(alignment: .center){
                    Spacer()
                    CircleButton(
                        image: Image(systemName: "camera.fill"),
                        label: "とる",
                        color: Color("PrimaryColor"),
                        action: {
                            // showingCameraPicker.toggle()
                            showingCaptureScreenView = true
                        }
                    )
                    Spacer()
                    CircleButton(
                        image: Image("BluetoothIconDefault"),
                        label: "つなぐ",
                        color: Color("PrimaryColor"),
                        action: {
                            showingDeviceScreenView = true
                        }
                    )
                    Spacer()
                    CircleButton(
                        image:Image(systemName: "car.fill"),
                        label: "おくる",
                        color: Color("SecondaryColor"),
                        action: {
                            if let detections = detectionResultModel.detections {
                                deviceModel.write(data: SealConverter.detectionsToCommands(detactions: detections))
                            }
                        }
                    )
                    Spacer()
                }
            }.fullScreenCover(isPresented:$showingCaptureScreenView) {
                CaptureScreenView()
                    .environmentObject(detectionResultModel)
            }.sheet(isPresented: $showingDeviceScreenView) {
                DeviceScanView(onConnect: {
                    showingDeviceScreenView = false
                }).environmentObject(deviceModel)
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                .background(Color("ControlBackgroundColor"))
                .navigationBarTitle("シールプログラミング")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
