//
//  PreviewController.h
//  WebCapture
//
//  Created by Taku Okawa on 10/07/31.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PreviewController : UIViewController {
	NSArray *images;
	UIImageView *imageView;
	int totalHeight;
	int dupPixel;
}
@property(nonatomic,assign)NSArray *images;
@property(nonatomic)int totalHeight;
@property(nonatomic)int dupPixel;
@property(nonatomic,retain)UIImageView *imageView;
@end
