//
//  ContentView.swift
//  SwiftClient
//
//  Created by Mohammad Azam on 4/13/21.
//

import SwiftUI

struct ContentView: View {
        
    @StateObject private var loginVM = LoginViewModel()
    @StateObject private var accountListVM = AccountListViewModel()
    
    var body: some View {
        VStack {
            Form {
                HStack {
                    Spacer()
                    Image(systemName: loginVM.isAuthenticated ? "lock.fill": "lock.open")
                }
                TextField("Username", text: $loginVM.username)
                SecureField("Password", text: $loginVM.password)
                HStack {
                    Spacer()
                    Button("Login") {
                        loginVM.login()
                    }
                    Button("Signout") {
                        loginVM.signout()
                        accountListVM.accounts.removeAll()
                    }
                    Spacer()
                }
            }.buttonStyle(PlainButtonStyle())
            
            VStack {
                
                Spacer() 
                if loginVM.isAuthenticated && accountListVM.accounts.count > 0 {
                    List(accountListVM.accounts, id: \.id) { account in
                        HStack {
                            Text("\(account.name)")
                            Spacer()
                            Text(String(format: "$%.2f", account.balance))
                        }
                    }.listStyle(PlainListStyle())
                } else {
                    Text("Login to see your accounts!")
                }
                
                Spacer()
                
                Button("Get Accounts") {
                    accountListVM.getAllAccounts()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            
           
        } .onAppear(perform: {
           
        })
        .navigationTitle("Login")
        .embedInNavigationView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
