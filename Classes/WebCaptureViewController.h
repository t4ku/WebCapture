//
//  WebCaptureViewController.h
//  WebCapture
//
//  Created by Taku Okawa on 10/07/31.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebCaptureViewController : UIViewController<UITextFieldDelegate,UIWebViewDelegate> {
	UITextField *fldUrl;
	UIWebView *webView;
	NSString *webcapJsString;
	int dupPixel;
}
@property(nonatomic,retain)IBOutlet UIWebView *webView;
@property(nonatomic,retain)IBOutlet UIBarButtonItem *btnCapture;
@property(nonatomic,retain)IBOutlet UIBarButtonItem *btnPreview;
@property(nonatomic,retain)IBOutlet UITextField *fldUrl;
-(IBAction)handleBtnPreview;

@end

