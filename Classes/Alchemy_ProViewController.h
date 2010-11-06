//
//  Alchemy_ProViewController.h
//  Alchemy Pro
//
//  Created by James Linnell on 9/25/10.
//  Copyright (c) 2010 PDHS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Element.h"
#import "SpecificCategoryViewController.h"
#import "ElementSelectionView.h"


@interface Alchemy_ProViewController : UIViewController 
<UITableViewDelegate, UITableViewDataSource, ElementDelegate, SpecificCategoryViewControllerDelegate, ElementSelectionViewDelegate>
{
    NSMutableArray          *catList;
    IBOutlet UIView         *boardView;
    IBOutlet UIButton       *comboButton;
    
    IBOutlet UIView         *sideBarView;
    IBOutlet UIImageView    *firstComboImageView;
    IBOutlet UIImageView    *secondComboImageView;
    IBOutlet UITableView    *catTableView;
    
    IBOutlet UIBarButtonItem *addButton;
    IBOutlet UIBarButtonItem *infoForElement;
    IBOutlet UIBarButtonItem *removeButton;
    
    Element                 *firstElement;
    Element                 *secondElement;
    Element                 *tempComboElement;
    Element                 *deleteElement;
    
    NSString                *deleteID;
    
    BOOL                    firstElementComboTaken;
    BOOL                    secondElementComboTaken;
    
    NSMutableDictionary     *initiatedElements;
    NSMutableDictionary     *sideBarElements;
    
    NSDictionary            *doubleElementCombos;
    NSDictionary            *elementCategories;
    NSDictionary            *elementsForCategory;
    
    NSString                *chosenElement;
    
    NSMutableArray          *unlockedElements;
    NSMutableArray          *unlockedCategories;
    
    Element                 *selectedElement;
}

@property (nonatomic, retain) NSMutableArray        *catList;
@property (nonatomic, retain) IBOutlet UIView       *boardView;
@property (nonatomic, retain) IBOutlet UIButton     *comboButton;

@property (nonatomic, retain) IBOutlet UIView       *sideBarView;
@property (nonatomic, retain) IBOutlet UIImageView  *firstComboImageView;
@property (nonatomic, retain) IBOutlet UIImageView  *secondComboImageView;
@property (nonatomic, retain) IBOutlet UITableView  *catTableView;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *addButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *infoForElement;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *removeButton;

@property (nonatomic, retain) Element               *firstElement;
@property (nonatomic, retain) Element               *secondElement;
@property (nonatomic, retain) Element               *tempComboElement;
@property (nonatomic, retain) Element               *deleteElement;

@property (nonatomic, retain) NSString              *deleteID;

@property (nonatomic)   BOOL                        firstElementComboTaken;
@property (nonatomic)   BOOL                        secondElementComboTaken;

@property (nonatomic, retain) NSMutableDictionary   *initiatedElements;
@property (nonatomic, retain) NSMutableDictionary   *sideBarElements;

@property (nonatomic, retain) NSDictionary          *doubleElementCombos;
@property (nonatomic, retain) NSDictionary          *elementCategories;
@property (nonatomic, retain) NSDictionary          *elementsForCategory;

@property (nonatomic, retain) NSMutableArray        *unlockedElements;
@property (nonatomic, retain) NSMutableArray        *unlockedCategories;

@property (nonatomic, retain) Element               *selectedElement;



- (Element *)boardAddElement:(NSString *)element;
- (void)comboButtonPressed:(id)sender;
- (void)comboAnimDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;
- (void)deleteAnimDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;
- (IBAction)addButtonPushed:(id)sender;
- (IBAction)infoForElementButtonPushed:(id)sender;
- (IBAction)removeButtonPushed:(id)sender;

@end
