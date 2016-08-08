//
//  Created by Dariusz Rybicki on 04/08/16.
//  Copyright © 2016 Darrarski. All rights reserved.
//

#import "AppDelegate.h"
#import "ExamplesListViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[ExamplesListViewController alloc] init]];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
