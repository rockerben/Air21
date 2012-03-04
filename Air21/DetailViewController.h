//
//  DetailViewController.h
//
//  Air21 Mobile
//
//  Created by Ben Cortez on 12/05/11.
//  Copyright 2011 RedMedia. All rights reserved.
//


@interface DetailViewController : UIViewController<UIWebViewDelegate>
{
    IBOutlet UIWebView * webView;
    IBOutlet UIButton * closeButton;
    
}

@property (nonatomic, retain) IBOutlet UIWebView * webView;
@property (nonatomic, retain) IBOutlet UIButton *closeButton;

- (IBAction) btnClose:(id)sender;

@end
