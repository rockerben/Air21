//
//  AboutViewController.m
//
//  Air21 Mobile
//
//  Created by Ben Cortez on 12/05/11.
//  Copyright 2011 RedMedia. All rights reserved.
//


#import "AboutViewController.h"

@implementation AboutViewController
@synthesize goBack, goURL;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction) btnGoBack:(id)sender;
{
    
    [self dismissModalViewControllerAnimated:YES];
    
}

- (IBAction) btnGoUrl:(id)sender;
{
    NSURL *url = [NSURL URLWithString: @"http://redmediacrm.com"];
    [[UIApplication sharedApplication] openURL: url];
    
}


@end
