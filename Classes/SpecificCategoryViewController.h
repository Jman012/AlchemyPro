//
//  SpecificCategoryViewController.h
//  Alchemy Pro
//
//  Created by James Linnell on 10/23/10.
//  Copyright (c) 2010 PDHS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SpecificCategoryViewControllerDelegate <NSObject>
@required
- (void)passChosenElement:(NSString *)chosenElementName;
@end
    

@interface SpecificCategoryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    id                          <SpecificCategoryViewControllerDelegate> delegate;
    
    IBOutlet UIBarButtonItem    *backButton;
    IBOutlet UIToolbar          *toolbar;
    IBOutlet UITableView        *mainTableView;
    IBOutlet UILabel            *titleLabel;
    
    NSString                    *category;
    
    NSDictionary                *elementCategories;
    NSArray                     *elementsInCategory;
    NSArray                     *unlockedElementsToShow;
}

@property (nonatomic, retain) IBOutlet UIBarButtonItem  *backButton;
@property (nonatomic, retain) IBOutlet UIToolbar        *toolbar;
@property (nonatomic, retain) IBOutlet UITableView      *mainTableView;
@property (nonatomic, retain) IBOutlet UILabel          *titleLabel;

@property (nonatomic, retain) NSString                  *category;

@property (nonatomic, retain) NSDictionary              *elementCategories;
@property (nonatomic, retain) NSArray                   *elementsInCategory;
@property (nonatomic, retain) NSArray                   *unlockedElementsToShow;


- (void)setDelegate:(id <SpecificCategoryViewControllerDelegate>)dlg;
- (IBAction)backButtonPressed:(id)sender;
- (void)giveCategory:(NSString *)categoryName;
- (void)giveElementsInCategory:(NSArray *)arrayWithElements;
- (void)giveUnlockedElementsForCategory:(NSArray *)unlocked;

@end
