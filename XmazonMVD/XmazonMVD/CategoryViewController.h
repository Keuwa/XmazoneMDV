//
//  CategoryViewController.h
//  XmazonMVD
//
//  Created by Dylan on 02/03/16.
//  Copyright © 2016 Pinson Celine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OAuth2.h"

@interface CategoryViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
{
    __weak IBOutlet UITableView *tableView;
    NSMutableArray * category;
    OAuth2* auth;
}

-initWithOauth:(OAuth2*)auth andCategoryUid:(NSMutableArray*)category;

@end
