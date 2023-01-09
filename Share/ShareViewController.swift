import UIKit
import Social
import UniformTypeIdentifiers
import SwiftUI

@objc(ShareNavigationController)
class ShareNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        retrieveSharedURL { [weak self] url in
            guard let url = url else {
                let error = NSError(domain: "your_bundle_id", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to retrieve the url"])
                self?.extensionContext?.cancelRequest(withError: error)
                return
            }
            
            self?.openShareUrlView(url: url)
        }
    }
    
    func retrieveSharedURL(_ completion: @escaping (URL?) -> ()) {
        let attachment = (extensionContext?.inputItems as? [NSExtensionItem])?
            .reduce([], { $0 + ($1.attachments ?? []) })
            .first(where: { $0.hasItemConformingToTypeIdentifier(UTType.url.identifier) })
        
        if let attachment = attachment {
            attachment.loadItem(forTypeIdentifier: UTType.url.identifier, options: nil) { (item, _) in
                completion(item as? URL)
            }
        }
    }
    
    func openShareUrlView(url: URL) {
        DispatchQueue.main.async {
            let childView = UIHostingController(rootView: ShareDetailsView(url: url))
            self.addChild(childView)
            childView.view.frame = self.view.bounds
            self.view.addSubview(childView.view)
            childView.didMove(toParent: self)
        }
    }
}
