//
//  ApolloClient.swift
//  tix
//
//  Created by Jubril on 18/11/2018.
//  Copyright © 2018 Tix. All rights reserved.
//
import Apollo
import Locksmith

class ApolloManager {
    //static let shared = ApolloManager()
    
    let apolloClient: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        let url = URL(string: APIConstants.GraphQLURL)!
        if let auth = Locksmith.loadDataForUserAccount(userAccount: Constants.TixUser)?["token"] as? String {
            let authToken = ["Authorization": "Bearer " + auth]
            print(authToken)
            configuration.httpAdditionalHeaders = authToken
            return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
        }
        else {
            print("Sign in user")
            return ApolloClient(url: url)
        }
    }()
}
