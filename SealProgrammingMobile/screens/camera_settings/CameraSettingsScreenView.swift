import SwiftUI

struct CameraSettingsScreenView : View{
    @EnvironmentObject var settings: CameraSettings
    
    var body: some View {
        VStack{
            HStack{
                Form {
                    Toggle(isOn: $settings.showScore) {
                        Text("検出結果の信頼度(%)を表示")
                    }
                }
            }
        }
    }
}
