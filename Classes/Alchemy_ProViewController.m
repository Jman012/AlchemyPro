//
//  Alchemy_ProViewController.m
//  Alchemy Pro
//
//  Created by James Linnell on 9/25/10.
//  Copyright (c) 2010 PDHS. All rights reserved.
//

#import "Alchemy_ProViewController.h"
#import "SpecificCategoryViewController.h"

@implementation Alchemy_ProViewController


@synthesize catList, boardView, comboButton;
@synthesize sideBarView, firstComboImageView, secondComboImageView;
@synthesize firstElement, secondElement, tempComboElement, deleteElement;
@synthesize firstElementComboTaken, secondElementComboTaken;
@synthesize initiatedElements, sideBarElements;
@synthesize doubleElementCombos, elementCategories;
@synthesize deleteID;


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    initiatedElements = [[NSMutableDictionary alloc] init];
    sideBarElements = [[NSMutableDictionary alloc] init];
    
    //The setup for the double combinations and repective categories
    NSBundle *myBundle = [NSBundle mainBundle];
    NSString *path = [myBundle pathForResource:@"ElementComboPList" ofType:@"plist"];
    doubleElementCombos = [[NSDictionary alloc] initWithContentsOfFile:path];

    path = [myBundle pathForResource:@"ElementCategories" ofType:@"plist"];
    elementCategories = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    //Get a list of already unlocked Elements, not fully implemented yet
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    catList = [settings objectForKey:@"AlchemyCategoryList"];
    if(catList == nil){
        NSLog(@"Is nil");
        catList = [[NSArray alloc] initWithObjects:@"Water", @"Fire", @"Air", @"Earth", @"Blank", nil]; 
    }
    [settings release];
    firstElementComboTaken = NO;
    secondElementComboTaken = NO;
    [comboButton addTarget:self action:@selector(comboButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [super viewDidLoad];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [catList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Alchemy"];
    
    if(cell == nil){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewStylePlain reuseIdentifier:@"Alchemy"] autorelease];
    }
    
    cell.textLabel.text = [catList objectAtIndex:indexPath.row];
    return cell;
}

- (void)boardAddElement:(NSString *)elementName {
    NSTimeInterval epochTime = [[NSDate date] timeIntervalSince1970];
    NSString *ID = [[NSString alloc] initWithFormat:@"%u", epochTime];
    
    NSLog(@"Add: %@, %@", elementName, ID);
    
    Element *element = [[Element alloc] initWithName:elementName andID:ID];
    element.frame = CGRectMake(32, 32, 64, 64);
    [element setDelegate:self];
    if([element isValid])
        [self.boardView addSubview:element];
    [initiatedElements setObject:element forKey:ID];
    [element release];
    element = nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row < 4){
        [self boardAddElement:[catList objectAtIndex:indexPath.row]];
    }
    else if(indexPath.row >= 4){
        NSLog(@"EARG: %@", [catList objectAtIndex:indexPath.row]);
        //[self presentModalViewController:instanceOfNewView animated:YES];
        //[[self parentViewController] dismissModalViewControllerAnimated:YES];
        
        NSBundle *mainBundle = [NSBundle mainBundle];
        NSString *nibName = [mainBundle pathForResource:@"SpecificCategoryViewController" ofType:@"xib"];
        SpecificCategoryViewController *catViewController = [[SpecificCategoryViewController alloc] initWithNibName:nibName bundle:nil];
        [catViewController giveCategory:[catList objectAtIndex:indexPath.row]];
        [self presentModalViewController:catViewController animated:YES];
        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)elementWasTouchedWithName:(NSString *)name andID:(NSString *)ID touch:(NSSet *)touches andEvent:(UIEvent *)event {
    Element *tempElement = [initiatedElements objectForKey:ID];
    CGPoint pt = [[touches anyObject] locationInView:tempElement];
    tempElement.startPosition = pt;
    [boardView bringSubviewToFront:tempElement];
    UITouch *touch = [touches anyObject];
    if([touch tapCount] == 2){
        deleteElement = tempElement;
        deleteID = ID;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(deleteAnimDidStop:finished:context:)];
        [UIView setAnimationDuration:0.3];
        [tempElement setTransform:CGAffineTransformMakeScale(0.1, 0.1)];
//        [tempElement setFrame:CGRectMake(tempElement.frame.origin.x, tempElement.frame.origin.y, 0, 0)];
        [UIView commitAnimations];
    }
}

- (void)deleteAnimDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    if([deleteElement sitting] == TRUE){
        [sideBarElements removeObjectForKey:deleteID];
    }
    [initiatedElements removeObjectForKey:deleteID];
    [deleteElement removeFromSuperview];
}

- (void)elementWasMovedWithName:(NSString *)name andID:(NSString *)ID touch:(NSSet *)touches andEvent:(UIEvent *)event {
    Element *tempElement = [initiatedElements objectForKey:ID];

    
    CGPoint pt = [[touches anyObject] locationInView:tempElement];
    CGRect frame = [tempElement frame];
    frame.origin.x += pt.x - tempElement.startPosition.x;
    frame.origin.y += pt.y - tempElement.startPosition.y;
    if(frame.origin.x >= 0 && frame.origin.y >= 0 && frame.origin.x <= 256 && frame.origin.y <= 252){
        tempElement.inSideBar = FALSE;
        tempElement.sitting = FALSE;
        if(tempElement.currentPlacement != 0){
            if(tempElement.currentPlacement == 1)
                firstElementComboTaken = NO;
            if(tempElement.currentPlacement == 2)
                secondElementComboTaken = NO;
            tempElement.currentPlacement = 0;
            if([sideBarElements objectForKey:ID] != nil){
                NSLog(@"Deleting %@", name);
                [sideBarElements removeObjectForKey:ID];
            }
        }
        tempElement.frame = frame;
    }
    else
        tempElement.inSideBar = TRUE;
    
    if(tempElement.inSideBar == TRUE){
        //        if(CGRectContainsPoint(CGRectMake(272, 0, 80, 252), CGPointMake(self.frame.origin.x +   16, self.frame.origin.y))){
        if(tempElement.sitting == FALSE){
            if(firstElementComboTaken == NO){
                [UIView beginAnimations:nil context:NULL];
                tempElement.sitting = TRUE;
                tempElement.currentPlacement = 1;
                [sideBarElements setObject:tempElement forKey:ID];
                [UIView setAnimationDuration:0.2];
                [tempElement setFrame:CGRectMake(280, 20, 64, 64)];
                [UIView commitAnimations];
                firstElementComboTaken = YES;
            }
            else{
                if(secondElementComboTaken == NO){
                    [UIView beginAnimations:nil context:NULL];
                    tempElement.sitting = TRUE;
                    tempElement.currentPlacement = 2;
                    [sideBarElements setObject:tempElement forKey:ID];
                    [UIView setAnimationDuration:0.2];
                    [tempElement setFrame:CGRectMake(280, 124, 64, 64)];
                    [UIView commitAnimations];
                    secondElementComboTaken = YES;
                }
            }
        }
    }
}

- (void)comboButtonPressed:(id)sender {
    NSLog(@"Button touched");
    Element *markerElement = [[Element alloc] init];
    NSMutableArray *comboElements = [[NSArray alloc] initWithArray:[sideBarElements objectsForKeys:[sideBarElements allKeys] notFoundMarker:markerElement]];
    
    [markerElement release];
    if([comboElements count] == 0){
        NSLog(@"No Elements in SideBar");
        UIAlertView *noElementAlert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"You have no Elements to combine!"
                                                                delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [noElementAlert show];
        [noElementAlert release];
    }
    else if([comboElements count] == 1){
        NSLog(@"Only a single Element!");
        UIAlertView *oneElementAlert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"You have only one Element to combine!"
                                                                 delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [oneElementAlert show];
        [oneElementAlert release];
    }
    else if([comboElements count] == 2){
        
        NSLog(@"Two Elements, Searching for Possible Matches");
        
        firstElement = [comboElements objectAtIndex:0];
        secondElement = [comboElements objectAtIndex:1];
        NSLog(@"Elements: %@ and %@", firstElement.elementName, secondElement.elementName);
        
        NSString *doubleCombined;
        NSString *doubleFromDict;
        if([[firstElement elementName] compare:[secondElement elementName]] == -1){
            //If they are already in alphebetical order
            doubleCombined = [[NSString alloc] initWithFormat:@"%@+%@", [firstElement elementName], [secondElement elementName]];
        }
        else if([[firstElement elementName] compare:[secondElement elementName]] == 1){
            //If they are not in alphebetical order
            doubleCombined = [[NSString alloc] initWithFormat:@"%@+%@", [secondElement elementName], [firstElement elementName]];
        }
        else if([[firstElement elementName] compare:[secondElement elementName]] == 0){
            //Both are equal
            doubleCombined = [[NSString alloc] initWithFormat:@"%@+%@", [firstElement elementName], [secondElement elementName]];
        }
        doubleFromDict = [doubleElementCombos objectForKey:doubleCombined];
        [doubleCombined release];
        if(doubleFromDict == nil){
            //If it's not found :P
            //Note: Add sound later
            NSLog(@"Wanted Combination not found");
        }
        
        else {
            
            //Make the desired Element
            NSTimeInterval epochTime = [[NSDate date] timeIntervalSince1970];
            NSString *ID = [[NSString alloc] initWithFormat:@"%u", epochTime];
            NSLog(@"Add: %@, %@", doubleFromDict, ID);
        
            tempComboElement = [[Element alloc] initWithName:doubleFromDict andID:ID];
            tempComboElement.frame = CGRectMake(32, 32, 64, 64);
            [tempComboElement setDelegate:self];
            [tempComboElement setElementID:ID];

            [initiatedElements setObject:tempComboElement forKey:ID];
            
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDidStopSelector:@selector(comboAnimDidStop:finished:context:)];
            
            [UIView setAnimationDuration:0.3];
            [firstElement setFrame:[tempComboElement frame]];
            [secondElement setFrame:[tempComboElement frame]];
            [UIView commitAnimations];
            
            [tempComboElement release];
        
            firstElementComboTaken = NO;
            secondElementComboTaken = NO;
        }
    }
    else if([comboElements count] > 2){
        NSLog(@"More than 3 elements? Problem!");
    }
    
}

- (void)comboAnimDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
    if([tempComboElement isValid])
        [self.boardView addSubview:tempComboElement];
    
    [sideBarElements removeObjectForKey:firstElement.elementID];
    [initiatedElements removeObjectForKey:firstElement.elementID];
    [firstElement removeFromSuperview];
    [firstElement release];
    
    [sideBarElements removeObjectForKey:secondElement.elementID];
    [initiatedElements removeObjectForKey:secondElement.elementID];
    [secondElement removeFromSuperview];
    [secondElement release];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
    
}


- (void)dealloc {
    [deleteID release];
    [deleteElement release];
    [sideBarView release];
    [firstElement release];
    [secondElement release];
    [firstComboImageView release];
    [secondComboImageView release];
    [doubleElementCombos release];
    [initiatedElements release];
    [sideBarElements release];
    [boardView release];
    [comboButton release];
    [catList release];
    [super dealloc];
}

@end
