//
//  ContentView.swift
//  ClassMatch
//
//  Created by Megan Shah on 1/28/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showLoginScreen = false

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            ZStack{
                Color.blue
                    .ignoresSafeArea()
                Circle ()
                    .scale(1.8)
                    .foregroundColor(.white.opacity(0.3))
                
                Circle ()
                    .scale(1.47)
                    .foregroundColor(.white.opacity(3))
                VStack{
                    HStack {
                        Text("Class").foregroundColor(.blue).font(.largeTitle).bold().padding()
                        Text("Match").foregroundColor(.black).font(.largeTitle).bold().padding(.horizontal, -20)
    
                }
                    Text("Login")
                        .foregroundColor(.gray)
                        .font(.title2)
                        .bold()
                        .padding()
                    TextField("Username", text: $username)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongUsername))
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongPassword))
                    
                    Button("Login") {
                        userVerification(username: username, password: password)
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    
                    NavigationLink(destination: HStack {
                        Text("                Welcome            ")
                        .bold()
                        .font(.largeTitle) + Text( "   \n       @\(username)").bold().font(.largeTitle).foregroundColor(Color.gray)
                        
                        + Text(" \n \n \n     ClassMatch is an app designed to help make  \n      real connections in your classes at the tip of \n     your fingers. ").bold().foregroundColor(Color.blue)} , isActive: $showLoginScreen) {
                        
                        AnyView(_fromValue: "Hello")
                        
                    }
                    
                }
    
                
            
            }
            .navigationBarHidden(true)
        }
        
    }
    
    func userVerification (username: String, password: String) {
        if username.count >= 6 {
            wrongUsername = 0
            
            if password.count >= 6 {
                wrongPassword = 0
                showLoginScreen = true
            }
            
            else {
                wrongPassword = 2
            }
        }
        
        else {
            wrongUsername = 2
        }
        
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

