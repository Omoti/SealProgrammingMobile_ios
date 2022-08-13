import SwiftUI
import TensorFlowLiteTaskVision

struct DetectionResultView: View {
    let detections: [Detection]
    
    var body: some View {
        Canvas { context, size in
            let safeAreaWidth = size.width
            let safeAreahight = size.height

            context.fill(
                Path(CGRect(x: 0, y: 0, width: safeAreaWidth, height: safeAreahight)),
                with: .color(.yellow))
        }
    }
}
