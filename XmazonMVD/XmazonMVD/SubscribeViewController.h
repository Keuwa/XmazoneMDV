//
//  SubscribeView.h
//  XmazonMVD
//
//  Created by Wayne Kyle on 01/03/2016.
//  Copyright © 2016 Pinson Celine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OAuth2.h"

@interface SubscribeViewController : UIViewController
{
    @private
    OAuth2 * auth_;
}
@property (weak, nonatomic) IBOutlet UITextField *usernameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
-(instancetype) initWithOauth: (OAuth2*)oauth;
@property (nonatomic,strong)OAuth2* auth;
@end
