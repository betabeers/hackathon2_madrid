//
//  DealsHandler.h
//  MyYunaitDeals
//
//  Created by Francisco Sevillano on 30/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpConnection.h"
@protocol DealsHandlerDelegate

- (void)dealsReceived:(NSArray*)deals;
- (void)eventCreated;

@end

@interface DealsHandler : NSObject<HttpConnectionDelegate> {

}

@property(nonatomic,retain) HttpConnection *connection;
@property(nonatomic,assign)id<DealsHandlerDelegate>delegate;

- (void)getNearbyDeals;
- (void)getMyDeals;
- (void)createEventWithName:(NSString*)name 
                      ident:(NSString*)ident
                   location:(NSString*)location 
                       date:(NSDate*)date;

@end
