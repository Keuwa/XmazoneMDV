//
//  OAuth2.m
//  XmazonMVD
//
//  Created by Pinson Celine on 15/02/2016.
//  Copyright (c) 2016 Pinson Celine. All rights reserved.
//

#import "OAuth2.h"

@implementation OAuth2

@synthesize access_token = access_token_;
@synthesize refresh_token = refresh_token_;
@synthesize type = type_;

-(void)setTokens{
    
}

-(void)setTokensWithRefreshToken{
    
}



+(NSString *)getId{
    return @"9a67e07d-e2d9-4ff0-8a41-4735d5478839";
}

+(NSString *)getSecret{
    return @"7825276844ead1acabcd166f44466862836d84bf";
}

@end
