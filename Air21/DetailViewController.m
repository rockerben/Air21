//
//  DetailViewController.m
//
//  Air21 Mobile
//
//  Created by Ben Cortez on 12/05/11.
//  Copyright 2011 RedMedia. All rights reserved.
//



#import "DetailViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "MBProgressHUD.h"
#import "SecondViewController.h"


@implementation DetailViewController
@synthesize webView, closeButton;


- (void)viewDidLoad
{
    [super viewDidLoad];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading Results...";
    self.title = @"Air21 Mobile";
    [webView loadHTMLString:[SecondViewController response] baseURL:[NSURL URLWithString:@"http://www.af2100.com/tracking/"]];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];

}

- (IBAction) btnClose:(id)sender;
{
    [self dismissModalViewControllerAnimated:YES];
    
}



@end