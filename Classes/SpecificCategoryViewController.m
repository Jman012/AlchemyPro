//
//  SpecificCategoryViewController.m
//  Alchemy Pro
//
//  Created by James Linnell on 10/23/10.
//  Copyright (c) 2010 PDHS. All rights reserved.
//

#import "SpecificCategoryViewController.h"


@implementation SpecificCategoryViewController


@synthesize backButton, toolbar, mainTableView, titleLabel;
@synthesize category, elementCategories, elementsInCategory, unlockedElementsToShow;


- (void)setDelegate:(id <SpecificCategoryViewControllerDelegate>)dlg {
    delegate = dlg;
}


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
        category = @"Blank, if you see this, it's an error";
        NSLog(@"init");
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    /*
    NSBundle *myBundle = [NSBundle mainBundle];
    NSString *path = [myBundle pathForResource:@"ElementCategories" ofType:@"plist"];
    elementCategories = [[NSDictionary alloc] initWithContentsOfFile:path];
    elementsInCategory = [elementCategories objectForKey:category];
     */
    NSLog(@"viewDidLoad");
    [titleLabel setText:category];
    [super viewDidLoad];
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}


- (int)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    return [unlockedElementsToShow count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cellForRow");
    static NSString *CellIdentifier = @"Alchemy";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [unlockedElementsToShow objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *tempChosenElement = [elementsInCategory objectAtIndex:indexPath.row];
    [delegate passChosenElement:tempChosenElement];
    [[self parentViewController] dismissModalViewControllerAnimated:YES];
}

- (IBAction)backButtonPressed:(id)sender {
    [[self parentViewController] dismissModalViewControllerAnimated:YES];
}

- (void)giveCategory:(NSString *)categoryName {
    if(categoryName != nil){
        category = categoryName;
    }
}

- (void)giveElementsInCategory:(NSArray *)arrayWithElements {
    if(arrayWithElements != nil){
        elementsInCategory = arrayWithElements;
    }
}

- (void)giveUnlockedElementsForCategory:(NSArray *)unlocked {
    unlockedElementsToShow = unlocked;
    NSLog(@"Unlocked: %@", unlockedElementsToShow);
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [unlockedElementsToShow release];
    [elementCategories release];
    [elementsInCategory release];
    [category release];
    [titleLabel release];
    [backButton release];
    [mainTableView release];
    [toolbar release];
    [super dealloc];
}


@end
