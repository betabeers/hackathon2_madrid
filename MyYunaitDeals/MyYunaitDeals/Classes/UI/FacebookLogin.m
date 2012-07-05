//
//  FacebookLogin.m
//  MyYunaitDeals
//
//  Created by Francisco Sevillano on 30/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "FacebookLogin.h"


@interface FacebookLogin ()

- (void)facebookDidLogin;

@end

@implementation FacebookLogin

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  
  [[NSNotificationCenter defaultCenter]addObserver:self 
                                          selector:@selector(facebookDidLogin)
                                              name:FACEBOOK_DID_LOGIN
                                          object:nil]; 
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

- (IBAction)login:(id)sender {
  AppDelegate *appDelegate  = (AppDelegate*)[UIApplication sharedApplication].delegate;
  [appDelegate.facebook authorize:[NSArray arrayWithObject:@"create_event"]];
}

- (void)facebookDidLogin {
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
