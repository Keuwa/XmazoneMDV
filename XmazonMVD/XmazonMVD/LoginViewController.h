//
//  LoginViewController.h
//  XmazonMVD
//
//  Created by Pinson Celine on 15/02/2016.
//  Copyright (c) 2016 Pinson Celine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OAuth2.h"

@interface LoginViewController : UIViewController
{
@private
    OAuth2 * auth_;
}
@property (weak, nonatomic) IBOutlet UITextField *loginText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;

@property (nonatomic,strong)OAuth2* auth;

@end
