//
//  test_api.c
//  MABlockClosureFramework
//
//  Created by Jason Markham on 11/15/14.
//  Copyright (c) 2014 Jason Markham. All rights reserved.
//

#include "test_api.h"

int test_simpleCallback(simpleCallback callback){
    return callback();
}

int test_moreRealistic(MoreRealisticCallback callback,UserData userdata){
    return callback(userdata,"someString",0);
}


