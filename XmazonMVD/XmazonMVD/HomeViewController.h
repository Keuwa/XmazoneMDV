//
//  HomeViewController.h
//  XmazonMVD
//
//  Created by Pinson Celine on 15/02/2016.
//  Copyright (c) 2016 Pinson Celine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
@interface HomeViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet UITableView *tableView;
    HomeModel* model_;
}
@property (strong,nonatomic)HomeModel* model;

@end
