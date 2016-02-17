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


-(void)setTokensWithRefreshToken{
    
}

-(void)setUserTokens{
    
}

-(void)setTokens{
    
    // 1
    NSURL *url = [NSURL URLWithString:@"http://xmazon.appspaces.fr/oauth/token"];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    // 2
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    NSString* param = [[NSString alloc]initWithFormat:@"grant_type=client_credentials&client_id=%@&client_secret=%@",[OAuth2 getId],[OAuth2 getSecret]];
    [request setHTTPBody:[param dataUsingEncoding:NSUTF8StringEncoding ]];

        // 4
        [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if(!error){
                self.application = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:self.application forKey:@"application"];
            }
        
        }] resume];
}


-(instancetype)initWithDictionaryUser:(NSMutableDictionary*)user andDictionaryApp:(NSMutableDictionary*)app{
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
