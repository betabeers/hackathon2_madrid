//
//  FirstNavigationViewController.m
//  MyYunaitDeals
//
//  Created by Francisco Sevillano on 30/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "FacebookLogin.h"
#import "FirstNavigationViewController.h"
#import "DealsViewController.h"

@interface FirstNavigationViewController ()

-(void)facebookDidLogin;

@end

@implementation FirstNavigationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      self.title = NSLocalizedString(@"Ofertas", @"Ofertas");
      //self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [super viewDidLoad];
  [[NSNotificationCenter defaultCenter]addObserver:self 
                                          selector:@selector(facebookDidLogin) 
                                              name:FACEBOOK_DID_LOGIN object:nil];

  
  AppDelegate *appDelegate  = (AppDelegate*)[UIApplication sharedApplication].delegate;
  if ([appDelegate.facebook isSessionValid]) {
    DealsViewController *dealsViewController = [[DealsViewController alloc]init];
    [self pushViewController:dealsViewController animated:NO];
  }
    
}

- (void)viewDidAppear:(BOOL)animated {
  AppDelegate *appDelegate  = (AppDelegate*)[UIApplication sharedApplication].delegate;
  if (![appDelegate.facebook isSessionValid]) {
    FacebookLogin *facebookLogin = [[FacebookLogin alloc]init];
    [self presentViewController:facebookLogin animated:YES completion:nil];
  }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)facebookDidLogin {
  DealsViewController *dealsViewController = [[DealsViewController alloc]init];
  [self pushViewController:dealsViewController animated:NO];
}

@end
