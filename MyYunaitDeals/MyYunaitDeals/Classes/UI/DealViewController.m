//
//  DealViewController.m
//  MyYunaitDeals
//
//  Created by Francisco Sevillano on 30/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Deal.h"
#import "DealViewController.h"


@interface DealViewController ()

@end

@implementation DealViewController

@synthesize loadingView;
@synthesize scrollView;
@synthesize deal;
@synthesize imageView;
@synthesize title;
@synthesize createEvent;
@synthesize description;

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
  self.navigationItem.title = deal.title;
  self.imageView.imageURL = [NSURL URLWithString:deal.imageURL];
  [self.description loadHTMLString:deal.description baseURL:nil];
  self.scrollView.contentSize = CGSizeMake(320, 600);
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

- (IBAction)createEventPressed:(id)sender {
  DealsHandler *dealsHandler = [[DealsHandler alloc]init];
  dealsHandler.delegate = self;
  
  [dealsHandler createEventWithName:self.deal.title 
                              ident:deal.ident
                           location:@"Madrid" date:[NSDate dateWithTimeInterval:1000000
                          sinceDate:[NSDate date]]];
  
  self.loadingView.hidden = NO;
}

- (void)eventCreated {
  [self.createEvent setTitle:@"¡Evento creado!" forState:UIControlStateNormal];
  self.loadingView.hidden = YES;
}
@end
