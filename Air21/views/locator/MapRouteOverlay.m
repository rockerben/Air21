//
//  MapRouteOverlayView.m
//  Air21
//
//  Created by Phillip John Ardona on 6/28/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import "MapRouteOverlay.h" 
  

@interface MapRouteOverlay() 
-(NSMutableArray *)decodePolyLine:(NSString *)encodedStr ;
    
@end

@implementation MapRouteOverlay
@synthesize hasWayPoint;
-(id) initWithGoogleDirection:(NSDictionary*) direction  mapview:(MKMapView*) map {
    self = [super init];
    if( self ) {
        
        NSArray *routes = [direction objectForKey:@"routes"];
        NSDictionary *route = [routes lastObject];
        if( route ) {
           // NSLog(@"Drawing Routes");
            NSDictionary *overview = [route objectForKey:@"overview_polyline"];
            NSString *strPath = [overview objectForKey:@"points"];
            NSArray *path = [self decodePolyLine:  strPath];
        
            int joints = path.count;
            CLLocationCoordinate2D  points[joints];
            for( int i = 0; i < joints; i++ ) {
                CLLocation *location = [path objectAtIndex:i];
                CLLocationCoordinate2D coordinate = location.coordinate;
                points[i] = coordinate;
            }
            
            MKPolyline *poly =  [MKPolyline polylineWithCoordinates:points count:joints];
            [map addOverlay: poly];
            hasWayPoint = YES;
            if( joints == YES ) {
                hasWayPoint = NO;
            }  
            
        } else {
            hasWayPoint = NO;
        }
    }
    return self;
}


-(NSMutableArray *)decodePolyLine:(NSString *)encodedStr {
    NSMutableString *encoded = [[[NSMutableString alloc] initWithCapacity:[encodedStr length]] autorelease];
    
    [encoded appendString:encodedStr];
    [encoded replaceOccurrencesOfString:@"\\\\" withString:@"\\"
                                options:NSLiteralSearch
                                  range:NSMakeRange(0, [encoded length])];
    
    NSInteger len = [encoded length];
    NSInteger index = 0;
    
    NSMutableArray *array = [[[NSMutableArray alloc] init] autorelease];
    
    NSInteger lat=0;
    NSInteger lng=0;
    while (index < len) {
        NSInteger b;
        NSInteger shift = 0;
        NSInteger result = 0;
        do {
            b = [encoded characterAtIndex:index++] - 63;
            result |= (b & 0x1f) << shift;
            shift += 5;
        } while (b >= 0x20);
        NSInteger dlat = ((result & 1) ? ~(result >> 1) : (result >> 1));
        lat += dlat;
        shift = 0;
        result = 0;
        do {
            b = [encoded characterAtIndex:index++] - 63;
            result |= (b & 0x1f) << shift;
            shift += 5;
        } while (b >= 0x20);
        NSInteger dlng = ((result & 1) ? ~(result >> 1) : (result >> 1));
        lng += dlng;
        NSNumber *latitude = [[[NSNumber alloc] initWithFloat:lat * 1e-5] autorelease];
        NSNumber *longitude = [[[NSNumber alloc] initWithFloat:lng * 1e-5]autorelease];
        
        CLLocation *location = [[CLLocation alloc] initWithLatitude:[latitude floatValue] longitude:[longitude floatValue]];
        
        [array addObject:location];
        [location release];
    }
    
    return array;
}
 

@end
