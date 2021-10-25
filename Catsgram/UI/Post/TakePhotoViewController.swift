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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    init?(coder: NSCoder, completionHandler: @escaping (UIImage) -> Void) {
        self.completionHandler = completionHandler
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
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
        return TakePhotoView { Image in

        }
    }
}
