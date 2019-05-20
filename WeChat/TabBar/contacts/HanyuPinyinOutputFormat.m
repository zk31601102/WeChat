//
//  HanyuPinyinOutputFormat.m
//  WeChat-ZK
//
//  Created by DrogoKhal on 2019/5/18.
//  Copyright © 2019 DrogoKhal. All rights reserved.
//

#import "HanyuPinyinOutputFormat.h"

@implementation HanyuPinyinOutputFormat
@synthesize vCharType=_vCharType;
@synthesize caseType=_caseType;
@synthesize toneType=_toneType;

- (id)init {
    if (self = [super init]) {
        [self restoreDefault];
    }
    return self;
}

- (void)restoreDefault {
    _vCharType = VCharTypeWithUAndColon;
    _caseType = CaseTypeLowercase;
    _toneType = ToneTypeWithToneNumber;
}

@end
