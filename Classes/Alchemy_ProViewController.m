//
//  Alchemy_ProViewController.m
//  Alchemy Pro
//
//  Created by James Linnell on 9/25/10.
//  Copyright (c) 2010 PDHS. All rights reserved.
//

#import "Alchemy_ProViewController.h"

@implementation Alchemy_ProViewController
@synthesize catList, boardView;
@synthesize firstElementComboTaken, secondElementComboTaken, thirdElementComboTaken;



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
    
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    catList = [settings objectForKey:@"AlchemyCategoryList"];
    if(catList == nil){
        NSLog(@"Is nil");
        catList = [[NSArray alloc] initWithObjects:@"Water", @"Fire", @"Air", @"Earth", @"Blank", nil]; 
    }
    [settings release];
    firstElementComboTaken = NO;
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
    NSLog(@"Add: %@", elementName);
    Element *element = [[Element alloc] init];
    element.frame = CGRectMake(32, 32, 64, 64);
    element.elementName = elementName;
    [element loadVisualViews];
    [self.boardView addSubview:element];
    [element release];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row < 4){
        [self boardAddElement:[catList objectAtIndex:indexPath.row]];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)elementWasTouchedWithName:(NSString *)name andID:(int)ID {
    NSLog(@"Element Touched");
    NSLog(@"%@, %i", name, ID);
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    if([touch view] == boardView){
        NSLog(@"Touched %@", [touch view]);
    }
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
    [catList release];
    [super dealloc];
}

@end
