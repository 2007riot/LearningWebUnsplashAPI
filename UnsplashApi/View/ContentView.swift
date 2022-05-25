//
//  ContentView.swift
//  UnsplashApi
//
//  Created by Galina Aleksandrova on 18/05/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var searchObjectController = SearchObjectController.shared
    var body: some View {
        NavigationView {
        ScrollView  {
            TextField("Search for photos", text: $searchObjectController.searchText)
                .onSubmit {
                    searchObjectController.search()
                }
                .textFieldStyle(.roundedBorder)
            if searchObjectController.results.isEmpty {
                Text ("Start from searching photos")
                    .font(.title2)
            } else {
            VStack(spacing: 30) {
            ForEach (searchObjectController.results, id: \.id) { result in
                
                HStack {
                    Spacer ()
                    VStack (spacing: 15) {
                    AsyncImage(url: URL(string: result.urls.small)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
//                            .scaledToFill()
                            .frame(width: 250.0, height: 250.0)
                            .clipShape(Circle())
                    } placeholder: {
                        ProgressView()
                    }
                    //.frame(width: 150, height: 150)
                        
                        Text(result.user.name.capitalized)
                            .font(.headline)
                }
                    Spacer()
                }
            }
            }
            }
        }
        .padding()
        .navigationTitle("Unsplash Photos")
                
//                .searchable(text: $searchObjectController.searchText)
//                .navigationTitle("Unspash Images")
//                .onChange(of: searchObjectController.searchText) { newValue in
//                    searchObjectController.search()
//                }
                
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
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
