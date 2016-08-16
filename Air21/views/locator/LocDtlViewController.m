//
//  LocDtlViewController.m
//  Air21
//
//  Created by Ben Cortez on 2/06/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//
#import "A21MapViewController.h"
#import "LocDtlViewController.h"

@interface LocDtlViewController ()
 
-(void) createMapButton;
-(void) showMap;
@end

@implementation LocDtlViewController

@synthesize selectedBranch , userCoordinate;

 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         
    }
    return self;
}

-(void) setSelectedBranch:(A21BranchVO *)value {
    if( selectedBranch != nil ) {
        [selectedBranch release];
    } 
    
   //   NSLog(@"Long %@ Lat %@ " ,value.longi , value.lati );
     
    selectedBranch = [value retain];
}

- (void)viewDidLoad
{
     
    [super viewDidLoad];
    self.navigationItem.title = selectedBranch.air21;
    [self createMapButton];
    
   [branchBox updateInfo: selectedBranch];
   [phoneBox updateInfo: selectedBranch];
   [hourBox updateInfo: selectedBranch];
    [emailBox updateInfo:selectedBranch]; 
}

-(void) createMapButton {
     UIBarButtonItem *mapbtn = [[[UIBarButtonItem alloc] initWithTitle:@"Map" style: UIBarButtonItemStyleBordered  target:self action:@selector(showMap)] autorelease];  
    self.navigationItem.rightBarButtonItem = mapbtn;
}

 


-(void) showMap {
    A21MapViewController *vc = [[A21MapViewController alloc] initWIthBranch: selectedBranch];
    vc.userCoordinate = userCoordinate;
    [self.navigationController pushViewController: vc animated: YES];
    [vc release];
}
- (void)viewDidUnload
{
     
    [super viewDidUnload];
    self.navigationItem.rightBarButtonItem = nil;
     
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    
     
}
-(void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    
        
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void) dealloc {
    NSLog(@"Dealloc LocDtlViewController");
    [branchBox clear];
    [phoneBox clear];
    [hourBox clear];
    [emailBox clear];
    
    [branchBox release];
    [phoneBox release];
    [hourBox release];
    [emailBox release];
    [selectedBranch release];
    
    [super dealloc];
}

@end
