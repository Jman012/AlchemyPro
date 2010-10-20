//
//  Alchemy_ProViewController.h
//  Alchemy Pro
//
//  Created by James Linnell on 9/25/10.
//  Copyright (c) 2010 PDHS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Element.h"

//@class Element;

@interface Alchemy_ProViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, ElementDelegate>{
    NSArray                 *catList;
    IBOutlet UIView         *boardView;
    IBOutlet UIButton       *comboButton;
    
    IBOutlet UIView         *sideBarView;
    IBOutlet UIImageView    *firstComboImageView;
    IBOutlet UIImageView    *secondComboImageView;
    
    Element                 *firstElement;
    Element                 *secondElement;
    Element                 *tempComboElement;
    
    BOOL                    firstElementComboTaken;
    BOOL                    secondElementComboTaken;
    
    NSMutableDictionary     *initiatedElements;
    NSMutableDictionary     *sideBarElements;
    
    NSDictionary            *doubleElementCombos;
    NSDictionary            *tripleElementCombos;
}

@property (nonatomic, retain) NSArray               *catList;
@property (nonatomic, retain) IBOutlet UIView       *boardView;
@property (nonatomic, retain) IBOutlet UIButton     *comboButton;

@property (nonatomic, retain) IBOutlet UIView       *sideBarView;
@property (nonatomic, retain) IBOutlet UIImageView  *firstComboImageView;
@property (nonatomic, retain) IBOutlet UIImageView  *secondComboImageView;

@property (nonatomic, retain) Element               *firstElement;
@property (nonatomic, retain) Element               *secondElement;
@property (nonatomic, retain) Element               *tempComboElement;

@property (nonatomic)   BOOL                        firstElementComboTaken;
@property (nonatomic)   BOOL                        secondElementComboTaken;

@property (nonatomic, retain) NSMutableDictionary   *initiatedElements;
@property (nonatomic, retain) NSMutableDictionary   *sideBarElements;

@property (nonatomic, retain) NSDictionary          *doubleElementCombos;



- (void)boardAddElement:(NSString *)element;
- (void)comboButtonPressed:(id)sender;

@end
