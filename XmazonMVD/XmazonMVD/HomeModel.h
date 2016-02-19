//
//  HomeModel.h
//  XmazonMVD
//
//  Created by Pinson Celine on 15/02/2016.
//  Copyright (c) 2016 Pinson Celine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OAuth2.h"

@interface HomeModel : NSObject 
{
    @private
    OAuth2 *oauth_;
    NSMutableArray* listMagasin_;
    
}
@property (nonatomic,strong)OAuth2* oauth;
@property (nonatomic,strong)NSMutableArray* listMagasin;

-(instancetype)initWithOauth:(OAuth2*)oauth;


@end
