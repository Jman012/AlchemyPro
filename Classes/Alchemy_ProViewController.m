//
//  Alchemy_ProViewController.m
//  Alchemy Pro
//
//  Created by James Linnell on 9/25/10.
//  Copyright (c) 2010 PDHS. All rights reserved.
//

#import "Alchemy_ProViewController.h"
#import "ElementSelectionView.h"

@implementation Alchemy_ProViewController


@synthesize boardView;
@synthesize addButton, infoForElement, removeButton;
@synthesize deleteElement;
@synthesize initiatedElements;
@synthesize doubleElementCombos, elementsForCategory;
@synthesize deleteID, unlockedElements, unlockedCategories, allUnlocked;
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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    initiatedElements = [[NSMutableDictionary alloc] init];
    
    //The setup for the double combinations and repective categories
    NSBundle *myBundle = [NSBundle mainBundle];
    NSString *path = [myBundle pathForResource:@"ElementComboPList" ofType:@"plist"];
    doubleElementCombos = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    path = [myBundle pathForResource:@"ElementsForCategory" ofType:@"plist"];
    elementsForCategory = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    //Get a list of already unlocked Elements, not fully implemented yet
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    unlockedElements = [settings objectForKey:@"AlchemyUnlockedElements"];
    unlockedCategories = [settings objectForKey:@"AlchemyUnlockedCategories"];
    allUnlocked = [settings objectForKey:@"AlchemyProAllUnlocked"];
    if(unlockedElements == nil){
        unlockedElements = [[NSMutableArray alloc] initWithObjects:@"Water", @"Fire", @"Air", @"Earth", nil];
    }
    if(unlockedCategories == nil){
        unlockedCategories = [[NSMutableArray alloc] initWithArray:nil];
    }
    if(allUnlocked == nil){
        allUnlocked = [[NSMutableDictionary alloc] init];
    }
    [settings release];
    [super viewDidLoad];
}

- (Element *)boardAddElement:(NSString *)elementName {
    return [self boardAddElement:elementName atPoint:CGPointMake(32, 32)];
}

- (Element *)boardAddElement:(NSString *)elementName atPoint:(CGPoint)pt {
    NSTimeInterval epochTime = [[NSDate date] timeIntervalSince1970];
    NSString *ID = [[NSString alloc] initWithFormat:@"%u", epochTime];
    
    NSLog(@"Add: %@, %@", elementName, ID);
    
    Element *element = [[Element alloc] initWithName:elementName andID:ID];
    element.frame = CGRectMake(pt.x, pt.y, 64, 64);
    [element setDelegate:self];
    if([element isValid])
        [self.boardView addSubview:element];
    [initiatedElements setObject:element forKey:ID];
    return element;

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
    [initiatedElements removeObjectForKey:deleteID];
    [deleteElement removeFromSuperview];
}

- (void)elementWasMovedWithName:(NSString *)name andID:(NSString *)ID touch:(NSSet *)touches andEvent:(UIEvent *)event {
    Element *tempElement = [initiatedElements objectForKey:ID];

    
    CGPoint pt = [[touches anyObject] locationInView:tempElement];
    CGRect frame = [tempElement frame];
    frame.origin.x += pt.x - tempElement.startPosition.x;
    frame.origin.y += pt.y - tempElement.startPosition.y;
    if(frame.origin.x >= 0 && frame.origin.x+64 <= boardView.frame.size.width){
        tempElement.frame = CGRectMake(frame.origin.x, tempElement.frame.origin.y, tempElement.frame.size.width, tempElement.frame.size.height);
    }
    
    if(frame.origin.y >= 0 && frame.origin.y+64 <= boardView.frame.size.height){
        tempElement.frame = CGRectMake(tempElement.frame.origin.x, frame.origin.y, tempElement.frame.size.width, tempElement.frame.size.height);
    }
//    if(frame.origin.x >= 0 && frame.origin.y >= 0 && frame.origin.x+64 <= boardView.frame.size.width && frame.origin.y+64 <= boardView.frame.size.height){
//        tempElement.frame = frame;
//        
//    }
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
                    [initiatedElements removeObjectForKey:endedElement.elementID];
                    [initiatedElements removeObjectForKey:tempElement.elementID];
                    
                    CGRect combinedPoint = tempElement.frame;
                    [endedElement removeFromSuperview];
                    [tempElement removeFromSuperview];
                    [endedElement release];
                    [tempElement release];
                    
                    Element *combinedElement = [self boardAddElement:doubleFromDict];
                    combinedElement.frame = combinedPoint;
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
                        NSMutableArray *tempArray = [allUnlocked objectForKey:tempCat];
                        if(tempArray == nil){
                            tempArray = [[NSMutableArray alloc] init];
                        }
                        if([tempArray containsObject:combinedElement] == FALSE){
                            [tempArray addObject:[combinedElement elementName]];
                        }
                        [allUnlocked setObject:tempArray forKey:tempCat];
                    }
                    
                    break;
                }
            }
        }
    }
}

- (IBAction)addButtonPushed:(id)sender {
    ElementSelectionView *chooseElementView = [[ElementSelectionView alloc] 
                                               initWithNibName:[[NSBundle mainBundle] pathForResource:@"ElementSelectionView" ofType:@"xib"] 
                                               bundle:nil];
    [chooseElementView giveUnlockedElements:allUnlocked andCats:unlockedCategories];
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
        if([touch tapCount] == 2){
            CGPoint pt = [touch locationInView:boardView];
            [self boardAddElement:@"Water" atPoint:CGPointMake(pt.x - 32 , pt.y - 96)];
            [self boardAddElement:@"Fire" atPoint:CGPointMake(pt.x - 32 , pt.y + 32)];
            [self boardAddElement:@"Air" atPoint:CGPointMake(pt.x - 96 , pt.y - 32)];
            [self boardAddElement:@"Earth" atPoint:CGPointMake(pt.x + 32 , pt.y - 32)];
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
    [boardView release];
    
    [addButton release];
    [infoForElement release];
    [removeButton release];
    
    [deleteElement release];
    
    [deleteID release];
    
    [initiatedElements release];
    
    [doubleElementCombos release];
    [elementsForCategory release];
    
    [unlockedElements release];
    [unlockedCategories release];
    [allUnlocked release];
    
    [selectedElement release];
    [super dealloc];
}

@end
