//
//  AppDelegate.m
//  MyYunaitDeals
//
//  Created by Francisco Sevillano on 30/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "FirstNavigationViewController.h"

#import "SecondNavigationViewController.h"
#import "ThirdViewController.h"


@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
@synthesize facebook = facebook_;

- (void)dealloc
{
  [_window release];
  [_tabBarController release];
  [facebook_ release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
  UIViewController *viewController1 = [[[FirstNavigationViewController alloc] init] autorelease];
  //((UITabBarItem*)[self.tabBarController.tabBar.items objectAtIndex:0]).title = @"Ofertas";
  
  UIViewController *viewController2 = [[[SecondNavigationViewController alloc] init] autorelease];
  UIViewController *viewController3 = [[[ThirdViewController alloc] init]autorelease];
  
  self.facebook = [[Facebook alloc] initWithAppId:@"355320307872527" andDelegate:self];
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  if ([defaults objectForKey:@"FBAccessTokenKey"] 
      && [defaults objectForKey:@"FBExpirationDateKey"]) {
    self.facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
    self.facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
  }
  self.tabBarController = [[[UITabBarController alloc] init] autorelease];
  self.tabBarController.viewControllers = 
  [NSArray arrayWithObjects:viewController1, viewController2,viewController3, nil];
  
  self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// For iOS 4.2+ support
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
  return [self.facebook handleOpenURL:url]; 
}

#pragma mark -
#pragma mark Facebook methods

- (void)fbDidLogin {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setObject:[self.facebook accessToken] forKey:@"FBAccessTokenKey"];
  [defaults setObject:[self.facebook expirationDate] forKey:@"FBExpirationDateKey"];
  [defaults synchronize];
  
  [[NSNotificationCenter defaultCenter] postNotificationName:FACEBOOK_DID_LOGIN object:nil];
  
}

- (void) fbDidLogout {
  // Remove saved authorization information if it exists
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  if ([defaults objectForKey:@"FBAccessTokenKey"]) {
    [defaults removeObjectForKey:@"FBAccessTokenKey"];
    [defaults removeObjectForKey:@"FBExpirationDateKey"];
    [defaults synchronize];
  }
  
  [[NSNotificationCenter defaultCenter] postNotificationName:FACEBOOK_DID_LOGOUT object:nil];
}

@end
