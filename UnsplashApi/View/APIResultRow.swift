//
//  APIResultRow.swift
//  UnsplashApi
//
//  Created by Galina Aleksandrova on 18/05/22.
//

import SwiftUI

struct APIResultRow: View {
    
    let imageSize: CGFloat = 300
    let apiresult: APIResult
    
    var body: some View {
        VStack (alignment: .leading, spacing: 10) {
            if apiresult.urls?.regular != nil {
                LoadImageView(url: apiresult.urls!.regular)
                //LoadImageView(url: apiresult.urls!.thumb)
            } else {
                Color
                    .gray
                    .frame(width: imageSize, height: imageSize, alignment: .leading)
            }
            VStack(alignment: .leading, spacing: 5) {
               
                    Text(apiresult.user.name)
                    .font(.title3)
                    .bold()
                        
                
                Text("from Unsplash")
                    .underline()
                    .foregroundColor(.blue)
                    .onTapGesture {
                        UIApplication.shared.open(URL(string: apiresult.user.userLinks?.htmlProfile ?? "https://unsplash.com/")!)
                    }
                if let description = apiresult.description {
                    Text(description)
                        .font(.footnote)
                        .frame(width: UIScreen.main.bounds.width * 0.9, alignment: .leading)
                }
            }
        }
    }
}

struct APIResultRow_Previews: PreviewProvider {
    static var previews: some View {
        APIResultRow(apiresult: APIResult.example1())
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
