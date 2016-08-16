//
//  AppDelegate.m
//
//  Air21 Mobile
//
//  Created by Ben Cortez on 12/05/11.
//  Copyright 2011 RedMedia. All rights reserved.
//



#import "AppDelegate.h"
#import "SecondViewController.h"
#import "DetailViewController.h"
#import "AboutViewController.h"
#import "LocTblViewController.h"
//#import "RateViewController.h"

#import "RateCalculatorViewController.h"




@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    UIWindow *window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    [window autorelease];
    [self setWindow: window];
    
    
    // Override point for customization after application launch.
    SecondViewController *viewController2 = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil] ;
   
    
    UITabBarItem *trackItem =  [[UITabBarItem alloc]  initWithTitle:@"Track" image:[UIImage imageNamed:@"tracking@2x.png"] tag:100] ;
    [trackItem autorelease];
    [viewController2 setTabBarItem: trackItem  ];
    [viewController2 autorelease];
    
    

    AboutViewController  *vc3 = [[[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil] autorelease];
    
    
    UITabBarItem *infoItem =  [[UITabBarItem alloc] initWithTitle:@"Info" image:[UIImage imageNamed:@"info@2x.png"] tag:102];
    [infoItem autorelease];
    [vc3 setTabBarItem: infoItem];
   
    
    
    LocTblViewController  *tblVc = [[LocTblViewController alloc] initWithNibName:@"LocTblViewController" bundle:nil];
    [tblVc autorelease];
    
    UINavigationController *navVC1 = [[UINavigationController alloc] initWithRootViewController:tblVc];
    [navVC1 autorelease];
    navVC1.navigationBar.tintColor = [UIColor blackColor];
    
    UITabBarItem *locatorItem = [[UITabBarItem alloc] initWithTitle:@"Locator" image:[UIImage imageNamed:@"location@2x.png"] tag:103];
    [locatorItem autorelease];

    [tblVc setTabBarItem: locatorItem];
    
    
    RateCalculatorViewController *rateVc =  [[RateCalculatorViewController alloc] initWithNibName:@"RateCalculatorView" bundle:nil];
    [rateVc autorelease];
    
    
    UITabBarItem *ratesItem = [[UITabBarItem alloc] initWithTitle:@"Rates" image:[UIImage imageNamed:@"calculator@2x.png"] tag:104];
    [ratesItem autorelease];
    [rateVc setTabBarItem: ratesItem];
    
    //RateViewController *rateVc = [[RateViewController  alloc] initWithNibName:@"RateViewController" bundle:nil];
    
    
     
    
    UITabBarController *tabController = [[UITabBarController alloc] init]; 
    [tabController autorelease];
    [tabController setViewControllers:[NSArray arrayWithObjects: viewController2, rateVc, navVC1, vc3, nil]];
    
    
    self.window.rootViewController = tabController;
   [self.window makeKeyAndVisible];
    
    
    
   
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

-(void) dealloc {
    
     
    [super dealloc];
}

@end
