//
//  ThirdViewController.h
//  MyYunaitDeals
//
//  Created by Francisco Sevillano on 30/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdViewController : UIViewController {
  UIButton *button_;
} 

@property(nonatomic,retain)IBOutlet UIButton *button;

- (IBAction)logOut:(id)sender;

@end
