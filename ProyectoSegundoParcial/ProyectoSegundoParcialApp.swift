import SwiftUI
import Firebase

@main
struct ProyectoSegundoParcialApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
