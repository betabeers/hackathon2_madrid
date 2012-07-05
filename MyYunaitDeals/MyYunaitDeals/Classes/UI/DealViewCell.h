//
//  DealViewCell.h
//  MyYunaitDeals
//
//  Created by Francisco Sevillano on 30/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface DealViewCell : UITableViewCell {
  
}

@property(nonatomic,retain) IBOutlet AsyncImageView *imageView;
@property(nonatomic,retain) IBOutlet UILabel *title;
@property(nonatomic,retain) IBOutlet UILabel *daysLeft;


@end
