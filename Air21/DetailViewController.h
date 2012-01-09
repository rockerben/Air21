//
//  DetailViewController.h
//
//  Air21 Mobile
//
//  Created by Ben Cortez on 7/1/11.
//  Copyright 2011 RedMedia. All rights reserved.
//

@interface DetailViewController : UIViewController<UIWebViewDelegate>
{
    IBOutlet UIWebView * webView;
    IBOutlet UIButton * closeButton;
    IBOutlet UIButton * about;
  
   
    
}

@property (nonatomic, retain) IBOutlet UIWebView * webView;
@property (nonatomic, retain) IBOutlet UIButton *closeButton;
@property (nonatomic, retain) IBOutlet UIButton *about;


- (IBAction) btnClose:(id)sender;
- (IBAction) btnAbout:(id)sender;
@end
