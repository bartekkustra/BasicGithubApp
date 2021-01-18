//
//  Oauth2Model.swift
//  GithubFeed
//
//  Created by Aleksandra Kustra on 17/01/2021.
//

import OAuth2

struct Oauth2Model {
    let oauth2 = OAuth2CodeGrant(settings: [
        "client_id": "5a146be86fedb153109a",
        "client_secret": "cd066e9ecf254605c3b085e0f547a4aed5cc66aa",
        "authorize_uri": "https://github.com/login/oauth/authorize",
        "token_uri": "https://github.com/login/oauth/access_token",
        "redirect_uris": ["com.basicgithubapp://oauth/callback"],
        "scope": "user repo",
        "secret_in_body": true,
        "keychain": false,
    ] as OAuth2JSON)
}
