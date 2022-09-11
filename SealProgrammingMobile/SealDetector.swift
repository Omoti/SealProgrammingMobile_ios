// https://www.tensorflow.org/lite/inference_with_metadata/task_library/object_detector

// Imports
import TensorFlowLiteTaskVision

struct SealDetector{
    static func detect(image: UIImage) -> [Detection]? {
        // Initialization
        guard let modelPath = Bundle.main.path(forResource: "seals_model",
                                               ofType: "tflite")
        else {
            print("Failed to load the model file with name: seals_model.")
            return nil
            
        }
        
        let options = ObjectDetectorOptions(modelPath: modelPath)
        options.classificationOptions.scoreThreshold = 0.4
        
        do{
            // Configure any additional options:
            // options.classificationOptions.maxResults = 3
            
            let detector = try ObjectDetector.detector(options: options)
            
            // Convert the input image to MLImage.
            // There are other sources for MLImage. For more details, please see:
            // https://developers.google.com/ml-kit/reference/ios/mlimage/api/reference/Classes/GMLImage
            guard let mlImage = MLImage(image: image) else { return nil }
            
            // Run inference
            let detectionResult = try detector.detect(mlImage: mlImage)
            
            print(detectionResult)
            
            return detectionResult.detections.filter({ detection in
                detection.boundingBox.width < mlImage.width / 2
            }).sorted { d1, d2 in
                // 左右位置が重なったら上下で比較
                if ((d1.boundingBox.minX > d2.boundingBox.minX
                     && d1.boundingBox.minX < d2.boundingBox.maxX)
                    || (d1.boundingBox.minX < d2.boundingBox.maxX
                        && d1.boundingBox.maxX > d2.boundingBox.minX)
                ) {
                    return (d2.boundingBox.minY - d1.boundingBox.minY)  < 0
                }
                
                // 上記以外は左右位置で比較
                return (d1.boundingBox.maxX - d2.boundingBox.maxX) < 0
                
            }
        }catch{
            return nil
        }
    }
}
