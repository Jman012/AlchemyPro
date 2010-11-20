//
//  ElementSelectionView.h
//  Alchemy Pro
//
//  Created by James Linnell on 10/30/10.
//  Copyright (c) 2010 PDHS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Element.h"

@protocol ElementSelectionViewDelegate <NSObject>
@optional
- (void)acceptElementsToAdd:(NSArray *)toBeAddedElements;
@end
    

@interface ElementSelectionView : UIViewController <UIScrollViewDelegate, ElementDelegate> {
    id <ElementSelectionViewDelegate> delegate;
    
    IBOutlet UILabel            *titleLabel;
    IBOutlet UIToolbar          *toolbar;
    IBOutlet UIBarButtonItem    *backAndDoneButton;
    IBOutlet UIScrollView       *mainScrollView;
    IBOutlet UIPageControl      *pageControl;
    IBOutlet UIBarButtonItem    *selectButton;
    
    NSArray                     *unlockedElements;
    NSArray                     *unlockedCategories;
    NSMutableDictionary         *unlockedEverything;
    
    NSMutableDictionary         *drawnElements;
    
    BOOL                        pageChangeByControl;
}

@property (nonatomic, retain) IBOutlet UILabel          *titleLabel;
@property (nonatomic, retain) IBOutlet UIToolbar        *toolbar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem  *backAndDoneButton;
@property (nonatomic, retain) IBOutlet UIScrollView     *mainScrollView;
@property (nonatomic, retain) IBOutlet UIPageControl    *pageControl;
@property (nonatomic, retain) IBOutlet UIBarButtonItem  *selectButton;

@property (nonatomic, retain) NSArray                   *unlockedElements;
@property (nonatomic, retain) NSArray                   *unlockedCategories;
@property (nonatomic, retain) NSMutableDictionary       *unlockedEverything;

@property (nonatomic, retain) NSMutableDictionary       *drawnElements;

- (void)setDelegate:(id <ElementSelectionViewDelegate>)dlg;
- (IBAction)backDoneButtonPushed:(id)sender;
- (IBAction)requestPageChange:(id)sender;
- (IBAction)selectAllPushed:(id)sender;
- (void)giveUnlockedElements:(NSMutableDictionary *)givenUnlocked andCats:(NSArray *)givenCats;
- (void)addElement:(NSString *)name toView:(UIScrollView *)view atPoint:(CGPoint)point;

@end
