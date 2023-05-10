//
//  ContentView.swift
//  game2048
//
//  Created by Rustem Orazbayev on 5/7/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GridView()
            .frame(width: 400, height: 400)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
