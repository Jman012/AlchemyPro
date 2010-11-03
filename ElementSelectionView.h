//
//  ElementSelectionView.h
//  Alchemy Pro
//
//  Created by James Linnell on 10/30/10.
//  Copyright (c) 2010 PDHS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Element.h"


@interface ElementSelectionView : UIViewController <UIScrollViewDelegate, ElementDelegate> {
    IBOutlet UILabel            *titleLabel;
    IBOutlet UIToolbar          *toolbar;
    IBOutlet UIBarButtonItem    *backAndDoneButton;
    IBOutlet UIScrollView       *mainScrollView;
    IBOutlet UIPageControl      *pageControl;
    
    NSArray                     *unlockedElements;
    NSArray                     *unlockedCategories;
}

@property (nonatomic, retain) IBOutlet UILabel          *titleLabel;
@property (nonatomic, retain) IBOutlet UIToolbar        *toolbar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem  *backAndDoneButton;
@property (nonatomic, retain) IBOutlet UIScrollView     *mainScrollView;
@property (nonatomic, retain) IBOutlet UIPageControl    *pageControl;

@property (nonatomic, retain) IBOutlet NSArray          *unlockedElements;
@property (nonatomic, retain) IBOutlet NSArray          *unlockedCategories;

- (IBAction)backDoneButtonPushed:(id)sender;
- (IBAction)requestPageChange:(id)sender;
- (void)giveUnlockedElements:(NSArray *)givenElements withCategories:(NSArray *)givenCategories;

@end
