//
//  AppDelegate.m
//  SFHS News
//
//  Created by Harish Kamath on 12/20/14.
//  Copyright (c) 2014 Harish Kamath. All rights reserved.
//

#import "AppDelegate.h"
#import "EventInfo.h"
#import "EventDatabase.h"
#import "SQLDatabase.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

//Methods begin to be called here. The -(void)viewDidLoad method is always called in any class which is a subclass of a ViewController; it is usually when initial setup is done.

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //NSLog's are useful tools used to debug; the bottom screen(if you do not see this screen, go to View->Debug Area-> Show Debug Area. This area will automatically pop up upon execution of the app, and is only used for debugging and shows only to the programmer.
    //This method simply first calls the database class to give it a "head start" on table creation.
    
    NSLog(@"App Has Launched!");
    [SQLDatabase database];
    
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//Marks the end of the class.
@end
