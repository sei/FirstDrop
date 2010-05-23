//
//  drag.h
//  Cocos2DProject
//
//  Created by 현철 박 on 10. 5. 12..
//  Copyright 2010 우리집. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "touchable.h"


@interface CDrag : CTouchable {
	bool checkable;
}

+(void) spawn:(NSString*)filename;
-(void) setCheckable:(bool)flag;
@end
