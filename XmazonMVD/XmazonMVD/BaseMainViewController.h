//
//  BaseMainViewController.h
//  XmazonMVD
//
//  Created by Wayne Kyle on 01/03/2016.
//  Copyright © 2016 Pinson Celine. All rights reserved.
//


/*
 
 This view is dedicated to allow the user to choose between:
 
 - admin
 
 or
 
 - user
 
 */
#import <UIKit/UIKit.h>
#import "OAuth2.h"

@interface BaseMainViewController : UIViewController
{
@private
    OAuth2 *oauth_;
    
}
@property (nonatomic,strong)OAuth2* oauth;
@property (weak, nonatomic) IBOutlet UIView *adminButton;

-(instancetype) initWithOauth: (OAuth2*)oauth;

@end
