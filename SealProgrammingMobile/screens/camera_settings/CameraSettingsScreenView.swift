import SwiftUI

struct CameraSettingsScreenView : View{
    @EnvironmentObject var settings: CameraSettings
    
    var body: some View {
        VStack{
            HStack{
                Form {
                    Section{
                        VStack{
                            Text("写真からシールを認識する際のしきい値を設定します。\nシールが認識されにくいときは、しきい値を下げてください。\nシール以外のものを誤って認識するときは、しきい値を上げてください。")
                                .font(.caption)
                                .fixedSize(horizontal: false, vertical: true)
                            Slider(value: $settings.threshold, in: 0...1, step: 0.1)
                            Text("\(settings.threshold * 100, specifier: "%.0f")%")
                        }.padding(10)
                    } header : {
                        Text("シール検出設定")
                    }
                    Section{
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
