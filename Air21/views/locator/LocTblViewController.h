//
//  LocTblViewController.h
//  Air21
//
//  Created by Ben Cortez on 28/05/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h> 
#import "OverlayViewController.h"

@interface LocTblViewController : UITableViewController <CLLocationManagerDelegate>
{
  
	IBOutlet UISearchBar *searchBar;
	BOOL searching;
	BOOL letUserSelectRow;
    OverlayViewController *ovController;

     CLLocationManager *locationManager;
     CLLocationCoordinate2D  userCoordinate;
     NSArray *_branchInfos;
}
@property (nonatomic, retain) NSArray *branchInfos;

- (void) searchTableView;
- (void) doneSearching_Clicked:(id)sender;
@end
