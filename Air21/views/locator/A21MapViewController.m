//
//  A21MapViewController.m
//  Air21
//
//  Created by Phillip John Ardona on 6/28/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import "A21MapViewController.h"
#import "A21BranchVO.h"
#import "NetProxy.h" 
#import "DataCodec.h"
#import "MapRouteOverlay.h"
 
@interface A21MapViewController ()  

-(void)loadDirection:(CLLocationCoordinate2D) branch user:(CLLocationCoordinate2D) user ;
-(void)directionLoaded;
-(void) errorLoadingDirection;
-(CLLocationCoordinate2D) branchPoint2D;
-(CLLocationCoordinate2D) userPoint2D;
@end

@implementation A21MapViewController

@synthesize userCoordinate;
-(id) initWIthBranch:(A21BranchVO *)value {
    self =  [super initWithNibName: nil bundle: nil ];
    if( self ) {
        branch = [value retain];
    }
    return self;
}


-(CLLocationCoordinate2D) branchPoint2D {
    double lat = [branch.lati doubleValue];
    double longi = [branch.longi doubleValue];
    return CLLocationCoordinate2DMake(lat, longi);
}

-(CLLocationCoordinate2D ) userPoint2D {
    #if TARGET_IPHONE_SIMULATOR    
        return CLLocationCoordinate2DMake(14.678232, 121.082184);
        //NSLog(@"USING SIMULATOR RETUNR hardcoded points");
        //return userCoordinate;
    #else
        return userCoordinate;
    #endif
   
    
}
 
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mapview.delegate = self;
    CLLocationCoordinate2D branchPoint = [self branchPoint2D];
      
    MKCoordinateSpan  span = MKCoordinateSpanMake(0.01 , 0.01 );
    MKCoordinateRegion region = MKCoordinateRegionMake( branchPoint, span);
    [mapview setRegion: region animated:YES];
    
      
    MKPointAnnotation *annotation = [[[MKPointAnnotation alloc] init] autorelease];
    annotation.coordinate = branchPoint;
    annotation.title = [NSString stringWithFormat:@"%@",  branch.address1];
    [mapview addAnnotation: annotation];
    
          
    CLLocationCoordinate2D userPoint = [self userPoint2D];
    MKPointAnnotation *uannotation = [[[MKPointAnnotation alloc] init] autorelease];
    uannotation.coordinate = userPoint;
    uannotation.title = @"You Are Here";
    [mapview addAnnotation: uannotation];
    
    
    [self loadDirection: branchPoint user:userPoint];
    
}
 


- (void)viewDidUnload
{
    [super viewDidUnload];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void) loadDirection:(CLLocationCoordinate2D)b  user:(CLLocationCoordinate2D)user {
    
    if( proxy != nil ) {
        [proxy release];
    }
    proxy = [[NetProxy alloc] init];
    
    NSMutableDictionary *params = [[[NSMutableDictionary alloc] initWithCapacity:0] autorelease];
    NSString *origin = [NSString stringWithFormat:@"%f,%f", b.latitude, b.longitude];
    NSString *dest = [NSString stringWithFormat:@"%f,%f", user.latitude, user.longitude];
    [params setObject:origin forKey:@"origin"];
    [params setObject:dest forKey:@"destination"];
    [params setObject:@"false" forKey:@"sensor"];
    [proxy addListener:@"complete" withTarget:self andMethod:@"directionLoaded"]; 
    [proxy addListener:@"errorOnLoad" withTarget:self andMethod: @"errorLoadingDirection"];
    [proxy get: @"http://maps.googleapis.com/maps/api/directions/json" params: params];
    
}


-(void) errorLoadingDirection {
    [proxy release];
    proxy = nil;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connectivity Error" message:@"Sorry the map requieres internet connecitivy." delegate: self cancelButtonTitle: @"Ok" otherButtonTitles:nil , nil];
    
    [alert show];
    [alert autorelease];
}

-(void) directionLoaded {
     
    NSDictionary *direction = [DataCodec jsonToObject: proxy.content];
    
    [proxy release];
    proxy = nil;
    MapRouteOverlay  *route = [[MapRouteOverlay  alloc] initWithGoogleDirection:direction mapview:mapview];
    
    if( route.hasWayPoint ==  NO ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Available Information" message:@"Sorry the map doesn't have available information regarding your position." delegate: self cancelButtonTitle: @"Ok" otherButtonTitles:nil , nil];
        
        [alert show];
        [alert autorelease];
    }
    
    
    [route release];
}


- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay {
    
    MKPolylineView *polylineView = [[[MKPolylineView alloc] initWithPolyline:overlay]autorelease];
    polylineView.strokeColor = [UIColor purpleColor];
    polylineView.alpha = 0.8;
    polylineView.lineWidth = 2.0;
    
    return polylineView;
}


-(MKAnnotationView*) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    
    
    MKPinAnnotationView *newAnnotation = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"redpin"]autorelease];
    
    MKPointAnnotation *pa = (MKPointAnnotation*) annotation;
    
    if( [pa.title isEqualToString: @"You"] ) {
        newAnnotation.pinColor = MKPinAnnotationColorRed;
    } else {
        newAnnotation.pinColor = MKPinAnnotationColorPurple;
    }
    newAnnotation.animatesDrop = YES;
    newAnnotation.canShowCallout = YES;
    return newAnnotation;
}

 
-(void) didReceiveMemoryWarning {
    
}


-(void) dealloc {
     NSLog(@"Dealloc MapViewController");
    if( proxy != nil ) {
        [proxy release];
    }
    [mapview release];
    [branch release];
    
    [super dealloc];
}
@end
