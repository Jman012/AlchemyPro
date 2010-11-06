//
//  Alchemy_ProViewController.m
//  Alchemy Pro
//
//  Created by James Linnell on 9/25/10.
//  Copyright (c) 2010 PDHS. All rights reserved.
//

#import "Alchemy_ProViewController.h"
#import "SpecificCategoryViewController.h"
#import "ElementSelectionView.h"

@implementation Alchemy_ProViewController


@synthesize catList, boardView, comboButton;
@synthesize sideBarView, firstComboImageView, secondComboImageView, catTableView;
@synthesize addButton, infoForElement, removeButton;
@synthesize firstElement, secondElement, tempComboElement, deleteElement;
@synthesize firstElementComboTaken, secondElementComboTaken;
@synthesize initiatedElements, sideBarElements;
@synthesize doubleElementCombos, elementCategories, elementsForCategory;
@synthesize deleteID, unlockedElements, unlockedCategories;
@synthesize selectedElement;


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
    
    path = [myBundle pathForResource:@"ElementsForCategory" ofType:@"plist"];
    elementsForCategory = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    //Get a list of already unlocked Elements, not fully implemented yet
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    catList = [settings objectForKey:@"AlchemyCategoryList"];
    unlockedElements = [settings objectForKey:@"AlchemyUnlockedElements"];
    unlockedCategories = [settings objectForKey:@"AlchemyUnlockedCategories"];
    if(catList == nil){
        NSLog(@"Is nil");
        catList = [[NSMutableArray alloc] initWithObjects:@"Water", @"Fire", @"Air", @"Earth", nil];
    }
    if(unlockedElements == nil){
        unlockedElements = [[NSMutableArray alloc] initWithObjects:@"Water", @"Fire", @"Air", @"Earth", nil];
    }
    if(unlockedCategories == nil){
        unlockedCategories = [[NSMutableArray alloc] initWithArray:nil];
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

- (Element *)boardAddElement:(NSString *)elementName {
    NSTimeInterval epochTime = [[NSDate date] timeIntervalSince1970];
    NSString *ID = [[NSString alloc] initWithFormat:@"%u", epochTime];
    
    NSLog(@"Add: %@, %@", elementName, ID);
    
    Element *element = [[Element alloc] initWithName:elementName andID:ID];
    element.frame = CGRectMake(32, 32, 64, 64);
    [element setDelegate:self];
    if([element isValid])
        [self.boardView addSubview:element];
    [initiatedElements setObject:element forKey:ID];
    return element;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row < 4){
        [self boardAddElement:[catList objectAtIndex:indexPath.row]];
    }
    else if(indexPath.row >= 4){
        //[self presentModalViewController:instanceOfNewView animated:YES];
        //[[self parentViewController] dismissModalViewControllerAnimated:YES];
        
        /*NSBundle *mainBundle = [NSBundle mainBundle];
        NSString *nibName = [mainBundle pathForResource:@"SpecificCategoryViewController" ofType:@"xib"];
        SpecificCategoryViewController *catViewController = [[SpecificCategoryViewController alloc] initWithNibName:nibName bundle:nil];
        NSArray *elementsToSend = [elementCategories objectForKey:[catList objectAtIndex:indexPath.row]];
        [catViewController giveElementsInCategory:elementsToSend];
        [catViewController giveCategory:[catList objectAtIndex:indexPath.row]];
        NSMutableArray *tempUnlockedToGive = [[NSMutableArray alloc] initWithArray:[elementCategories objectForKey:[catList objectAtIndex:indexPath.row]]];
        NSMutableArray *temptemp = [tempUnlockedToGive copy];
        for(NSString *tempString in temptemp){
            if([unlockedElements containsObject:tempString] == TRUE){
                NSLog(@"Keep object: %@", tempString);
            }
            else {
                NSLog(@"Remove un-unlocked object :%@", tempString);
                [tempUnlockedToGive removeObject:tempString];
            }
        }
        [catViewController giveUnlockedElementsForCategory:tempUnlockedToGive];
        [catViewController setDelegate:self];
        [self presentModalViewController:catViewController animated:YES];*/
        
        
        
                                    
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)elementWasTouchedWithName:(NSString *)name andID:(NSString *)ID touch:(NSSet *)touches andEvent:(UIEvent *)event {
    Element *tempElement = [initiatedElements objectForKey:ID];
    CGPoint pt = [[touches anyObject] locationInView:tempElement];
    tempElement.startPosition = pt;
    [boardView bringSubviewToFront:tempElement];
    UITouch *touch = [touches anyObject];
    if([touch tapCount] == 1){
        NSArray *allElements = [[NSArray alloc] initWithArray:[initiatedElements allValues]];
        for(Element *deselect in allElements){
            if(deselect != tempElement){
                [deselect setSelected:NO];
            }
            else {
                [deselect setSelected:YES];
                selectedElement = deselect;
            }
        }
        [allElements release];
    }
    if([touch tapCount] == 2){
        deleteElement = tempElement;
        deleteID = ID;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(deleteAnimDidStop:finished:context:)];
        [UIView setAnimationDuration:0.3];
        [tempElement setTransform:CGAffineTransformMakeScale(0.1, 0.1)];
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
    if(frame.origin.x+32 >= 0 && frame.origin.y+32 >= 0 && frame.origin.x+32 <= boardView.frame.size.width && frame.origin.y+32 <= boardView.frame.size.height){
        tempElement.frame = frame;
        
    }
}

- (void)elementTouchEnded:(NSString *)name andID:(NSString *)ID touch:(NSSet *)touches andEvent:(UIEvent *)event {
    Element *endedElement = [initiatedElements objectForKey:ID];
    for(Element *tempElement in [initiatedElements allValues]){
        if(tempElement == endedElement){
        
        }
        else {
            float eX = endedElement.frame.origin.x;
            float eY = endedElement.frame.origin.y;
            float tX = tempElement.frame.origin.x;
            float tY = tempElement.frame.origin.y;
            if(eX+32 > tX && eX+32 < tX+64 && eY+32 > tY && eY+32 < tY+64){
                NSLog(@"Combine %@ and %@", [endedElement elementName], [tempElement elementName]);
            
                NSString *doubleCombined;
                NSString *doubleFromDict;
                if([[endedElement elementName] compare:[tempElement elementName]] == -1){
                    //If they are already in alphebetical order
                    doubleCombined = [[NSString alloc] initWithFormat:@"%@+%@", [endedElement elementName], [tempElement elementName]];
                }
                else if([[endedElement elementName] compare:[tempElement elementName]] == 1){
                    //If they are not in alphebetical order
                    doubleCombined = [[NSString alloc] initWithFormat:@"%@+%@", [tempElement elementName], [endedElement elementName]];
                }
                else if([[endedElement elementName] compare:[tempElement elementName]] == 0){
                    //Both are equal
                    doubleCombined = [[NSString alloc] initWithFormat:@"%@+%@", [endedElement elementName], [tempElement elementName]];
                }
                doubleFromDict = [doubleElementCombos objectForKey:doubleCombined];
                if(doubleFromDict == nil){
                    //If it's not found :P
                    //Note: Add sound later
                    NSLog(@"Wanted Combination not found");
                }
                else {
                    NSLog(@"Yay %@", doubleCombined);
                    
                    [initiatedElements removeObjectForKey:endedElement.elementID];
                    [initiatedElements removeObjectForKey:tempElement.elementID];
                    
                    
                    [endedElement removeFromSuperview];
                    [tempElement removeFromSuperview];
                    [endedElement release];
                    [tempElement release];
                    
                    Element *combinedElement = [self boardAddElement:doubleFromDict];
                    [initiatedElements setObject:combinedElement forKey:[combinedElement elementID]];
                    [combinedElement setDelegate:self];
                    
                    if([unlockedElements containsObject:doubleFromDict] == FALSE){
                        [unlockedElements addObject:doubleFromDict];
                        NSLog(@"%@ added to unlocked", doubleFromDict);
                        NSString *tempCat = [elementsForCategory objectForKey:doubleFromDict];
                        if([unlockedCategories containsObject:tempCat] == FALSE){
                            NSLog(@"%@ added to unlocked cats", tempCat);
                            [unlockedCategories addObject:tempCat];
                        }
                    }
                    
                    break;
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
            
            if([unlockedElements containsObject:doubleFromDict] == FALSE){
                [unlockedElements addObject:doubleFromDict];
                NSLog(@"%@ added to unlocked", doubleFromDict);
                NSString *tempCat = [elementsForCategory objectForKey:doubleFromDict];
                if([unlockedCategories containsObject:tempCat] == FALSE){
                    NSLog(@"%@ added to unlocked cats", tempCat);
                    [catTableView beginUpdates];
                    [unlockedCategories addObject:tempCat];
                    [catList addObject:tempCat];
//                    [catTableView reloadData];
                    [catTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:[catList count]-1 inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
                    
                    [catTableView endUpdates];
                }
            }
            else {
                //Soudns or whatever for if already unlocked
            }
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

- (void)passChosenElement:(NSString *)chosenElementName {
    if(chosenElementName != nil){
        chosenElement = chosenElementName;
        [self boardAddElement:chosenElement];
    }
}

- (IBAction)addButtonPushed:(id)sender {
    ElementSelectionView *chooseElementView = [[ElementSelectionView alloc] 
                                               initWithNibName:[[NSBundle mainBundle] pathForResource:@"ElementSelectionView" ofType:@"xib"] 
                                               bundle:nil];
    [chooseElementView giveUnlockedElements:(NSArray *)unlockedElements withCategories:(NSArray *)unlockedCategories];
    [chooseElementView setDelegate:self];
    [self presentModalViewController:chooseElementView animated:YES];
}

- (IBAction)infoForElementButtonPushed:(id)sender {
    [self boardAddElement:@"Water"];
}

- (IBAction)removeButtonPushed:(id)sender {
    if(selectedElement != nil){
        deleteElement = selectedElement;
        deleteID = selectedElement.elementID;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(deleteAnimDidStop:finished:context:)];
        [UIView setAnimationDuration:0.3];
        [selectedElement setTransform:CGAffineTransformMakeScale(0.1, 0.1)];
        [UIView commitAnimations];
    }
}

-(void)acceptElementsToAdd:(NSArray *)toBeAddedElements {
    for(Element *tempElement in toBeAddedElements){
        NSLog(@"%@", tempElement.elementName);
        [self boardAddElement:[tempElement elementName]];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    if([touch view] == boardView){
        for(Element *tempElement in [initiatedElements allValues]){
            [tempElement setSelected:NO];
        }
    }
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    [catList release];
    [boardView release];
    [comboButton release];
    [sideBarView release];
    [firstComboImageView release];
    [secondComboImageView release];
    [catTableView release];
    
    [firstElement release];
    [secondElement release];
    [tempComboElement release];
    [deleteElement release];
    
    [deleteID release];
    
    [initiatedElements release];
    [sideBarElements release];
    
    [doubleElementCombos release];
    [elementCategories release];
    [elementsForCategory release];
    
    [chosenElement release];
    
    [unlockedElements release];
    [unlockedCategories release];
    [super dealloc];
}

@end
