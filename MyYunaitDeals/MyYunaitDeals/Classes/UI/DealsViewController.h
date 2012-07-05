//
//  DealsViewController.h
//  MyYunaitDeals
//
//  Created by Francisco Sevillano on 30/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DealsHandler.h"

@interface DealsViewController : UIViewController
<DealsHandlerDelegate, UITableViewDelegate,
UITableViewDataSource> {
  
}

@property(nonatomic,retain)IBOutlet UITableView *tableView;
@property(nonatomic,retain)IBOutlet UIView *loadingView;
@property(nonatomic,retain) DealsHandler *dealsHandler;
@property(nonatomic,retain) NSArray *deals;

@end
