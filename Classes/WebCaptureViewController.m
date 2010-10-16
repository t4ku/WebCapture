//
//  WebCaptureViewController.m
//  WebCapture
//
//  Created by Taku Okawa on 10/07/31.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "WebCaptureViewController.h"
#import "PreviewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation WebCaptureViewController
@synthesize webView;
@synthesize fldUrl;

#define SCREEN_HEIGHT 356

#pragma mark -
#pragma mark UITextField Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
	[textField resignFirstResponder];
	[webView loadRequest:[[[NSURLRequest alloc]
						   initWithURL:[NSURL URLWithString:textField.text]]autorelease]];
}


#pragma mark -
#pragma mark UIWebView Delegate

-(void)webViewDidFinishLoad:(UIWebView *)webView{
	[self loadWebcapture];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
	UIAlertView *alert = [[UIAlertView alloc]
						  initWithTitle:@"エラー"
						  message:@"画面を取得できません。"
						  delegate:nil
						  cancelButtonTitle:@"OK"
						  otherButtonTitles:nil];
	[alert show];
	[alert release];
}

#pragma mark -
#pragma mark UIViewController Delegate

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[webView loadRequest:[NSURLRequest
						  requestWithURL:[NSURL URLWithString:@"http://southafrica2010.yahoo.co.jp/iphone/"]]];
	
	NSLog(@"%@",webcapJsString);
	
}

#pragma mark -
#pragma mark msc function

-(void)loadWebcapture{
	NSString *path = [[NSBundle mainBundle]pathForResource:@"webcapture" ofType:@"js"];
	webcapJsString = [NSString stringWithContentsOfFile:path
											   encoding:NSUTF8StringEncoding
												  error:NULL];
	[self jsLoadModule];
	
}

/*
#pragma mark -
#pragma mark UIResponder Delegate

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
	if (event.type == UIEventSubtypeMotionShake) {
		NSLog(@"shaked");
	}
}

*/

#pragma mark -
#pragma mark IBAction

-(IBAction)handleBtnPreview{
	PreviewController *prevVc = [[PreviewController alloc] initWithNibName:nil bundle:nil];
	
	prevVc.images = [self getAllImages];
	// getAllImagesでdupPixelが取得される
	prevVc.totalHeight = [self jsPageHeight];
	prevVc.dupPixel = dupPixel;
	
	[self.navigationController pushViewController:prevVc animated:YES];
	//[self.view addSubview:prevVc.view];
	[prevVc release];
	
}

#pragma mark -
#pragma mark Js funcion

-(void)jsLoadModule{
	[webView stringByEvaluatingJavaScriptFromString:webcapJsString];
}

-(int)jsScrollToPage:(int)pageNum{
	NSString *rtn = [webView
					 stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"webcap.scrollToPage(%d);",pageNum]];
	return [rtn intValue];
}

-(int)jsPageHeight{
	NSString *rtn = [webView stringByEvaluatingJavaScriptFromString:@"webcap.pageHeight();"];
	NSLog(@"webpage total height %d",[rtn intValue]);
	return [rtn intValue];
}

#pragma mark -
#pragma mark image manipulation

-(NSArray*)getAllImages{
	NSString *strTotalPage = [webView stringByEvaluatingJavaScriptFromString:@"webcap.totalPages();"];
	NSLog(strTotalPage);
	
	NSArray *images = [NSArray array];
	
	int totalPage = [strTotalPage intValue];
	dupPixel = 0;
	
	for (int i=1; i <= totalPage; i++) {
		UIImage *image;
		int rtn = [self jsScrollToPage:i];
		// 最後のページでマイナスの値が来た場合
		// 汚いけどインスタンス変数に入れておく
		if (rtn != 0) {
			dupPixel = rtn;
			
			// ToDo: サイズ指定で画像を取得
			image = [self getImage];
		}else {
			image = [self getImage];
		}

		images = [images arrayByAddingObject:image];
	}
	return images;
}


-(UIImage*)getImage{
	UIGraphicsBeginImageContext(webView.bounds.size);
	[webView.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return viewImage;
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	[webView release];
	[fldUrl release];
}

@end
