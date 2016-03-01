//
//  BaseMainViewController.m
//  XmazonMVD
//
//  Created by Wayne Kyle on 01/03/2016.
//  Copyright © 2016 Pinson Celine. All rights reserved.
//

#import "BaseMainViewController.h"

@interface BaseMainViewController ()

@end


@implementation BaseMainViewController
@synthesize oauth = oauth_;
@synthesize adminButton = admiButton;

-(instancetype) initWithOauth: (OAuth2*)oauth
{
    if(self = [super init])
    {
        self.oauth = oauth;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
