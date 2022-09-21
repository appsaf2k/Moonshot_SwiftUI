//
//  CrewMission.swift
//  Moonshot
//
//  Created by @andreev2k on 13.09.2022.
//

import SwiftUI

struct MissionView: View {
    // структура для хранения астронавта и его роли в миссии
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let crew: [CrewMember]
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geo.size.width * 0.6)
                        .padding(.top)
                    
                    Text(mission.dateFormatted)
    
                    VStack(alignment: .leading) {
                        Rectangle()
                            .frame(height: 2)
                            .padding(.top)
                            .foregroundColor(.lightBackground)
                        Text("Mission Highlight")
                            .font(.title.bold())
                            .padding(.bottom)
                        
                        Text(mission.description)
                        
                        Rectangle()
                            .frame(height: 2)
                            .padding(.bottom)
                            .foregroundColor(.lightBackground)
                        
                        Text("Crew")
                            .font(.title2.bold())
                    }
                    .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(crew, id: \.role) { crew in
                                NavigationLink {
                                    AstronautView(astronaut: crew.astronaut)
                                } label: {
                                    Image(crew.astronaut.id)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 104)
                                        .clipShape(Capsule())
                                        .overlay {
                                            Capsule()
                                                .strokeBorder(.white)
                                        }
                                        .padding(.horizontal)
                                    
                                    VStack(alignment: .leading) {
                                        Text(crew.astronaut.name)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        Text(crew.role)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    // делаем свой инит для правильного отображения команды миссии
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Миссия \(member.name)")
            }
        }
    }
}

struct CrewMission_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        MissionView(mission: missions[4], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
