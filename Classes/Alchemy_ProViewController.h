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
    IBOutlet                UIView *boardView;
    
    BOOL                    firstElementComboTaken;
    BOOL                    secondElementComboTaken;
    BOOL                    thirdElementComboTaken;
}

@property(nonatomic, retain) NSArray                *catList;
@property(nonatomic, retain) IBOutlet UIView        *boardView;

@property (nonatomic)   BOOL                firstElementComboTaken;
@property (nonatomic)   BOOL                secondElementComboTaken;
@property (nonatomic)   BOOL                thirdElementComboTaken;

- (void)boardAddElement:(NSString *)element;

@end
