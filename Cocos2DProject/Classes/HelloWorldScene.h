

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Monster.h"
#import "Tower.h"
#import "drag.h"
#import "gameui.h"

#define TILE_PATH_GID			39
#define TILE_START_POINT_GID	134
#define TILE_END_POINT_GID		151

#define START_POINT_COORDINATE	ccp(0, 1)

#define CELL_SIZE				32

#define CELL_COUNT_X			15
#define CELL_COUNT_Y			10

#define PI						3.14159265358979

@class CCMonster;
@class CCTower;

// HelloWorld Layer
@interface HelloWorld : CCLayer
{
	CCTMXTiledMap *tileMap;
	
	NSMutableArray *coordinatePath;

	NSMutableArray *monsters;
	
	NSMutableArray *touchables;
	
	CDrag* m_drag;
	
	int m_selectedUI;

}

// returns a Scene that contains the HelloWorld as the only child
+(id) scene;

-(void) setSelectedUI:(int)index;
-(int) getSelectedUI;
//+(void) setTower()

-(void) addMonster:(CCMonster*)monster;
-(void) removeMonster:(CCMonster*)monster;
-(NSMutableArray*) getMonsters;

-(void) setDrag:(CDrag*)drag;
-(void) setDragOn:(bool)flag;


-(void) spawnTower:(CGPoint) location;

-(void) addTouchable:(CTouchable*)touchable;
-(void) removeTouchable:(CTouchable*)touchable;
-(NSMutableArray*) getTouchable;

//NSMutableArray *touchables;

-(void) buildCoordinatePath;
-(NSMutableArray*) getCoordinatePath;

+(CGPoint) findNextCell:(CGPoint)coordinate prevCoordinate:(CGPoint)prevCoordinat;

+(bool) isPath:(CGPoint)tileCoordinate;
+(bool) isEndPoint:(CGPoint)tileCoordinate;
+(bool) isInsideBoundary:(CGPoint)tlleCoordinate;

+(CGPoint) getCellCoordinateAtIndex:(int)cellIndex;
+(int) getTileGidAtIndex:(int)cellIndex;
+(bool) isEndPointAtIndex:(int)cellIndex;

@end

extern HelloWorld *gLayer; 
extern CCTMXLayer *gTileMapLayer;
extern int mapTowers[CELL_COUNT_X][CELL_COUNT_Y];

