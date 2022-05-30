//
//  ResultListView.swift
//  UnsplashApi
//
//  Created by Galina Aleksandrova on 26/05/22.
//

import SwiftUI

struct ResultListView: View {
   
    @StateObject var apiResultFetcher = SearchResultFetcher()
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search images", text: $apiResultFetcher.searchText)
                    .onSubmit {
                        apiResultFetcher.fetch()
                    }
                    .padding()
                    .textFieldStyle(.roundedBorder)
                Group {
                    if apiResultFetcher.isLoading {
                        ProgressView()
                        Spacer ()
                    } else if apiResultFetcher.errorMessage != nil {
                        ErrorMainView(apiResultFetcher: apiResultFetcher)
                        Spacer()
                    } else {
                        List {
                            ForEach(apiResultFetcher.apiResults, id: \.self) { apiResult in
                                
                                NavigationLink {
                                    ImageDetailView(apiResult: apiResult)
                                } label: {
                                    APIResultRow(apiresult: apiResult)
                                }
                            }
                        }
                        .listStyle(.plain)
                        .navigationTitle("Unsplash")
                    }
                }

                    
            }
            }
                .onAppear() {
            //so we safe network data usage, but increase our phone memory with images 
            print("cache size: \(URLCache.shared.memoryCapacity / 1024) KB")
            //increase cache size to half of gigabyte
            URLCache.shared.memoryCapacity = 1024 * 1024 * 512
        }
    }
}

struct ResultListView_Previews: PreviewProvider {
    static var previews: some View {
        ResultListView()
    }
}
