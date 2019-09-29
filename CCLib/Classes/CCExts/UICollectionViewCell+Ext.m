//
//  UICollectionViewCell+Ext.m
//  Lion
//
//  Created by Du on 2019/5/21.
//  Copyright © 2019 LiuHeYuanJiao. All rights reserved.
//

#import "UICollectionViewCell+Ext.h"

static id cell;
static id identifier;

@implementation UICollectionViewCell (Ext)

+(instancetype)create:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath identifier:(NSString*)identifier{
    
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];

    return cell;
}


+(instancetype )loadNib{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cell=[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
    });
    return cell;
}
+(instancetype )loadNibNormal{
   id cell=[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
    return cell;
}

+(NSString*)identifier{
    
    return [NSString stringWithFormat:@"%@Identifier",NSStringFromClass(self)];
}




@end
