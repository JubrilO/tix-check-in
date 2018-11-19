//
//  ApolloClient.swift
//  tix
//
//  Created by Jubril on 18/11/2018.
//  Copyright © 2018 Tix. All rights reserved.
//
import Apollo
import Locksmith

let apolloClient: ApolloClient = {
    let configuration = URLSessionConfiguration.default
    let url = URL(string: APIConstants.GraphQLURL)!
    if let auth = Locksmith.loadDataForUserAccount(userAccount: Constants.TixUser)?["token"] as? String {
        configuration.httpAdditionalHeaders = ["Authorization": "Bearer " + auth]
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }
    else {
        print("Sign in user")
        return ApolloClient(url: url)
    }
}()
