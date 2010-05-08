//
//  Bullet.h
//  Cocos2DProject
//
//  Created by Sei Hyung Lee on 10. 4. 26..
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "HelloWorldScene.h"


@interface CCBullet : CCSprite 
{
	CCTower *tower;
	CCMonster *monster;
	
	CGPoint pos;
	CGPoint startPos;
	CGPoint endPos;
	
	float moveSpeed; // in pixels/sec
}

+(void) spawn:(CCTower*)tower monster:(CCMonster*)monster;

-(void) moveFinished:(ccTime)dt;

@end
