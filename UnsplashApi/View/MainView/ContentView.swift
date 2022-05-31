//
//  ContentView.swift
//  UnsplashApi
//
//  Created by Galina Aleksandrova on 26/05/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var apiResultFetcher = SearchResultFetcher()
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Group {
                    if apiResultFetcher.isLoading {
                        ProgressView()
                    } else if apiResultFetcher.errorMessage != nil {
                        ErrorMainView(apiResultFetcher: apiResultFetcher)
                    } else {
                        ResultListView(apiResults: apiResultFetcher.apiResults)
                    }
                }
                .navigationTitle("Unsplash")
            }
        }
        .navigationViewStyle(.stack)
        .searchable(text: $apiResultFetcher.searchText, placement: .navigationBarDrawer)
        .onSubmit(of: .search, {
            
            apiResultFetcher.fetch()
        })
        
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
