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
    NSURL * url = [NSURL URLWithString:@"http://xmazon.appspaces.fr/oauth/token"];
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
                [self setTokens];
            }
            else{ //refresh user
                self.user = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:self.user forKey:@"application"];
            }
        }
        
    }] resume];
}

-(void) createUserWithEmail: (NSString *) email andPassword: (NSString *) password
{
    // 1
    NSURL * url = [ NSURL URLWithString:@"http://xmazon.appspaces.fr/auth/subscribe" ];
    NSURLSessionConfiguration * config = [ NSURLSessionConfiguration defaultSessionConfiguration ];
    NSURLSession * session = [ NSURLSession sessionWithConfiguration: config ];
    NSMutableURLRequest * request = [ [NSMutableURLRequest alloc] initWithURL: url ];
    NSString * str = [ [NSString alloc]initWithFormat:@"Bearer %@", [self.application objectForKey:@"access_token"] ];
    NSMutableDictionary* headers = nil;
    
    request.HTTPMethod = @"POST";
    
    headers = [request.allHTTPHeaderFields mutableCopy];
    [headers setObject:str forKey:@"Authorization"];
    request.allHTTPHeaderFields = headers;
    
    NSString* param = [[NSString alloc]initWithFormat:@"email=%@&password=%@",email, password];
    [request setHTTPBody:[param dataUsingEncoding:NSUTF8StringEncoding ]];
    
    
    NSLog(@"Access token : %@",[self.application objectForKey:@"access_token"]);
    
    // 3
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(!error){
            NSDictionary* code =[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            if([[[code objectForKey:@"code"]description] isEqualToString:@"0"])
            {
                //self.listMagasin = [[NSMutableArray alloc]initWithArray:[code objectForKey:@"result"]];
                NSLog( @"%@", [code objectForKey:@"result"] );
            }
            
            else if([[[code objectForKey:@"code"]description] isEqualToString:@"401"]){
                NSLog(@"Refresh_token used : %@",[self.application objectForKey:@"refresh_token"]);
                
                [self setTokensWithRefreshTokenWithTokenType:1];
                [NSThread sleepForTimeInterval:2.0f];
                
                //On refais la requete avec les nouveaux token
                NSString* str = [[NSString alloc]initWithFormat:@"Bearer %@",[self.application objectForKey:@"access_token"]];
                NSLog(@"Acces token : %@",[self.application objectForKey:@"access_token"]);
                NSMutableDictionary* headers = [request.allHTTPHeaderFields mutableCopy];
                [headers setObject:str forKey:@"Authorization"];
                request.allHTTPHeaderFields = headers;
                [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    if(!error){
                        NSDictionary* code =[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                        if([[[code objectForKey:@"code"]description] isEqualToString:@"0"])
                        {
                            NSLog( @"%@", [code objectForKey:@"result"] );
                        }
                        else{
                            NSLog(@"Uncaugth error %@ dans le refresh token ligne 59",[code objectForKey:@"code"]);
                        }
                    }
                }] resume];
                ///Fin de la deuxieme requete
            }
            else{
                NSLog(@"Uncaugth error %@",[code objectForKey:@"code"]);
            }
        }
        
    }] resume];}

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


-(instancetype)initWithDictionaryUser:(NSMutableDictionary*)user andDictionaryApp:(NSMutableDictionary*)app
{
    NSLog(@"initWithDictionaryUser\n");
    
    if( self  = [super init] )
    { 
        if( user )
        {
            self.user = user;
        }
        
        if( app )
        {
            self.application = app;
        }
        else
        {
            [self setTokens];///Implement methode to get tokens
        }
        
    }
    
    return self;
}



+(NSString *)getId
{
    return @"9a67e07d-e2d9-4ff0-8a41-4735d5478839";
}

+(NSString *)getSecret
{
    return @"7825276844ead1acabcd166f44466862836d84bf";
}

@end
