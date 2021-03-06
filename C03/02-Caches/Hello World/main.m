/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 5.x Edition
 BSD License, Use at your own risk
 */

#import <UIKit/UIKit.h>
#import "ObjectCache.h"

#define COOKBOOK_PURPLE_COLOR	[UIColor colorWithRed:0.20392f green:0.19607f blue:0.61176f alpha:1.0f]
#define BARBUTTON(TITLE, SELECTOR) 	[[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR]
#define NUMSTR(X) [NSString stringWithFormat:@"Allocations: %d", X]

@interface TestBedViewController : UIViewController
{
	ObjectCache *objectCache;
    int nTimes;
}
@end

@implementation TestBedViewController

- (void)didReceiveMemoryWarning
{
    NSLog(@"Memory warning!");
	[objectCache respondToMemoryWarning];
    self.title = NUMSTR((nTimes = 0));
}

- (void) loadObject
{
	// 若日期時間不同，會建立新物件物件、並載入。
	// 若你在同一秒內很快地按兩下，因為兩次的日期時間相同，
	// 所以第二次不會建立新物件。
	[objectCache retrieveObjectNamed:[[NSDate date] description]];
    self.title = NUMSTR(++nTimes);
}

- (void) viewDidLoad
{
	objectCache = [ObjectCache cache];
    self.view.backgroundColor = [UIColor whiteColor];
	self.navigationController.navigationBar.tintColor = COOKBOOK_PURPLE_COLOR;
	self.navigationItem.rightBarButtonItem = BARBUTTON(@"Consume", @selector(loadObject));
}
@end

#pragma mark -

#pragma mark Application Setup
@interface TestBedAppDelegate : NSObject <UIApplicationDelegate>
{
    UIWindow *window;
}
@end
@implementation TestBedAppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{	
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[TestBedViewController alloc] init]];
    window.rootViewController = nav;
	[window makeKeyAndVisible];
    return YES;
}
@end
int main(int argc, char *argv[]) {
    @autoreleasepool {
        int retVal = UIApplicationMain(argc, argv, nil, @"TestBedAppDelegate");
        return retVal;
    }
}