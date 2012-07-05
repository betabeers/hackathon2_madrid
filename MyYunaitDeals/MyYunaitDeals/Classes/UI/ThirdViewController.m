//
//  ThirdViewController.m
//  MyYunaitDeals
//
//  Created by Francisco Sevillano on 30/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "ThirdViewController.h"

@interface ThirdViewController ()

- (void)facebookDidLogout;
- (void)facebookDidLogin;

@end

@implementation ThirdViewController

@synthesize button = button_;

- (void)dealloc {
  [button_ release];
  
  [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      self.title = NSLocalizedString(@"Settings", @"Ofertas");
      self.tabBarItem.image = [UIImage imageNamed:@"settings"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  [[NSNotificationCenter defaultCenter]addObserver:self 
                                          selector:@selector(facebookDidLogout) 
                                              name:FACEBOOK_DID_LOGOUT object:nil];
  
  [[NSNotificationCenter defaultCenter]addObserver:self 
                                          selector:@selector(facebookDidLogin) 
                                              name:FACEBOOK_DID_LOGIN object:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)logOut:(id)sender { 
  AppDelegate *appDelegate  = (AppDelegate*)[UIApplication sharedApplication].delegate;
  [appDelegate.facebook logout];
}

- (void)facebookDidLogout {
  [self.button setTitle:@"Log in" forState:UIControlStateNormal];
}

- (void)facebookDidLogin{
  [self.button setTitle:@"Log out" forState:UIControlStateNormal];
}
@end
