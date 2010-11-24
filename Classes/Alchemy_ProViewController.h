//
//  Alchemy_ProViewController.h
//  Alchemy Pro
//
//  Created by James Linnell on 9/25/10.
//  Copyright (c) 2010 PDHS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Element.h"
#import "ElementSelectionView.h"
#import "SettingsView.h"


@interface Alchemy_ProViewController : UIViewController <ElementDelegate, ElementSelectionViewDelegate, SettingsViewDelegate>
{
    IBOutlet UIView         *boardView;
        
    IBOutlet UIBarButtonItem *addButton;
    IBOutlet UIBarButtonItem *infoForElement;
    IBOutlet UIBarButtonItem *removeButton;
    
    Element                 *deleteElement;
    
    NSString                *deleteID;
    
    NSMutableDictionary     *initiatedElements;
    
    NSDictionary            *doubleElementCombos;
    NSDictionary            *elementsForCategory;
        
    NSMutableArray          *unlockedElements;
    NSMutableArray          *unlockedCategories;
    NSMutableDictionary     *allUnlocked;
    
    Element                 *selectedElement;
    
    NSUserDefaults          *settings;
}

@property (nonatomic, retain) IBOutlet UIView       *boardView;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *addButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *infoForElement;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *removeButton;

@property (nonatomic, retain) Element               *deleteElement;

@property (nonatomic, retain) NSString              *deleteID;

@property (nonatomic, retain) NSMutableDictionary   *initiatedElements;

@property (nonatomic, retain) NSDictionary          *doubleElementCombos;
@property (nonatomic, retain) NSDictionary          *elementsForCategory;

@property (nonatomic, retain) NSMutableArray        *unlockedElements;
@property (nonatomic, retain) NSMutableArray        *unlockedCategories;
@property (nonatomic, retain) NSMutableDictionary   *allUnlocked;

@property (nonatomic, retain) Element               *selectedElement;



- (Element *)boardAddElement:(NSString *)element;
- (Element *)boardAddElement:(NSString *)element atPoint:(CGPoint)pt;
- (void)deleteAnimDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;
- (IBAction)addButtonPushed:(id)sender;
- (IBAction)infoForElementButtonPushed:(id)sender;
- (IBAction)removeButtonPushed:(id)sender;

@end
