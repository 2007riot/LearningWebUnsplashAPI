//
//  APIResultRow.swift
//  UnsplashApi
//
//  Created by Galina Aleksandrova on 18/05/22.
//

import SwiftUI

struct APIResultRow: View {
    
    let imageSize: CGFloat = 300
    let apiresult: APIResults
    
    var body: some View {
        HStack {
            if apiresult.urls?.thumb != nil {
                LoadImageView1(searchResultFetcher: <#T##SearchResultFetcher#>)
                LoadImageView(url: apiresult.urls!.thumb)
            } else {
                Color
                    .gray
                    .frame(width: imageSize, height: imageSize, alignment: .center)
            }
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    
                    Text("\(apiresult.user.name) from")
                    Text("Unsplash")
                        .onTapGesture {
                            UIApplication.shared.open(URL(string: apiresult.user.portfoliURL ?? "https://unsplash.com/")!)
                        }
                }
                    .font(.headline)
            }
        }
    }
}

struct APIResultRow_Previews: PreviewProvider {
    static var previews: some View {
        APIResultRow(apiresult: APIResults.example1())
    }
}

//{ phase in
//    if let image = phase.image {
//        image
//            .resizable()
//            .aspectRatio(contentMode: .fit)
//
//
//    } else if (phase.error != nil) {
//        Color.red
//    }
//}


//AsyncImage(url: URL(string: result.urls.small))
//
//    .frame(width: 100, height: 100)


//{
//ScrollView  {
//    TextField("Search for photos", text: $apiFetcher.searchText)
//        .onSubmit {
//            apiFetcher.fetchImages()
//        }
//        .textFieldStyle(.roundedBorder)
//    if apiFetcher.results.isEmpty {
//        Text ("Start from searching photos")
//            .font(.title2)
//    } else {
//    VStack(spacing: 30) {
//    ForEach (apiFetcher.results, id: \.id) { result in
//
//        HStack {
//            Spacer ()
//            VStack (spacing: 15) {
//            AsyncImage(url: URL(string: result.urls.small)) { image in
//                image
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
////                            .scaledToFill()
//                    .frame(width: 250.0, height: 250.0)
//                    .clipShape(Circle())
//            } placeholder: {
//                ProgressView()
//            }
//            //.frame(width: 150, height: 150)
//
//                Text(result.user.name.capitalized)
//                    .font(.headline)
//        }
//            Spacer()
//        }
//    }
//    }
//    }
//}
//.padding()
//.navigationTitle("Unsplash Photos")
//
////                .searchable(text: $searchObjectController.searchText)
////                .navigationTitle("Unspash Images")
////                .onChange(of: searchObjectController.searchText) { newValue in
////                    searchObjectController.search()
////                }
//
//}
