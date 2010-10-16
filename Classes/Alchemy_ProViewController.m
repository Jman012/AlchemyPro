//
//  Alchemy_ProViewController.m
//  Alchemy Pro
//
//  Created by James Linnell on 9/25/10.
//  Copyright (c) 2010 PDHS. All rights reserved.
//

#import "Alchemy_ProViewController.h"

@implementation Alchemy_ProViewController


@synthesize catList, boardView, comboButton;
@synthesize firstElementComboTaken, secondElementComboTaken, thirdElementComboTaken;
@synthesize initiatedElements, sideBarElements;
@synthesize doubleElementCombos, tripleElementCombos;


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
    doubleElementCombos = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:@"Marsh", @"Lava", @"Energy", @"Steam", @"Dust", nil]
                                                        forKeys:[NSArray arrayWithObjects:@"Water+Earth", @"Earth+Fire", @"Fire+Air", @"Water+Fire", @"Air+Earth", nil]];
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    catList = [settings objectForKey:@"AlchemyCategoryList"];
    if(catList == nil){
        NSLog(@"Is nil");
        catList = [[NSArray alloc] initWithObjects:@"Water", @"Fire", @"Air", @"Earth", @"Blank", nil]; 
    }
    [settings release];
    firstElementComboTaken = NO;
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
    
    Element *element = [[Element alloc] init];
    element.frame = CGRectMake(32, 32, 64, 64);
    element.elementName = elementName;
    element.elementID = ID;
    [element loadVisualViews];
    [element setDelegate:self];
    [self.boardView addSubview:element];
    [initiatedElements setObject:element forKey:ID];
    [element release];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row < 4){
        [self boardAddElement:[catList objectAtIndex:indexPath.row]];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)elementWasTouchedWithName:(NSString *)name andID:(NSString *)ID touch:(NSSet *)touches andEvent:(UIEvent *)event {
    NSLog(@"%@ Touched", name);
//    NSLog(@"%@, %@", name, ID);
    Element *tempElement = [initiatedElements objectForKey:ID];
    CGPoint pt = [[touches anyObject] locationInView:tempElement];
    tempElement.startPosition = pt;
    [boardView bringSubviewToFront:tempElement];
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
            if(tempElement.currentPlacement == 3)
                thirdElementComboTaken = NO;
            tempElement.currentPlacement = 0;
            if([sideBarElements objectForKey:ID] != nil){
                NSLog(@"Deleting %@", ID);
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
                NSLog(@"First");
                [UIView beginAnimations:nil context:NULL];
                tempElement.sitting = TRUE;
                tempElement.currentPlacement = 1;
                [sideBarElements setObject:tempElement forKey:ID];
                [UIView setAnimationDuration:0.2];
                [tempElement setFrame:CGRectMake(280, 8, 64, 64)];
                [UIView commitAnimations];
                firstElementComboTaken = YES;
            }
            else{
                if(secondElementComboTaken == NO){
                    NSLog(@"Second");
                    [UIView beginAnimations:nil context:NULL];
                    tempElement.sitting = TRUE;
                    tempElement.currentPlacement = 2;
                    [sideBarElements setObject:tempElement forKey:ID];
                    [UIView setAnimationDuration:0.2];
                    [tempElement setFrame:CGRectMake(280, 80, 64, 64)];
                    [UIView commitAnimations];
                    secondElementComboTaken = YES;
                }
                else {
                    if(thirdElementComboTaken == NO){
                        NSLog(@"Third");
                        [UIView beginAnimations:nil context:NULL];
                        tempElement.sitting = TRUE;
                        tempElement.currentPlacement = 3;
                        [sideBarElements setObject:tempElement forKey:ID];
                        [UIView setAnimationDuration:0.2];
                        [tempElement setFrame:CGRectMake(280, 152, 64, 64)];
                        [UIView commitAnimations];
                        thirdElementComboTaken = YES;
                    }
                }
            }
        }
    }
}


- (void)comboButtonPressed:(id)sender {
    NSLog(@"Button touched");
    Element *markerElement = [[Element alloc] init];
    NSArray *comboElements = [[NSArray alloc] initWithArray:[sideBarElements objectsForKeys:[sideBarElements allKeys] notFoundMarker:markerElement]];
    
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
        Element *firstElement = [comboElements objectAtIndex:0];
        Element *secondElement = [comboElements objectAtIndex:1];
        NSLog(@"Elements: %@ and %@", firstElement.elementName, secondElement.elementName);
        
        //Complex as hell algorithm using large lists of elements and combos :P
        NSString *compareFirst = [[NSString alloc] initWithFormat:@"%@+%@", firstElement.elementName, secondElement.elementName];
        NSString *compareSecond = [[NSString alloc] initWithFormat:@"%@+%@", secondElement.elementName, firstElement.elementName];
        NSString *tempElement = [doubleElementCombos objectForKey:compareFirst];
        NSString *tempElement2 = [doubleElementCombos objectForKey:compareSecond];
        
        
        if(tempElement != nil || tempElement2 != nil){
            
            //Used to simplify and combine orignial if and else, easier to edit
            if(tempElement != nil && tempElement2 == nil){
                
            }
            else if(tempElement == nil && tempElement2 != nil){
                tempElement = tempElement2;
            }
            
            NSTimeInterval epochTime = [[NSDate date] timeIntervalSince1970];
            NSString *ID = [[NSString alloc] initWithFormat:@"%u", epochTime];
            
            NSLog(@"Add: %@, %@", tempElement, ID);
            
            Element *element = [[Element alloc] init];
            element.frame = CGRectMake(32, 32, 64, 64);
            element.elementName = tempElement;
            element.elementID = ID;
            [element loadVisualViews];
            [element setDelegate:self];
            [self.boardView addSubview:element];
            [initiatedElements setObject:element forKey:ID];
            [element release];
            
            [sideBarElements removeObjectForKey:firstElement.elementID];
            [initiatedElements removeObjectForKey:firstElement.elementID];
            [firstElement removeFromSuperview];
            [firstElement release];
            
            [sideBarElements removeObjectForKey:secondElement.elementID];
            [initiatedElements removeObjectForKey:secondElement.elementID];
            [secondElement removeFromSuperview];
            [secondElement release];
            
            firstElementComboTaken = NO;
            secondElementComboTaken = NO;
        }
        
//        [firstElement release];
//        [secondElement release];
    }
    else if([comboElements count] == 3){
        NSLog(@"Three Elements, Searching for Possible Matches");
    }
    else if([comboElements count] > 3){
        NSLog(@"More than 3 elements? Problem!");
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    UITouch *touch = [[event allTouches] anyObject];
//    if([touch view] == boardView){
//        NSLog(@"Touched %@", [touch view]);
//    }
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
    [initiatedElements release];
    [sideBarElements release];
    [boardView release];
    [comboButton release];
    [catList release];
    [super dealloc];
}

@end
