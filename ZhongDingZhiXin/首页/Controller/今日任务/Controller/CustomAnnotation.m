//
//  CustomAnnotation.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/10/28.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "CustomAnnotation.h"

@implementation CustomAnnotation

@synthesize coordinate, title, subtitle;

-(id) initWithCoordinate:(CLLocationCoordinate2D) coords
{
    if (self = [super init]) {
        coordinate = coords;
    }
    return self;
}

@end
