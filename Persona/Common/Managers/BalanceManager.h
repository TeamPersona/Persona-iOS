//
//  BalanceManager.h
//  Persona
//
//  Created by Denny Kim on 2015-07-25.
//  Copyright (c) 2015 Persona. All rights reserved.
//

#import "JSONManager.h"
#import "BalanceInfo.h"

@interface BalanceManager : JSONManager

+ (BalanceInfo *)parseBalanceInfoFromJSONFile:(NSString *)fileLocation;

@end
