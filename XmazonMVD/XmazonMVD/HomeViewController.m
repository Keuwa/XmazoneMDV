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
#import "BaseMainViewController.h"
#import "CategoryViewController.h"


@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize model = model_;
@synthesize auth = auth_;

-(void)viewDidAppear:(BOOL)animated{
    [NSThread sleepForTimeInterval:3.0f];
    [tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Home";
    
    self.navigationController.navigationBar.translucent = YES;
    
    ///chargement des tokens

    ///[app_token setObject:@"azeazaeaze"forKey:@"access_token"];
    self.model = [[HomeModel alloc]initWithOauth:self.auth];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.model listMagasin] count];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog( @"%@", [[[self.model listMagasin]objectAtIndex: indexPath.row] objectForKey:@"uid"]);
    
    NSMutableArray * test =
    [self.auth getCategoryList: [[[self.model listMagasin]objectAtIndex: indexPath.row] objectForKey:@"uid"]];
    
    if( test != nil )
    {
        CategoryViewController* home = [[CategoryViewController alloc]initWithOauth:self.auth andCategoryUid:test];
        [self.navigationController pushViewController:home animated:YES];
    }
    
    
}

static NSString* const kCellReuseIdentifier = @"CoolId";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier];
    if(!cell)
    {
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
