//
//  DealViewController.h
//  MyYunaitDeals
//
//  Created by Francisco Sevillano on 30/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import "Deal.h"
#import "DealsHandler.h"

@interface DealViewController : UIViewController<DealsHandlerDelegate>

@property(nonatomic,retain)IBOutlet UIView *loadingView;
@property(nonatomic,retain)IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain)Deal *deal;
@property(nonatomic,retain)IBOutlet AsyncImageView *imageView;
@property(nonatomic,retain)IBOutlet UILabel *title;
@property(nonatomic,retain)IBOutlet UIButton *createEvent;
@property(nonatomic,retain)IBOutlet UIWebView *description;

- (IBAction)createEventPressed:(id)sender;

@end
