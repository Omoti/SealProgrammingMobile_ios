import Foundation
import SwiftUI
import TensorFlowLiteTaskVision

struct MainScreenView: View{
    @State var showingImagePicker = false
    @State var showingCameraPicker = false
    @State var showingDeviceScanView = false
    
    @State var pickedImage: UIImage?
    @State var detectionResult: DetectionResult?
    
    var body:some View{
        VStack(alignment: .center) {
            ZStack{
                if let image = pickedImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .background(Color.gray)
                        .frame(maxHeight: .infinity)
                }else{
                    Spacer().background(Color.white)
                }
                if let detectionResult = detectionResult {
                    DetectionResultView(detections: detectionResult.detections, imageSize: pickedImage!.size)
                }
            }.aspectRatio(3/4, contentMode: ContentMode.fit)
                .background(Color.white)
            Spacer()
            HStack(alignment: .center){
                Spacer()
                Button(
                    action: {
                        showingCameraPicker.toggle()
                    },
                    label: {
                        Text("カメラ")
                    }
                )
                Spacer()
                Button(
                    action: {
                        showingDeviceScanView = true
                    },
                    label: {
                        Text("つなぐ")
                    }
                )
                Spacer()
                Button(
                    action: {
                        // TODO : コマンドを送信
                    },
                    label: {
                        Text("おくる")
                    }
                )
                Spacer()
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, alignment: .center)
                .padding(20)
        }.sheet(isPresented:$showingImagePicker) {
            ImagePickerView(image: $pickedImage, sourceType: .library)
        }.sheet(isPresented:$showingCameraPicker) {
            ImagePickerView(image: $pickedImage, sourceType: .camera)
        }.sheet(isPresented: $showingDeviceScanView) {
            DeviceScanView()
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
