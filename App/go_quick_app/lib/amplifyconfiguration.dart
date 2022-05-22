const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "ap-southeast-1:16741676-88b1-4a39-9723-72505277d262",
                            "Region": "ap-southeast-1"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "ap-southeast-1_37S61es1w",
                        "AppClientId": "28fnl2kg71m7tpphb6pstc4kfs",
                        "Region": "ap-southeast-1"
                    }
                },
                "Auth": {
                    "Default": {
                        "authenticationFlowType": "USER_SRP_AUTH",
                        "socialProviders": [],
                        "usernameAttributes": [
                            "EMAIL"
                        ],
                        "signupAttributes": [
                            "EMAIL"
                        ],
                        "passwordProtectionSettings": {
                            "passwordPolicyMinLength": 8,
                            "passwordPolicyCharacters": []
                        },
                        "mfaConfiguration": "OFF",
                        "mfaTypes": [
                            "SMS"
                        ],
                        "verificationMechanisms": [
                            "EMAIL"
                        ]
                    }
                },
                "AppSync": {
                    "Default": {
                        "ApiUrl": "https://x3u55bia6ncznmcxxolyi5sb3m.appsync-api.ap-southeast-1.amazonaws.com/graphql",
                        "Region": "ap-southeast-1",
                        "AuthMode": "API_KEY",
                        "ApiKey": "da2-nwv3he6zzrbppjgs4czgxhanbq",
                        "ClientDatabasePrefix": "goquickappflutter_API_KEY"
                    }
                },
                "S3TransferUtility": {
                    "Default": {
                        "Bucket": "goquickappflutter8def6002b0a548c2b67a654e37e04f02325-dev",
                        "Region": "ap-southeast-1"
                    }
                }
            }
        }
    },
    "api": {
        "plugins": {
            "awsAPIPlugin": {
                "goquickappflutter": {
                    "endpointType": "GraphQL",
                    "endpoint": "https://x3u55bia6ncznmcxxolyi5sb3m.appsync-api.ap-southeast-1.amazonaws.com/graphql",
                    "region": "ap-southeast-1",
                    "authorizationType": "API_KEY",
                    "apiKey": "da2-nwv3he6zzrbppjgs4czgxhanbq"
                }
            }
        }
    },
    "storage": {
        "plugins": {
            "awsS3StoragePlugin": {
                "bucket": "goquickappflutter8def6002b0a548c2b67a654e37e04f02325-dev",
                "region": "ap-southeast-1",
                "defaultAccessLevel": "guest"
            }
        }
    }
}''';