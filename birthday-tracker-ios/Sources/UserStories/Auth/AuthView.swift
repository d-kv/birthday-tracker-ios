//
//  AuthView.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 18.03.2022.
//

import SwiftUI

struct AuthUIViewImpl: View, AuthView {
    
    let assembly: MainAssembly
    let presenter: AuthPresenter
    
    func showError(_ error: Error) {
        // TODO
    }
    
    func handleSuccess() {
        let vc = assembly.createMainViewController()
        self.present(vc, animated: true)
    }
    
    var body: some View {
        Text("Hello, Auth!")
    }
}

struct AuthUIView_Previews: PreviewProvider {
    static var previews: some View {
        AuthUIViewImpl(assembly: MainAssembly(),
                       presenter: AuthPresenterImpl())
    }
}
