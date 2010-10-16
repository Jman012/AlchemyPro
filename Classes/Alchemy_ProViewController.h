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
    
    BOOL                    firstElementComboTaken;
    BOOL                    secondElementComboTaken;
    BOOL                    thirdElementComboTaken;
    
    NSMutableDictionary     *initiatedElements;
    NSMutableDictionary     *sideBarElements;
    
    NSDictionary            *doubleElementCombos;
    NSDictionary            *tripleElementCombos;
}

@property (nonatomic, retain) NSArray               *catList;
@property (nonatomic, retain) IBOutlet UIView       *boardView;
@property (nonatomic, retain) IBOutlet UIButton     *comboButton;

@property (nonatomic)   BOOL                        firstElementComboTaken;
@property (nonatomic)   BOOL                        secondElementComboTaken;
@property (nonatomic)   BOOL                        thirdElementComboTaken;

@property (nonatomic, retain) NSMutableDictionary   *initiatedElements;
@property (nonatomic, retain) NSMutableDictionary   *sideBarElements;

@property (nonatomic, retain) NSDictionary          *doubleElementCombos;
@property (nonatomic, retain) NSDictionary          *tripleElementCombos;

- (void)boardAddElement:(NSString *)element;
- (void)comboButtonPressed:(id)sender;

@end
