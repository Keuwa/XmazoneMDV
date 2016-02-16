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
    NSString* type_;
    NSString* access_token_;
    NSString* refresh_token_;
    
}
@property (nonatomic,strong)NSString* type;
@property (nonatomic,strong)NSString* refresh_token;
@property (nonatomic,strong)NSString* access_token;



-(void)setTokens;
-(void)setTokensWithRefreshToken;
+(NSString*)getId;
+(NSString*)getSecret;
@end
