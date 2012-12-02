//
//  ACEModes.h
//  ACEView
//
//  Created by Michael Robinson on 2/12/12.
//  Copyright (c) 2012 Code of Interest. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    ACEViewModeASCIIDoc = 0,
    ACEViewModeC9Search,
    ACEViewModeCPP,
    ACEViewModeClojure,
    ACEViewModeCoffee,
    ACEViewModeColdfusion,
    ACEViewModeCSharp,
    ACEViewModeCSS,
    ACEViewModeDiff,
    ACEViewModeGLSL,
    ACEViewModeGolang,
    ACEViewModeGroovy,
    ACEViewModeHaxe,
    ACEViewModeHTML,
    ACEViewModeJade,
    ACEViewModeJava,
    ACEViewModeJavaScript,
    ACEViewModeJSON,
    ACEViewModeJSP,
    ACEViewModeJSX,
    ACEViewModeLatex,
    ACEViewModeLESS,
    ACEViewModeLiquid,
    ACEViewModeLua,
    ACEViewModeLuapage,
    ACEViewModeMarkdown,
    ACEViewModeOcaml,
    ACEViewModePerl,
    ACEViewModePGSQL,
    ACEViewModePHP,
    ACEViewModePowershell,
    ACEViewModePython,
    ACEViewModeRuby,
    ACEViewModeScad,
    ACEViewModeScala,
    ACEViewModeSCSS,
    ACEViewModeSH,
    ACEViewModeSQL,
    ACEViewModeSVG,
    ACEViewModeTCL,
    ACEViewModeText,
    ACEViewModeTextile,
    ACEViewModeTypescript,
    ACEViewModeXML,
    ACEViewModeXQuery,
    ACEViewModeYAML,
    
    ACEViewModeCount,  // keep track of the enum size automatically
} ACEViewMode;

@interface ACEModes : NSObject

@end
