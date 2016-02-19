//
//  OAuth2.m
//  XmazonMVD
//
//  Created by Pinson Celine on 15/02/2016.
//  Copyright (c) 2016 Pinson Celine. All rights reserved.
//

#import "OAuth2.h"

@implementation OAuth2

@synthesize user = user_;
@synthesize application = application_;


-(void)setTokensWithRefreshTokenWithTokenType:(int)type{
   NSLog(@"setTokensWithRefreshTokenWithTokenType\n");
    
    ///If type = 1 c'est un token de type application
    ///If type = 2 c'est un token de type user
    // 1
    NSURL *url = [NSURL URLWithString:@"http://xmazon.appspaces.fr/oauth/token"];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    // 2
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    NSString* param;
    if(type==1){ //Si on refresh application
        param = [[NSString alloc]initWithFormat:@"grant_type=refresh_token&refresh_token=%@&client_id=%@&client_secret=%@",[self.application objectForKey:@"refresh_token"], [OAuth2 getId],[OAuth2 getSecret]];
    }
    else{ //Si on refresh user
         param = [[NSString alloc]initWithFormat:@"grant_type=refresh_token&refresh_token=%@&client_id=%@&client_secret=%@",[self.user objectForKey:@"refresh_token"],[OAuth2 getId],[OAuth2 getSecret]];
    }
    [request setHTTPBody:[param dataUsingEncoding:NSUTF8StringEncoding ]];
    
    //3
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(!error){ ///gerer si le refresh token est plus bon non plus
            if(type==1){ //Refresh application
                NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
                NSLog(@" before refresh token : %@",self.application);
                self.application = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                NSLog(@" After refresh token : %@",self.application);
                [userDefaults setObject:self.application forKey:@"application"];
            }
            else{ //refresh user
                self.user = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:self.user forKey:@"application"];
            }
        }
        
    }] resume];
}

-(void)setUserTokens{
       NSLog(@"setUserTokens\n");
}

-(void)setTokens{
       NSLog(@"setTokens\n");
    // 1
    NSURL *url = [NSURL URLWithString:@"http://xmazon.appspaces.fr/oauth/token"];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    // 2
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    NSString* param = [[NSString alloc]initWithFormat:@"grant_type=client_credentials&client_id=%@&client_secret=%@",[OAuth2 getId],[OAuth2 getSecret]];
    [request setHTTPBody:[param dataUsingEncoding:NSUTF8StringEncoding ]];

    // 3
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(!error){
            self.application = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:self.application forKey:@"application"];
            }
        
        }] resume];
}


-(instancetype)initWithDictionaryUser:(NSMutableDictionary*)user andDictionaryApp:(NSMutableDictionary*)app{
       NSLog(@"initWithDictionaryUser\n");
    if (self  = [super init]) {
        if(user)
        {
            self.user = user;
        }
        if(app){
            self.application = app;
        }
        else{
            [self setTokens];///Implement methode to get tokens
        }
        
    }
    
    return self;
}



+(NSString *)getId{
    return @"9a67e07d-e2d9-4ff0-8a41-4735d5478839";
}

+(NSString *)getSecret{
    return @"7825276844ead1acabcd166f44466862836d84bf";
}

@end
