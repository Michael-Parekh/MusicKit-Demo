//
//  ContentView.swift
//  MusicKit Demo
//
//  Created by Michael Parekh on 4/9/23.
//

import MusicKit
import SwiftUI

// 'Item' represents a result of the search, which contains the name of the song, artist, and album image.
struct Item: Identifiable, Hashable {
    var id = UUID()
    let name: String
    let artist: String
    let imageUrl: URL?
}

struct ContentView: View {
    @State var songs = [Item]()
    
    var body: some View {
        NavigationView {
            List(songs) { song in
                HStack {
                    
                }
            }
        }
        .onAppear {
            fetchMusic()
        }
    }
    
    private func fetchMusic() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
