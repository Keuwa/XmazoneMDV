//
//  OAuth2.h
//  XmazonMVD
//
//  Created by Pinson Celine on 15/02/2016.
//  Copyright (c) 2016 Pinson Celine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OAuth2 : NSObject
// Classe qui contient les différents éléments nécessaire au protocole OAuth2 token/refreshtoken/ID/Secret
{
    NSMutableDictionary* application_; //Contient le retour de oauth/token credentials
    NSMutableDictionary* user_;        //Contient le retour de oauth/token password
}
@property (nonatomic,strong)NSMutableDictionary* application;
@property (nonatomic,strong)NSMutableDictionary* user;


-(instancetype)initWithDictionaryUser:(NSMutableDictionary*)user andDictionaryApp:(NSMutableDictionary*)app;



-(void)setTokensWithRefreshToken;
-(void)setTokens;
-(void)setUserTokens;


+(NSString*)getId;
+(NSString*)getSecret;
@end
