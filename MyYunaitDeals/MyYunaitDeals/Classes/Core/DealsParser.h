//
//  DealsParser.h
//  MyYunaitDeals
//
//  Created by Francisco Sevillano on 30/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DealsParser : NSObject


@property(nonatomic,retain)NSJSONSerialization *serialization;


- (NSArray*)dealsForData:(NSData*)data;

@end
