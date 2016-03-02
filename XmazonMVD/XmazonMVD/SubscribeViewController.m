//
//  SubscribeView.m
//  XmazonMVD
//
//  Created by Wayne Kyle on 01/03/2016.
//  Copyright © 2016 Pinson Celine. All rights reserved.
//

#import "SubscribeViewController.h"

@interface SubscribeViewController ()

@end

@implementation SubscribeViewController
@synthesize auth = auth_;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(instancetype) initWithOauth: (OAuth2*)oauth
{
    if(self = [super init])
    {
        self.auth = oauth;
    }
    
    return self;
}
- (IBAction)registerClick:(id)sender {
    [self.auth createUserWithEmail:self.usernameText.text andPassword:self.passwordText.text];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
