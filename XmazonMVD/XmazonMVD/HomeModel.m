//
//  HomeModel.m
//  XmazonMVD
//
//  Created by Pinson Celine on 15/02/2016.
//  Copyright (c) 2016 Pinson Celine. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

@synthesize listMagasin = listMagasin_;
@synthesize oauth = oauth_;

-(instancetype)initWithOauth:(OAuth2 *)oauth{
    NSLog(@"InitWithOauth\n");
    if(self = [super init]){
        self.oauth = oauth;
        //Init le tableau avec tous les magasins
        // 1
        NSURL *url = [NSURL URLWithString:@"http://xmazon.appspaces.fr/store/list"];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        
        // 2
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        request.HTTPMethod = @"GET";
        NSString* str = [[NSString alloc]initWithFormat:@"Bearer %@",[oauth.application objectForKey:@"access_token"]];
        NSMutableDictionary* headers = [request.allHTTPHeaderFields mutableCopy];
        [headers setObject:str forKey:@"Authorization"];
        request.allHTTPHeaderFields = headers;

        
        // 3
        [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if(!error){
                NSDictionary* code =[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                if([[[code objectForKey:@"code"]description] isEqualToString:@"0"])
                {
                    self.listMagasin = [[NSMutableArray alloc]initWithArray:[code objectForKey:@"result"]];
                }
                else if([[[code objectForKey:@"code"]description] isEqualToString:@"401"]){
                    NSLog(@"Refresh_token used : %@",[oauth.application objectForKey:@"refresh_token"]);

                    [oauth setTokensWithRefreshTokenWithTokenType:1];
                    [NSThread sleepForTimeInterval:2.0f];

                    //On refais la requete avec les nouveaux token
                    NSString* str = [[NSString alloc]initWithFormat:@"Bearer %@",[oauth.application objectForKey:@"access_token"]];
                    NSLog(@"Acces token : %@",[oauth.application objectForKey:@"access_token"]);
                    NSMutableDictionary* headers = [request.allHTTPHeaderFields mutableCopy];
                    [headers setObject:str forKey:@"Authorization"];
                    request.allHTTPHeaderFields = headers;
                    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                        if(!error){
                            NSDictionary* code =[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                            if([[[code objectForKey:@"code"]description] isEqualToString:@"0"])
                            {
                                self.listMagasin = [[NSMutableArray alloc]initWithArray:[code objectForKey:@"result"]];
                                NSLog(@"%@",listMagasin_);
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
            
        }] resume];
        
    }
    
    return self;
}

@end
