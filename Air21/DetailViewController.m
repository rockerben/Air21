//
//  DetailViewController.m
//
//  Air21 Mobile
//
//  Created by Ben Cortez on 7/1/11.
//  Copyright 2011 RedMedia. All rights reserved.
//


#import "DetailViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "MBProgressHUD.h"
#import "SecondViewController.h"
#import "AboutViewController.h"

@implementation DetailViewController
@synthesize webView, closeButton, about;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.labelText = @"Loading Results...";

    self.title = @"Shipment Tracking";
    
    [webView loadHTMLString:[SecondViewController response] baseURL:[NSURL URLWithString:@"http://www.af2100.com/mobile/"]];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];

}

- (IBAction) btnClose:(id)sender;
{
    [self dismissModalViewControllerAnimated:YES];
    
}

- (IBAction) btnAbout:(id)sender;
{
    AboutViewController* vc = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
       
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentModalViewController:vc animated:YES];
    
}


@end