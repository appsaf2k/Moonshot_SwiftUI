//
//  ContentView.swift
//  Moonshot
//
//  Created by @andreev2k on 12.09.2022.
//

import SwiftUI

struct MainView: View {
    @State private var viewStile = false
    // переносим финкциональность из (extension Bundle)
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columns1 = [GridItem(.adaptive(minimum: 150))]
    let columns2 = [GridItem(.adaptive(minimum: 200))]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: viewStile ? columns1 : columns2) {
                    ForEach(missions) { missions in
                        NavigationLink {
                            MissionView(mission: missions, astronauts: astronauts)
                        } label: {
                            VStack {
                                Image(missions.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding()
                                VStack {
                                    Text(missions.displayName)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    
                                    Text(missions.dateFormatted)
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.5))
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay (
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightBackground)
                            )
                            
                        }
                    }
                }
                .padding([.horizontal, .bottom])
                .animation(.default)
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button {
                    viewStile.toggle()
                } label: {
                    Image(systemName: viewStile ? "rectangle.grid.1x2" : "rectangle.grid.2x2")
                        .foregroundColor(.secondary)
                        .animation(.default)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
