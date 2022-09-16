import TensorFlowLiteTaskVision

class DetectionResultModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var detections: [Detection]? = nil
    
    func reset(){
        image = nil
        detections = nil
    }
}
