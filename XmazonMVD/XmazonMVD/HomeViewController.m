//
//  HomeViewController.m
//  XmazonMVD
//
//  Created by Pinson Celine on 15/02/2016.
//  Copyright (c) 2016 Pinson Celine. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeModel.h"
#import "OAuth2.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize model = model_;

-(void)viewDidAppear:(BOOL)animated{
    [NSThread sleepForTimeInterval:3.0f];
    [tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Home";
    
    self.navigationController.navigationBar.translucent = YES;
    
    ///chargement des tokens
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary* app_token = [[NSMutableDictionary alloc]initWithDictionary:[userDefaults objectForKey:@"application"]];
    NSMutableDictionary* user_token = [[NSMutableDictionary alloc]initWithDictionary:[userDefaults objectForKey:@"user"]];
    
    ///[app_token setObject:@"azeazaeaze"forKey:@"access_token"];
    OAuth2* auth = [[OAuth2 alloc]initWithDictionaryUser:user_token andDictionaryApp:app_token];
    self.model = [[HomeModel alloc]initWithOauth:auth];
    // Do any additional setup after loading the view from its nib.
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.model listMagasin] count];
}

static NSString* const kCellReuseIdentifier = @"CoolId";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCellReuseIdentifier];
    }
    cell.textLabel.text = [[[self.model listMagasin]objectAtIndex:indexPath.row] objectForKey:@"name"];
    return cell;
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
