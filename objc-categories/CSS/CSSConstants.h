//
//  CSSConstants.h
//  Grid
//
//  Created by Mo Bitar on 4/30/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#ifndef Grid_CSSConstants_h
#define Grid_CSSConstants_h

typedef NS_ENUM(NSInteger, CSSPropertyType) {
    CSSBackgroundColor,
    CSSVerticalAlignment,  
    CSSOpacity,
    CSSImage,
    // a dictionary of CSSTextAttributes
    CSSTextAttributes,
    // an array of CSSRelationships
    CSSRelationships,
};

typedef NS_ENUM(NSInteger, CSSTextAttribute) {
    CSSText,
    CSSTextFont,
    CSSTextColor,
    CSSTextAlignment,
    CSSTextNumberOfLines,
    CSSTextShadowColor,
    CSSTextShadowOffset,
    CSSTextShadowBlurRadius,
    CSSTextLetterSpacing
};

#endif
