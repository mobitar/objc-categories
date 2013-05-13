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
    CSSRelationships,
    CSSSuperview,
    
    // default is NO,
    CSSHasDefaultConstraints,
    
    CSSImage,
    CSSWhichSubview,
    
    // the conditions required to apply the dictionary of attributes
    CSSApplyConditionals, 
    
    // a dictionary of CSSTextAttributes
    CSSTextAttributes,
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
