/* cocos2d for iPhone
 *
 * http://www.cocos2d-iphone.org
 *
 * Copyright (C) 2008,2009 Ricardo Quesada
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the 'cocos2d for iPhone' license.
 *
 * You will find a copy of this license within the cocos2d for iPhone
 * distribution inside the "LICENSE" file.
 *
 */


#import "CCScene.h"
#import "CCDirector.h"
#import "Support/CGPointExtension.h"

@implementation CCScene
-(id) init
{
	if( (self=[super init]) ) {
		CGSize s = [[CCDirector sharedDirector] winSize];
		self.relativeAnchorPoint = NO;
		anchorPoint_ = ccp(0.5f, 0.5f);
		[self setContentSize:s];	
	}
	
	return self;
}
@end
