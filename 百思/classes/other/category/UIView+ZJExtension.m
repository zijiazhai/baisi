//
//  UIView+ZJExtension.m
//  百思
//
//  Created by zijia on 2/26/.
//  Copyright (c) 2016 zijia. All rights reserved.
//

#import "UIView+ZJExtension.h"

@implementation UIView (ZJExtension)

//**************** BE CAREFUL



/**
 *  self.messageView.frame.size.height = self.messageView.frame.size.height it is ********* WRONG *********
 *  
    This is right
    CGRect temp = self.messageView.frame;
        temp.size.height = temp.size.height + notesHeight;
        self.messageView.frame = temp;
 *      You are able to assign the frame, but not the fields of frame
 */




- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (void)setCenterX:(CGFloat )centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
- (void)setCenterY:(CGFloat )centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (CGSize)size
{
    return self.frame.size;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}


@end
