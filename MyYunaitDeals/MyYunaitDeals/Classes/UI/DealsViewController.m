//
//  DealsViewController.m
//  MyYunaitDeals
//
//  Created by Francisco Sevillano on 30/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "AsyncImageView.h"
#import "Deal.h"
#import "DealViewController.h"
#import "DealsViewController.h"
#import "DealViewCell.h"

@interface DealsViewController ()

- (void)facebookDidLogin;

@end

@implementation DealsViewController

@synthesize tableView;
@synthesize loadingView;
@synthesize dealsHandler;
@synthesize deals;

- (void)dealloc{
  [tableView release];
  [loadingView release];
  
  [super dealloc];
} 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      self.dealsHandler = [[DealsHandler alloc]init];
      self.dealsHandler.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  [[NSNotificationCenter defaultCenter]addObserver:self 
                                          selector:@selector(facebookDidLogin) 
                                              name:FACEBOOK_DID_LOGIN object:nil];
  self.loadingView.hidden = NO;
  [self.dealsHandler getNearbyDeals];
  self.navigationItem.title = @"Ofertas";
}

- (void)viewDidAppear:(BOOL)animated {
  
  [super viewDidAppear:YES];
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

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cellID = @"DealViewCell";    
  DealViewCell *cell = (DealViewCell*) [self.tableView dequeueReusableCellWithIdentifier:cellID];
  
  if (cell == nil) 
  {			
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DealViewCell" owner:self options:nil];
    
    for (id oneObject in nib) 
      if ([oneObject isKindOfClass:[DealViewCell class]])
        cell = (DealViewCell*)oneObject;
  }
  
  Deal *deal = [self.deals objectAtIndex:indexPath.row];
  cell.title.text = deal.title;
  cell.daysLeft.text = [NSString stringWithFormat:@"Finaliza en %@ días",deal.daysLeft];
  cell.imageView.imageURL = [NSURL URLWithString:deal.imageURL];
  
  return cell;
  
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section {
  return [self.deals count];
}

- (void)dealsReceived:(NSArray*)newDeals {
  self.deals = newDeals;
  self.loadingView.hidden = YES;
  [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 70.0f;
}

- (void)tableView:(UITableView *)tableView 
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {  
  DealViewController *dealViewController = [[DealViewController alloc]init];
  dealViewController.deal = [self.deals objectAtIndex:indexPath.row];
  [self.navigationController pushViewController:dealViewController animated:YES];
  
}

- (void)facebookDidLogin {
  self.loadingView.hidden = NO;
  [self.dealsHandler getNearbyDeals];
}

@end

