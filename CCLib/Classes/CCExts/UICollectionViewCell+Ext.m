//
//  UICollectionViewCell+Ext.m
//  Lion
//
//  Created by Du on 2019/5/21.
//  Copyright © 2019 LiuHeYuanJiao. All rights reserved.
//

#import "UICollectionViewCell+Ext.h"


@implementation UICollectionViewCell (Ext)


+(instancetype)create:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath identifier:(NSString*)identifier{
    
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];

    return cell;
}

+(NSString*)identifier{
    
    return [NSString stringWithFormat:@"%@Identifier",NSStringFromClass(self)];
}




@end
