//
//  ContentView.swift
//  Periodic Table
//
//  Created by Student on 2/25/21.
//

import SwiftUI

struct ContentView: View {
    @State private var elements = [Element]()
    var body: some View {
        NavigationView {
            List(elements) { element in
                NavigationLink(
                    destination: VStack {
                        Text(element.symbol)
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                        Text(element.name)
                        Text("Atomic Number: \(element.atomicNumber)")
                            .padding()
                        Text("Atomic Mass: \(element.atomicMass)")
                        Text(element.history)
                            .padding()
                    },
                    label: {
                        HStack {
                            Text(element.symbol)
                            Text(element.name)
                        }
                    })
            }
            .navigationTitle("Periodic Table")
        }
        .onAppear(perform: {
            queryAPI()
        })
    }
    func queryAPI() {
        let apiKey = "?rapidapi-key=53c34bdf56msha93492520b56cffp1c92cajsn116ab7eb6ea6"
        let query = "https://periodictable.p.rapidapi.com/\(apiKey)"
        if let url = URL(string: query) {
            if let data = try? Data(contentsOf: url) {
                let json = try! JSON(data: data)
                let contents = json.arrayValue
                for item in contents {
                    let symbol = item["symbol"].stringValue
                    let name = item["name"].stringValue
                    let atomicNumber = item["atomicNumber"].stringValue
                    let atomicMass = item["atomicMass"].stringValue
                    let history = item["history"].stringValue
                    let element = Element(symbol: symbol, name: name, atomicNumber: atomicNumber, atomicMass: atomicMass, history: history)
                    elements.append(element)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Element: Identifiable {
    let id = UUID()
    let symbol: String
    let name: String
    let atomicNumber: String
    let atomicMass: String
    let history: String
}
