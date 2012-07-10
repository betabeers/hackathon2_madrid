//
//  AppDelegate.h
//  MyYunaitDeals
//
//  Created by Francisco Sevillano on 30/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

#define FACEBOOK_DID_LOGIN @"facebookDidLogin"
#define FACEBOOK_DID_LOGOUT @"facebookDidLogout"

@interface AppDelegate : UIResponder
<UIApplicationDelegate,
FBSessionDelegate, 
UITabBarControllerDelegate> {
  Facebook *facebook_;
}

@property (retain, nonatomic) UIWindow *window;

@property (retain, nonatomic) UITabBarController *tabBarController;
@property (retain, nonatomic) Facebook *facebook;

- (void)loginWithFacebook;

@end
