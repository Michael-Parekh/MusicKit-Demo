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
    
    // Use a private anonymous closure to hold the request (fetch items from the Apple Music catalog using a search term).
    private let request: MusicCatalogSearchRequest = {
        var request = MusicCatalogSearchRequest(term: "Happy", types: [Song.self])
        request.limit = 25
        return request
    }()
    
    private func fetchMusic() {
        Task {
            // Request permissions to leverage Apple Music.
            let status = await MusicAuthorization.request()
            
            switch status {
            case .authorized:
                // Make a request => get response containing songs.
                do {
                    let result = try await request.response()
                    // Compact map the result songs into the declared 'Item' struct (since we are updating the 'songs' state, the view should update automatically).
                    self.songs = result.songs.compactMap({
                        return .init(name: $0.title,
                                     artist: $0.artistName,
                                     imageUrl: $0.artwork?.url(width: 75, height: 75))
                    })
                } catch {
                    print(String(describing: error))
                }
            default:
                break
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
