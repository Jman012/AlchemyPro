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
@synthesize unlockedElements, unlockedCategories, drawnElements;


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
        [titleLabel setShadowColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
        [titleLabel setShadowOffset:CGSizeMake(0, -1.0)];
        [titleLabel setFont:[UIFont boldSystemFontOfSize:22.0]];
        
        pageChangeByControl = NO;
    }
    return self;
}

- (void)setDelegate:(id<ElementSelectionViewDelegate>)dlg {
    delegate = dlg;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    drawnElements = [[NSMutableDictionary alloc] init];
    [mainScrollView setDelegate:self];

    pageControl.numberOfPages = 4;
    pageControl.currentPage = 0;
    
    [mainScrollView setContentSize:CGSizeMake(mainScrollView.frame.size.width * pageControl.numberOfPages, mainScrollView.frame.size.height)];
    for(int page = 0; page <= [pageControl numberOfPages]; page++){
        UIScrollView *tempScrollView = [[UIScrollView alloc] init];
        if(page == 1){
            //Just the four starting Elements
            
            [tempScrollView setFrame:CGRectMake(0, 0, mainScrollView.frame.size.width, mainScrollView.frame.size.height)];
            [tempScrollView setContentSize:CGSizeMake(mainScrollView.frame.size.width, mainScrollView.frame.size.height)];
            
            [self addElement:@"Water" toView:tempScrollView atPoint:CGPointMake(tempScrollView.frame.size.width * 0.25 - 32, tempScrollView.frame.size.height * 0.25 - 32)];
            [self addElement:@"Fire" toView:tempScrollView atPoint:CGPointMake(tempScrollView.frame.size.width * 0.75 - 32, tempScrollView.frame.size.height * 0.25 - 32)];
            [self addElement:@"Air" toView:tempScrollView atPoint:CGPointMake(tempScrollView.frame.size.width * 0.25 - 32, tempScrollView.frame.size.height * 0.75 - 32)];
            [self addElement:@"Earth" toView:tempScrollView atPoint:CGPointMake(tempScrollView.frame.size.width * 0.75 - 32, tempScrollView.frame.size.height * 0.75 - 32)];
        }
        [mainScrollView addSubview:tempScrollView];
        [tempScrollView release];
    }
    [super viewDidLoad];
}

- (void)addElement:(NSString *)name toView:(UIScrollView *)view atPoint:(CGPoint)point {
    NSTimeInterval epochTime = [[NSDate date] timeIntervalSince1970];
    NSString *ID = [[NSString alloc] initWithFormat:@"%u", epochTime];
        
    Element *element = [[Element alloc] initWithName:name andID:ID];
    element.frame = CGRectMake(point.x, point.y, 64, 64);
    [element setDelegate:self];
    if([element isValid])
        [view addSubview:element];
    [drawnElements setObject:element forKey:ID];
    [element release];
}

-(void)elementWasTouchedWithName:(NSString *)name andID:(NSString *)ID touch:(NSSet *)touches andEvent:(UIEvent *)event {
    Element *touchedElement = [drawnElements objectForKey:ID];
    [touchedElement setSelected:![touchedElement isSelected]];
    BOOL changeBackButton = NO;
    for(Element *tempElement in [drawnElements allValues]){
        if([tempElement isSelected] == YES){
            changeBackButton = YES;
            break;
        }
    }
    if(changeBackButton == YES){
        [backAndDoneButton setStyle:UIBarButtonItemStyleDone];
        [backAndDoneButton setTitle:@"Add"];
    }
    else {
        [backAndDoneButton setStyle:UIBarButtonItemStyleBordered];
        [backAndDoneButton setTitle:@"Back"];
    }
//    [touchedElement release];
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
    if(backAndDoneButton.style == UIBarButtonItemStyleBordered){
        [[self parentViewController] dismissModalViewControllerAnimated:YES];
    }
    else if(backAndDoneButton.style == UIBarButtonItemStyleDone){
        NSArray *selectedElements;
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        for(Element *tempElement in [drawnElements allValues]){
            if([tempElement isSelected] == YES){
                [tempArray addObject:tempElement];
            }
        }
        selectedElements = [[NSArray alloc] initWithArray:(NSArray *)tempArray];
        [delegate acceptElementsToAdd:selectedElements];
        [[self parentViewController] dismissModalViewControllerAnimated:YES];
    }
}

- (IBAction)requestPageChange:(id)sender {
    CGRect frame = mainScrollView.frame;
    frame.origin.x = frame.size.width * pageControl.currentPage;
    frame.origin.y = 0;
    
    [mainScrollView scrollRectToVisible:frame animated:YES];
    
    pageChangeByControl = YES;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    pageChangeByControl = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(pageChangeByControl == YES){
        return;
    }
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = ((scrollView.contentOffset.x - pageWidth / 2) /  pageWidth) + 1;
    pageControl.currentPage = page;
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
