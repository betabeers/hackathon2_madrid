//
//  DealsParser.m
//  MyYunaitDeals
//
//  Created by Francisco Sevillano on 30/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Deal.h"
#import "DealsParser.h"

@implementation DealsParser

@synthesize serialization;

- (NSArray*)dealsForData:(NSData*)data {
  
  NSError *error = nil;
  
  NSDictionary *dictionary = 
  [NSJSONSerialization JSONObjectWithData:data 
                                  options:NSJSONWritingPrettyPrinted 
                                    error:&error];
  
  NSArray *dealsJSONArray = [dictionary objectForKey:@"data"];
  
  NSMutableArray *dealsArray = [NSMutableArray array];
  for (NSDictionary *dealDict in dealsJSONArray) {
    Deal *deal = [[Deal alloc]init];
    deal.ident = [dealDict objectForKey:@"id"];
    deal.title = [dealDict objectForKey:@"title"];
    deal.imageURL = [dealDict objectForKey:@"image"];
    deal.description = [dealDict objectForKey:@"description"];
    deal.price = [dealDict objectForKey:@"price"];
    
    [dealsArray addObject:deal];
  }  
  
  return dealsArray;
}

@end
