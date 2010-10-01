//
//  Element.h
//
//  Created by Alexander Nabavi-Noori on 9/27/10.
//  Copyright 2010 Alexander Nabavi-Noori. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Element;

@protocol ElementDelegate <NSObject>
@required
- (void)elementWasTouchedWithName:(NSString *)name andID:(int)ID;
@end

@interface Element : UIView {
	NSString                *elementName;
	int                     elementID;
	id                      <ElementDelegate> delegate;
    CGPoint                 startPosition;

    IBOutlet UIView         *boardView;
    IBOutlet UIImageView    *firstElementCombo;
    IBOutlet UIImageView    *secondElementCombo;
    IBOutlet UIImageView    *thirdElementCombo;
    IBOutlet UIButton       *elementComboButton;
}

@property (nonatomic, retain)   NSString            *elementName;
@property (nonatomic)           int                 elementID;
@property (nonatomic, retain)   id                  <ElementDelegate> delegate;


@property (nonatomic, retain) IBOutlet UIView       *boardView;
@property (nonatomic, retain) IBOutlet UIImageView  *firstElementCombo;
@property (nonatomic, retain) IBOutlet UIImageView  *secondElementCombo;
@property (nonatomic, retain) IBOutlet UIImageView  *thirdElementCombo;
@property (nonatomic, retain) IBOutlet UIButton     *elementComboButton;
@property (nonatomic, retain) IBOutlet UIView       *comboBarView;


- (void)setDelegate:(id <ElementDelegate>)dlg;
- (void)loadVisualViews;

@end
