//
//  LocTblViewController.m
//  Air21
//
//  Created by Ben Cortez on 28/05/12.
//  Copyright (c) 2012 RedMedia. All rights reserved.
//


#import "LocTblViewController.h"
#import "AppDelegate.h"
#import "LocDtlViewController.h"
#import "OverlayViewController.h"
#import "BranchDatabase.h"
 
#import "A21BranchVO.h"
#import "LocTableHeader.h"
#import "LocTableCell.h"


@interface LocTblViewController () 

-(void) changeBG;

@end

@implementation LocTblViewController

@synthesize branchInfos = _branchInfos;

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName: nibNameOrNil bundle:nibBundleOrNil];
    if( self ) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        [locationManager startUpdatingLocation];
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    userCoordinate = newLocation.coordinate;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [BranchDatabase database];
	//Initialize the array.
	 	 
    
	//Set the title
	self.navigationItem.title = @"Branches";
	
	//Add the search bar
	self.tableView.tableHeaderView = searchBar;
	searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
	 
	searching = NO;
	letUserSelectRow = YES;
    [self changeBG];
}



-(void) changeBG {
    //self.view.backgroundColor = [UIColor colorWithRed:0.5 green:0.0 blue:0.9 alpha:1];
   
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    NSString *path = [[[NSBundle mainBundle] bundleURL] path];
    
    
    NSString *src = [NSString stringWithFormat:@"%@/%@",path, @"air21_app_bg_1440x960.jpg"];
  
    NSLog(@"Sourc %@", src );
 
  
    UIImage *image = [UIImage imageWithContentsOfFile:src];
 
    NSLog(@"IMage %@", image );
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundView = [[[UIImageView alloc] initWithImage:image]autorelease];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
	if (searching)
		return 1;
	else {
        int tsize = [[[BranchDatabase database] locations] count];
        return tsize;
    }
       
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	if (searching)
		//return [copyListOfItems count];
        return 0;
        
	else {
        NSArray *loc = [[BranchDatabase database]locations];
        NSString *air21 = [loc objectAtIndex: section];
        NSArray *branches = [[BranchDatabase database] branchesByCity:air21];
        
        //NSLog(@"Number of Rows in Section %d" , [branches count]);
        return [branches count];
	}
}
  

-(UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    if( searching) {
        return nil;
    }
    NSArray *loc = [[BranchDatabase database]locations];
    NSString *title = [loc objectAtIndex:section];
    LocTableHeader *header = [[[LocTableHeader alloc] initWithTitle: title] autorelease];
    
    return header;
    
}


-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
	if(searching)
		return nil;
    return [BranchDatabase database].locIndices;
}
 
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    
	if(searching)
		return -1;
	return [[BranchDatabase database] searchForIndex:title];
}
 

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero ]autorelease] ;
    }
    
	if(searching) {
        
    } else {
		  
        BranchDatabase *db = [BranchDatabase database];
        
        NSArray *locations = db.locations;
        NSString *city = [locations objectAtIndex:indexPath.section];
        NSArray *branches = [db branchesByCity:city];
        A21BranchVO *item = [branches objectAtIndex: indexPath.row];
        
         
        cell.textLabel.text =  nil;
        LocTableCell *cellbg =   [[LocTableCell alloc] initWithBranch: item] ;
        [cell.contentView addSubview: cellbg];
        [cellbg release];
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	BranchDatabase *db = [BranchDatabase database];
	A21BranchVO *branch  = [db branchForSection:indexPath.section row:indexPath.row];
   
    LocDtlViewController *dvController = [[LocDtlViewController alloc] initWithNibName:@"LocDtlViewController" bundle:[NSBundle mainBundle]];
	dvController.selectedBranch = branch;
    dvController.userCoordinate = userCoordinate;
    [self.navigationController pushViewController:dvController animated:YES];
    [dvController autorelease];
    dvController = nil;
    
}

- (NSIndexPath *)tableView :(UITableView *)theTableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if(letUserSelectRow)
		return indexPath;
	else
		return nil;
    
}

 

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
	
	[self tableView:tableView didSelectRowAtIndexPath:indexPath];
}

  

- (void)dealloc {
    [locationManager autorelease];
    [super dealloc];
    
}




#pragma mark -
#pragma mark Search Bar 

- (void) searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar {
	
	 
	
}

- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
   
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
	
	 
}

- (void) searchTableView {
    
}

- (void) doneSearching_Clicked:(id)sender {
	 
}

@end

