//
//  Monster.h
//  Cocos2DProject
//
//  Created by Sei Hyung Lee on 10. 4. 23..
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "HelloWorldScene.h"

#define MONSTER_TICK_TIME 0.3f


@interface CCMonster : CCSprite 
{
	int cellIndex;
	float speed; // in pixels/sec
}

+(void) spawn;
//-(void) despawn:(ccTime)dt;
-(void) despawn;

-(void) moveToNextCell:(ccTime)dt;

-(int) getCellIndex;
-(float) getSpeed;


@end
