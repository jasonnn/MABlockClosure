//
//  test_api.h
//  MABlockClosureFramework
//
//  Created by Jason Markham on 11/15/14.
//  Copyright (c) 2014 Jason Markham. All rights reserved.
//

#ifndef __MABlockClosureFramework__test_api__
#define __MABlockClosureFramework__test_api__


typedef int (*simpleCallback)(void);

int test_simpleCallback(simpleCallback);


typedef void *UserData;
typedef void *ProvidedToCallback;
typedef int (*MoreRealisticCallback)(UserData,ProvidedToCallback,void *reserved);

int test_moreRealistic(MoreRealisticCallback,UserData);

#endif /* defined(__MABlockClosureFramework__test_api__) */
