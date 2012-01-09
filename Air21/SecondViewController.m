//
//  SecondViewController.m
//
//  Air21 Mobile
//
//  Created by Ben Cortez on 7/1/11.
//  Copyright 2011 RedMedia. All rights reserved.
//


#import "SecondViewController.h"
#import "DetailViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "MBProgressHUD.h"

static        NSString *staticRequest = nil;


@implementation SecondViewController
@synthesize code = ivCode, _textField = textField;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Second", @"Second");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}
							
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    //return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField*)_textField {
    [textField resignFirstResponder];
    return TRUE;

}

- (IBAction) btnMoveTo:(id)sender;
{
    // Start request
    [textField resignFirstResponder];

    NSURL *url = [NSURL URLWithString:@"http://www.af2100.com/tracking/mtrack.jsp"];

    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:textField.text forKey:@"a"];
    [request setPostValue:@"Airwaybill" forKey:@"radioTrackBy"];
    
    [request setDelegate:self];
    [request startAsynchronous];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading Results...";
    
}


+ (NSString*)response {
    return staticRequest;
}

- (void)requestFinished:(ASIHTTPRequest *)request
{    
    if (request.responseStatusCode == 400) {
        NSLog(@"Invalid code"); 
        } else if (request.responseStatusCode == 403) {
        NSLog(@"Code already used");
    } else if (request.responseStatusCode == 200) {
        staticRequest = [request responseString];
         NSLog(@"process Name: %@",staticRequest);
   
        DetailViewController *detailView = [[DetailViewController alloc] init];
        [self presentModalViewController:detailView animated:YES];
               
    }
        
    else {
        NSLog(@"Unexpected error");
    }
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    }

- (void)requestFailed:(ASIHTTPRequest *)request
{    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSLog(@"Need internet connection");
    UIAlertView *alert = [[UIAlertView alloc] init];
	[alert setTitle:@"No Internet Connection"];
	[alert setDelegate:self];
	[alert addButtonWithTitle:@"Ok"];
	[alert show];
}

@end
