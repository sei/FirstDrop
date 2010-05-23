//
//  gameui.h
//  Cocos2DProject
//
//  Created by 현철 박 on 10. 5. 14..
//  Copyright 2010 우리집. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "touchable.h"
#import "HelloWorldScene.h"


@interface CGameUI : CTouchable {
	int posX;
	int posY;
	
	int index; // 아이콘 종류 한꺼번에 묶어야 함.
}

+(void) spawn:(NSString*)filename withPosition:(CGPoint)coordinate;



@end

