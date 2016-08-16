//
//  MapRouteOverlayView.h
//  Air21
//
//  Created by Phillip John Ardona on 6/28/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Mapkit/Mapkit.h>

@interface MapRouteOverlay: NSObject {
    BOOL hasWayPoint; 
}

@property(nonatomic, assign) BOOL  hasWayPoint;
-(id) initWithGoogleDirection:(NSDictionary*) direction mapview:(MKMapView*) map;
 
@end
