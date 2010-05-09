//
//  touchable.h
//  Cocos2DProject
//
//  Created by 현철 박 on 10. 5. 11..
//  Copyright 2010 우리집. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface CTouchable : CCSprite { //NSObject {
	
}

-(void) TouchesBegan : (NSSet *)touches;
-(void) TouchesMove : (NSSet *)touches;
-(void) TouchesEnd : (NSSet *)touches;

@end
