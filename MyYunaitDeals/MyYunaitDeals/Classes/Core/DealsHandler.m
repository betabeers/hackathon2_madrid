//
//  DealsHandler.m
//  MyYunaitDeals
//
//  Created by Francisco Sevillano on 30/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "Deal.h"
#import "DealsHandler.h"
#import "DealsParser.h"

#define SERVER_URL @"46.137.100.85"

#define NEARBY_DEALS_TAG 0
#define MY_DEALS_TAG 1
#define CREATE_EVENT_TAG  2

@implementation DealsHandler

@synthesize connection;
@synthesize delegate;

- (void)getNearbyDeals {
  
  self.connection = [[[HttpConnection alloc]initWithDelegate:self]autorelease];
  self.connection.tag = NEARBY_DEALS_TAG;
  NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@"40.0",@"lat",@"-3.2",@"long", nil];
  NSString *url = [NSString stringWithFormat:@"http://%@/%@",SERVER_URL,@"yunait/deals"];
  NSLog(@"%@",url);
  
  AppDelegate *appDelegate  = (AppDelegate*)[UIApplication sharedApplication].delegate;
  NSString *facebookAuth = [NSString stringWithFormat:@"%@ %@",@"Bearer",appDelegate.facebook.accessToken];
  
  NSDictionary *headers = 
  [NSDictionary dictionaryWithObjectsAndKeys:facebookAuth,HTTP_AUTHORIZATION_HEADER, nil];

 [self.connection requestUrl:url params:parameters method:Get content:nil headers:headers];  
  
} 

- (void)getMyDeals {
}

- (void)createEventWithName:(NSString*)name 
                      ident:(NSString*)ident
                   location:(NSString*)location 
                       date:(NSDate*)date {
  
  self.connection = [[[HttpConnection alloc]initWithDelegate:self]autorelease];
  self.connection.tag = CREATE_EVENT_TAG;
  NSString *url = [NSString stringWithFormat:@"http://%@/%@",SERVER_URL,@"event"];
  NSLog(@"%@",url);
  
  AppDelegate *appDelegate  = (AppDelegate*)[UIApplication sharedApplication].delegate;
  NSString *facebookAuth = [NSString stringWithFormat:@"%@ %@",@"Bearer",appDelegate.facebook.accessToken];
  
  NSDictionary *headers = 
  [NSDictionary dictionaryWithObjectsAndKeys:facebookAuth,HTTP_AUTHORIZATION_HEADER, nil];
  
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
	[dateFormatter setDateFormat:@"YYYY-MM-dd"];
  
  NSString *dateString = [dateFormatter stringFromDate:date];
  
  NSString *eventIDParameter = [NSString stringWithFormat:@"%@=%@",@"yunait_deal_id",ident];
  NSMutableString *nameParameter = [NSMutableString stringWithFormat:@"%@=%@",@"name",name];
  
  nameParameter = [NSMutableString stringWithString:[nameParameter substringToIndex:50]];
  [nameParameter appendString:@"..."];
  
  NSString *locationParameter = [NSString stringWithFormat:@"%@=%@",@"location",location];
  NSString *eventDateParameter = [NSString stringWithFormat:@"%@=%@",@"event_date",dateString];
  
  NSString *body = [NSString stringWithFormat:@"%@&%@&%@&%@",eventIDParameter,nameParameter,locationParameter,eventDateParameter];
  
  NSLog(@"%@",body);
  
  [self.connection requestUrl:url params:nil method:Post content:body headers:headers];
  
}


- (void)connection:(HttpConnection*)incomingConnection 
   requestFinished:(NSData *) result 
      withEncoding:(NSStringEncoding) encoding {
#if DEBUG
	NSString *dataReceived = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
	NSLog(@"%@", dataReceived);
	[dataReceived release];
#endif
  
  if (incomingConnection.tag == CREATE_EVENT_TAG) {
    [self.delegate eventCreated];
  }
  else if (incomingConnection.tag == NEARBY_DEALS_TAG) {
    
    DealsParser *parser = [[DealsParser alloc]init];
    NSArray *deals = [parser dealsForData:result];
    [self.delegate dealsReceived:deals];
  }
}

- (void)connection:(HttpConnection*)connection
     requestFailed:(Result) error { 
  
} 

@end
