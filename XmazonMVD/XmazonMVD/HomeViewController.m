//
//  HomeViewController.m
//  XmazonMVD
//
//  Created by Pinson Celine on 15/02/2016.
//  Copyright (c) 2016 Pinson Celine. All rights reserved.
//

#import "HomeViewController.h"
#import "OAuth2.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Home";
    OAuth2* auth = [[OAuth2 alloc]initWithDictionaryUser:nil andDictionaryApp:nil];
    NSLog(@"%@",[auth.application objectForKey:@"access_token"]);
    
    
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
