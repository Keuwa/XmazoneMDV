//
//  CategoryModel.h
//  XmazonMVD
//
//  Created by Wayne Kyle on 01/03/2016.
//  Copyright © 2016 Pinson Celine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OAuth2.h"

@interface CategoryModel : NSObject
{
    @private
    OAuth2 *oauth_;
    NSMutableArray* listCategory_;
    
}

@property (nonatomic,strong)OAuth2* oauth;
@property (nonatomic,strong)NSMutableArray* listCategory;

-(instancetype)initWithOauth:(OAuth2*)oauth;

@end
