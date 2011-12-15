//
//  DetailViewController.m
//
//  Air21 Mobile
//
//  Created by Ben Cortez on 7/1/11.
//  Copyright 2011 RedMedia. All rights reserved.
//


#import "DetailViewController.h"

@implementation DetailViewController
@synthesize webView;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Shipment Tracking";
    
    [webView setBackgroundColor:[UIColor purpleColor]];
        
    //[webView loadHTMLString:@"This is a completely transparent UIWebView. Notice the missing gradient at the top and bottom as you scroll up and down." baseURL:nil];
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.af2100.com/tracking/mindex.jsp"]]];
}


@end