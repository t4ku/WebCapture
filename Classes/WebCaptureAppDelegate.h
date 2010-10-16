//
//  WebCaptureAppDelegate.h
//  WebCapture
//
//  Created by Taku Okawa on 10/07/31.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WebCaptureAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UINavigationController *navigationController;
}
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property(nonatomic,retain)IBOutlet UINavigationController *navigationController;

@end

