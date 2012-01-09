//
//  FirstViewController.m
//
//  Air21 Mobile
//
//  Created by Ben Cortez on 7/1/11.
//  Copyright 2011 RedMedia. All rights reserved.
//

#import "FirstViewController.h"
#import "DetailViewController.h"


@implementation FirstViewController
@synthesize contents = ivContents;


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    NSArray *firstSection = [NSArray arrayWithObjects:@"Rate Calculator", nil];
	NSArray *secondSection = [NSArray arrayWithObjects:@"Tracking", nil];
    NSMutableArray * array = [[NSMutableArray alloc] initWithObjects:firstSection, secondSection, nil];
    [self setContents:array];
   
    [[self view] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_sand"]]];
    
     
    
    [super viewDidLoad];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *sectionContents = [[self contents] objectAtIndex:[indexPath section]];
	NSString *contentForThisRow = [sectionContents objectAtIndex:0];
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [[cell textLabel] setText:contentForThisRow];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *detailView = [[DetailViewController alloc] init];
    if ([indexPath section] == 0)
        NSLog (@"xxx");
    else if ([indexPath section] == 1)
        [[self navigationController] pushViewController:detailView animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:[self tableView] cellForRowAtIndexPath:indexPath];
    return [cell frame].size.height;
}

@end