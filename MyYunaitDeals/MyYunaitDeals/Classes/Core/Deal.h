//
//  Deal.h
//  MyYunaitDeals
//
//  Created by Francisco Sevillano on 30/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Deal : NSObject {

}

@property(nonatomic,retain) NSString *imageURL;
@property(nonatomic,retain) NSString *title;
@property(nonatomic,copy)   NSString *description;
@property(nonatomic,retain) NSString *price;
@property(nonatomic,retain) NSString *daysLeft;
@property(nonatomic,retain) NSString *ident;


@end
