//
//  ElementSelectionView.m
//  Alchemy Pro
//
//  Created by James Linnell on 10/30/10.
//  Copyright (c) 2010 PDHS. All rights reserved.
//

#import "ElementSelectionView.h"


@implementation ElementSelectionView

@synthesize titleLabel, toolbar, backAndDoneButton, mainScrollView, pageControl;
@synthesize unlockedElements, unlockedCategories;


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
        [mainScrollView setDelegate:self];
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    
    pageControl.numberOfPages = 4;
    pageControl.currentPage = 0;
    
    [mainScrollView setContentSize:CGSizeMake(mainScrollView.frame.size.width * pageControl.numberOfPages, mainScrollView.frame.size.height)];
    for(int page = 0; page <= [pageControl numberOfPages]; page++){
        UIScrollView *tempScrollView = [[UIScrollView alloc] init];
        if(page == 1){
            //Just the four starting Elements
            
            [tempScrollView setFrame:CGRectMake(0, 0, mainScrollView.frame.size.width, mainScrollView.frame.size.height)];
            [tempScrollView setBackgroundColor:[UIColor grayColor]];
        }
        [mainScrollView addSubview:tempScrollView];
        [tempScrollView release];
    }
    [super viewDidLoad];
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)giveUnlockedElements:(NSArray *)givenElements withCategories:(NSArray *)givenCategories {
    unlockedElements = givenElements;
    unlockedCategories = givenCategories;
    NSLog(@"%@\n%@", unlockedElements, unlockedCategories);
}

- (IBAction)backDoneButtonPushed:(id)sender {
    [[self parentViewController] dismissModalViewControllerAnimated:YES];
}

- (IBAction)requestPageChange:(id)sender {
    
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
    [titleLabel release];
    [toolbar release];
    [backAndDoneButton release];
    [mainScrollView release];
    [pageControl release];
    [super dealloc];
}


@end
