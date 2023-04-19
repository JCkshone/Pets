//
//  CatsScreenView.swift
//  Peets
//
//  Created by Juan Camilo Navarro on 19/04/23.
//

import SwiftUI

struct CatsScreenView: View {
    @ObservedObject private var viewModel = CatsViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.cats) { cat in
                    VStack {
                        Text(cat.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        AsyncImage(url:
                                    URL(string: "https://cdn2.thecatapi.com/images/\(cat.referenceImageID ?? .empty).jpg")
                        ) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                        
                        HStack {
                            Text("Origen: \(cat.origin)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                            Text("Inteligencia: \(cat.intelligence)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(.horizontal)
                    Divider()
                }
                
                
            }
            
        }
        .onAppear {
            viewModel.viewDidLoad()
        }
    }
}

struct CatsScreenView_Previews: PreviewProvider {
    static var previews: some View {
        CatsScreenView()
    }
}
