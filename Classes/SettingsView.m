//
//  SettingsView.m
//  Alchemy Pro
//
//  Created by James Linnell on 11/24/10.
//  Copyright 2010 PDHS. All rights reserved.
//

#import "SettingsView.h"


@implementation SettingsView

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

- (void)setDelegate:(id<SettingsViewDelegate>)dlg {
    delegate = dlg;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    settings = [NSUserDefaults standardUserDefaults];
    [super viewDidLoad];
}


- (IBAction)backButtonPushed:(id)sender {
    [[self parentViewController] dismissModalViewControllerAnimated:YES];
}

- (IBAction)clearButtonPushed:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Are You Sure?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Yes" otherButtonTitles:nil];
    [actionSheet showInView:mainView];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"%i", buttonIndex);
    if(buttonIndex == 0){
        //Remove unlocked elements, tell ViewController to refresh
        [settings removeObjectForKey:@"AlchemyUnlockedElements"];
        [settings removeObjectForKey:@"AlchemyUnlockedCategories"];
        [settings removeObjectForKey:@"AlchemyAllUnlocked"];
        NSLog(@"%@", [settings objectForKey:@"AlchemyUnlockedElements"]);
        
        [delegate shouldRefreshChangedSettings];
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [delegate release];
    [mainView release];
    [backButton release];
    [clearProgressButton release];
    [combineMethodSegment release];
    [appearanceSegment release];
    
    [settings release];
    
    [super dealloc];
}


@end
