import SwiftUI

struct CameraSettingsScreenView : View{
    @EnvironmentObject var settings: CameraSettings
    
    var body: some View {
        VStack{
            HStack{
                Form {
                    Section(){
                        Toggle(isOn: $settings.showScore) {
                            Text("検出結果の信頼度(%)を表示")
                        }
                    } header : {
                        Text("表示設定")
                    }
                }
            }
        }
    }
}
