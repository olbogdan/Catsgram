//
//  TakePhotoViewController.swift
//  Catsgram
//
//  Created by Oleksndr Bogdanov on 25.10.21.
//

import SwiftUI
import UIKit

class TakePhotoViewController: UIViewController {
    let completionHandler: (UIImage) -> Void
    @IBOutlet var previewView: CameraPreviewView!
    var captureController: PhotoCaptureController!

    init?(coder: NSCoder, completionHandler: @escaping (UIImage) -> Void) {
        self.completionHandler = completionHandler
        super.init(coder: coder)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        captureController = PhotoCaptureController(previewView: previewView, alertPresenter: self, captureCompletionHandler: completionHandler)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        captureController.startSession()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        captureController.stopSession()
    }

    @IBAction func takePhotoTapped() {
        captureController.capturePhoto()
    }
}

struct TakePhotoView: UIViewControllerRepresentable {
    let onPhotoCapture: (UIImage) -> Void

    func makeUIViewController(context: Context) -> TakePhotoViewController {
        let storyboard = UIStoryboard(name: "TakePhotoStoryboard", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "TakePhotoViewController") { coder in
            TakePhotoViewController(coder: coder, completionHandler: onPhotoCapture)
        }
        return controller
    }

    func updateUIViewController(_ uiViewController: TakePhotoViewController, context: Context) {
        // nothing to do
    }
}

struct TakePhotoView_Preview: PreviewProvider {
    static var previews: some View {
        TakePhotoView { _ in
        }
    }
}
