//
//  ImageView.swift
//  listing-users
//
//  Created by Bernard Musaj on 4.1.23.
//

import SwiftUI

struct ImageView: View {
    @ObservedObject var imageLoader: ImageLoader
    @State var image: UIImage = UIImage()
    let size: CGFloat

    init(withURL url: String, _ size: CGFloat = 60) {
        imageLoader = ImageLoader(urlString: url)
        self.size = size
    }

    var body: some View {
        
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height: size)
                .clipShape(Circle())
                .onReceive(imageLoader.didChange) { data in
                self.image = UIImage(data: data) ?? UIImage()
        }
    }
}
