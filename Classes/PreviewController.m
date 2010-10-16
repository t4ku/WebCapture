    //
//  PreviewController.m
//  WebCapture
//
//  Created by Taku Okawa on 10/07/31.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PreviewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation PreviewController
@synthesize images;
@synthesize totalHeight;
@synthesize dupPixel;
@synthesize imageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	NSLog(@"initWithNibName");
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}

- (void)loadView {
	NSLog(@"loadView");
	self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	self.view.backgroundColor = [UIColor blackColor];
	
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationController.navigationBar.hidden = NO;
	
    UIBarButtonItem *addButton = [[[UIBarButtonItem alloc]
								   initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
								   target:self
								   action:@selector(saveImageToPhotoLibrary)] autorelease];
    self.navigationItem.rightBarButtonItem = addButton;
	
	
	[self showImages];
}

#pragma mark -
#pragma image manipulations

-(void)showImages{
	
	UIGraphicsBeginImageContext(CGSizeMake(self.view.frame.size.width, totalHeight));
	int imageCount = [images count];
	CGSize lastSize;
	CGPoint lastPoint;
	BOOL firstImage = TRUE;
	
	for (int i =1; i <= imageCount; i++) {
		CGPoint drawPoint;
		UIImage *image;
		
		image = [images objectAtIndex:i-1];
		NSLog(@"image size width %f height %f",image.size.width,image.size.height);
		
		if (!firstImage) {
			// 二枚目以降のイメージ
			drawPoint = CGPointMake(lastPoint.x, lastPoint.y + lastSize.height);
			
			// 最後の写真の場合は重複分だけずらす
			if (i == imageCount) {
				drawPoint.y = drawPoint.y + dupPixel;
			}
			
		}else {
			// 最初のイメージ
			drawPoint = CGPointMake(0, 0);
			firstImage = FALSE;
		}

		
		[image drawAtPoint:drawPoint];
		lastSize = image.size;
		lastPoint = drawPoint;
	}
	
	UIImage *totalImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	UIScrollView *scrollView = [[[UIScrollView alloc]
								initWithFrame:CGRectMake(0, 0, 320, 416)] autorelease];
	scrollView.contentSize = CGSizeMake(320, totalHeight);
	
	if (imageView) [imageView release];
	imageView = nil;
	imageView = [[UIImageView alloc]
					initWithImage:totalImage];
	[imageView retain];
	
	[scrollView addSubview:imageView];
	[self.view addSubview:scrollView];
	
}

-(void)saveImageToPhotoLibrary{
	UIImageWriteToSavedPhotosAlbum(imageView.image, nil, nil, nil);
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
	NSLog(@"viewDidUnload called");
	
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	[imageView release];
	images = nil;
}


@end
