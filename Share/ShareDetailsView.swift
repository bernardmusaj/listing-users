//
//  ShareDetailsView.swift
//  Share
//
//  Created by Bernard Musaj on 8.1.23.
//

import SwiftUI
import OpenGraph

struct ShareDetailsView: View {
    
    var url: URL
    @State private var openGraphData = OpenGraphData()
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Text("SHARE WITH YOUR CLIENT")
                HStack {
                    AsyncImage(url: openGraphData.imageURL) { image in
                        image.resizable().aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }.frame(width: 80)
                    
                    VStack(alignment: .leading) {
                        if let title = openGraphData.title {
                            Text(title).font(.title3).bold()
                        }
                        
                        if let description = openGraphData.description {
                            Text(description)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.leading)
                        }
                    }
                }
            }
            .padding(8)
            .background(Color(red: 250/255, green: 250/255, blue: 250/255))
            .frame(height: 120)
        }.padding(.init(top: 0, leading: 0, bottom: 60, trailing: 0))
        .task {
            await fetchData(from: url)
        }
    }

private func fetchData(from url: URL) async {
    do {
        let openGraph = try await OpenGraph.fetch(url: url)
        
        let data = OpenGraphData(
            title: openGraph[.title],
            link: URL(string: openGraph[.url] ?? ""),
            type: openGraph[.type],
            siteName: openGraph[.siteName],
            description: openGraph[.description],
            imageURL: URL(string: openGraph[.image] ?? "")
        )
        
        self.openGraphData = data
    } catch {
        print(error)
    }
}
}

struct ShareDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ShareDetailsView(url: URL(string: "https://www.apple.com/iphone-se/")!)
    }
}
