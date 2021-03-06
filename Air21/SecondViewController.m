//
//  SecondViewController.m
//
//  Air21 Mobile
//
//  Created by Ben Cortez on 12/05/11.
//  Copyright 2011 RedMedia. All rights reserved.
//



#import "SecondViewController.h"
#import "DetailViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "MBProgressHUD.h"
#import "AboutViewController.h" 
#import <QuartzCore/QuartzCore.h>

static        NSString *staticRequest = nil;


@implementation SecondViewController
@synthesize _textField = textField;
//@synthesize code = ivCode;



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
    return YES;
}

- (void)runCheck {
    
    NSString * b = [NSString stringWithFormat:@"http://www.af2100.com/tracking/mobile/index.jsp?awb=%@",textField.text];
   // NSString * b = [NSString stringWithFormat:@"https://spreadsheets.google.com/feeds/list/0ArUkT24Ypo6odGYtTUU0YnNUdmk3a2YyWThnMTU4Ync/1/public/basic"];
   //  NSString * b = [NSString stringWithFormat:@"https://spreadsheets.google.com/feeds/list/0ArUkT24Ypo6odGYtTUU0YnNUdmk3a2YyWThnMTU4Ync/1/public/basic"];
  
    NSURL *url = [NSURL URLWithString:b];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request setRequestMethod:@"GET"];
    [request setDelegate:self];
    [request startAsynchronous];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading Results...";
}

//for the DONE key
- (BOOL)textFieldShouldReturn:(UITextField*)_textField {
  
       
    [self runCheck];
     NSLog(@"XXXXXXX");
    [textField resignFirstResponder];
    return TRUE;

}

//to remove the keyboard
-(IBAction)backgroundTouched:(id)sender {

       [textField resignFirstResponder];
        NSLog(@"here i am");
    
}


//for the Track Key
- (IBAction) btnTrack:(id)sender;
{
    if ([textField.text isEqualToString:@""]){
        textField.layer.borderWidth = 2.0f;
        textField.layer.borderColor = [[UIColor redColor] CGColor];
        textField.layer.cornerRadius = 5;
        textField.clipsToBounds      = YES;
        [textField resignFirstResponder];}
    else{
        textField.layer.borderWidth = 1.0f;
        textField.layer.borderColor = [[UIColor whiteColor] CGColor];
        textField.layer.cornerRadius = 5;
        textField.clipsToBounds      = YES;
        [self runCheck];
        [textField resignFirstResponder];}
    
}


+ (NSString*)response {
    return staticRequest;
}

- (void)requestFinished:(ASIHTTPRequest *)request
{    
    staticRequest = [request responseString];
    NSLog(@"code %@",staticRequest);
    if (request.responseStatusCode == 400) {
        
        //NSLog(@"Invalid code"); 
        } else if (request.responseStatusCode == 503) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        UIAlertView *alert = [[UIAlertView alloc] init];
        [alert setTitle:@"Service Temporarily Unavailable. Please try again later."];
        [alert setDelegate:self];
        [alert addButtonWithTitle:@"Ok"];
        [alert show];

        } else if (request.responseStatusCode == 200) {
        staticRequest = [request responseString];
      
        DetailViewController *detailView = [[[DetailViewController alloc] init] autorelease];
        [self presentModalViewController:detailView animated:YES];
    }
    else {
        staticRequest = [request responseString];
        NSLog(@"Unexpected error%@",staticRequest);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        UIAlertView *alert = [[UIAlertView alloc] init];
        [alert setTitle:@"Service Temporarily Unavailable. Please try again later."];
        [alert setDelegate:self];
        [alert addButtonWithTitle:@"Ok"];
        [alert show];
    }
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    }

- (void)requestFailed:(ASIHTTPRequest *)request
{    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    UIAlertView *alert = [[UIAlertView alloc] init];
	[alert setTitle:@"Check your network connection"];
	[alert setDelegate:self];
	[alert addButtonWithTitle:@"Ok"];
	[alert show];
}


@end
