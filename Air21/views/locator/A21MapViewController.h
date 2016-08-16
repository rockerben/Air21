//
//  A21MapViewController.h
//  Air21
//
//  Created by Phillip John Ardona on 6/28/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Mapkit/Mapkit.h> 
#import <CoreLocation/CoreLocation.h>
#import "NetProxy.h"
 
@class A21BranchVO;
@interface A21MapViewController : UIViewController  <MKMapViewDelegate >{
    
    IBOutlet MKMapView *mapview;    
    CLLocationCoordinate2D  userCoordinate;
     A21BranchVO *branch;
    NetProxy *proxy;
    
}

@property(nonatomic, assign) CLLocationCoordinate2D userCoordinate;
-(id) initWIthBranch:(A21BranchVO*) value;

@end
