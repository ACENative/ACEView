//
//  ACEView.h
//  ACEView
//
//  Created by Michael Robinson on 26/08/12.
//  Copyright (c) 2012 Code of Interest. All rights reserved.
//

#import <WebKit/WebKit.h>

#import <ACEView/ACEModes.h>
#import <ACEView/ACEThemes.h>
#import <ACEView/ACEKeyboardHandlers.h>

extern NSString *const ACETextDidEndEditingNotification;

/** The ACEViewDelegate protocol is implemented by objects that wish to monitor the ACEView for content changes. */
#pragma mark - ACEViewDelegate
@protocol ACEViewDelegate <NSObject>

/** Posts a notification that the text has changed and forwards this message to the delegate if it responds.

 @param notification The ACETextDidEndEditingNotification notification that is posted to the default notification center.
 */
- (void) textDidChange:(NSNotification *)notification;

@end

/** This class provides the main public interface for the ACEView. */

#pragma mark - ACEView
@interface ACEView : NSScrollView <NSTextFinderClient> {
    NSTextFinder *textFinder;
    CGColorRef _borderColor;
    WebView *webView;

    id delegate;

    NSRange firstSelectedRange;
}

/**---------------------------------------------------------------------------------------
 * @name Properties
 *  ---------------------------------------------------------------------------------------
 */

/** The ACEView delegate.

 @see ACEViewDelegate
 */
@property(assign) id delegate;

/**
 @see NSTextFinderClient
 */
@property(readonly) NSRange firstSelectedRange;

#pragma mark - ACEView interaction
/**---------------------------------------------------------------------------------------
 * @name Instance Methods
 *  ---------------------------------------------------------------------------------------
 */

/** Retrieve the content of the underlying ACE Editor.

 Uses [editor.getValue()](http://ace.ajax.org/#Editor.getValue).

 @return The ACE Editor content.
 @see setString:
 */
- (NSString *) string;
/** Set the content of the underlying ACE Editor.

 Uses [editor.setValue()](http://ace.ajax.org/#Editor.setValue).

 @see string
 @param string The new content string.
 */
- (void) setString:(NSString *)string;

/** Set the syntax highlighting mode.

 Uses [editor.getSession().setMode()](http://ace.ajax.org/#EditSession.setMode).

 @param mode The mode to set.
 @see ACEMode
 */
- (void) setMode:(ACEMode)mode;
/** Set the theme.

 Uses [editor.getSession().setTheme()](http://ace.ajax.org/#Editor.setTheme).

 @param theme The theme to set.
 @see ACETheme
 */
- (void) setTheme:(ACETheme)theme;

/** Turn wrapping behaviour on or off.

 Specifies whether to use wrapping behaviors or not, i.e. automatically wrapping the selection with characters such as brackets when such a character is typed in.

 Uses [editor.setWrapBehavioursEnabled()](http://ace.ajax.org/#Editor.setWrapBehavioursEnabled).

 @param wrap YES if wrapping behaviours are to be enabled, NO otherwise.
 @see setUseSoftWrap:
 @see setWrapLimitRange:
 */
- (void) setWrappingBehavioursEnabled:(BOOL)wrap;
/** Sets whether or not line wrapping is enabled.

 Define the wrap limit with setWrapLimitRange.

 Uses [editor.getSession().setUseWrapMode()](http://ace.ajax.org/#EditSession.setUseWrapMode).

 @param wrap YES if line wrapping is to be enabled, NO otherwise.
 @see setWrappingBehavioursEnabled:
 @see setWrapLimitRange:
 */
- (void) setUseSoftWrap:(BOOL)wrap;
/**  Sets the boundaries of wrap.

 Uses [editor.getSession().setWrapLimitRange()](http://ace.ajax.org/#EditSession.setWrapLimitRange).

 @param range Range within which lines should be constrained. Typically range.location will be 0.
 @see setWrappingBehavioursEnabled:
 @see setUseSoftWrap:
 */
- (void) setWrapLimitRange:(NSRange)range;
/** Show or hide invisible characters.

 Uses [editor.setShowInvisibles()](http://ace.ajax.org/#Editor.setShowInvisibles).

 @param show YES if inivisible characters are to be shown, NO otherwise.
 */
- (void) setShowInvisibles:(BOOL)show;
/** Set read only mode. Prevents content from being changed interactively.

 Uses [editor.setReadOnly()](http://ace.ajax.org/#Editor.setReadOnly).

 @param readOnly YES if editor should be in read only mode, NO otherwise.
 */
- (void) setReadOnly:(BOOL)readOnly;
/** Show or hide folding widgets.

 Uses [editor.setShowFoldWidgets()](http://ace.ajax.org/#Editor.setShowFoldWidgets).

 @param show YES if folding widgets are to be shown, NO otherwise.
 */
- (void) setShowFoldWidgets:(BOOL)show;
/** Enable fading of folding widgets.

 Uses [editor.setFadeFoldWidgets()](http://ace.ajax.org/#Editor.setFadeFoldWidgets).

 @param fade YES if folding widgets should be faded, NO otherwise.
 */
- (void) setFadeFoldWidgets:(BOOL)fade;
/** Highlight the active line.

 Uses [editor.setHighlightActiveLine()](http://ace.ajax.org/#Editor.setHighlightActiveLine).

 @param highlight YES if the active line should be highlighted, NO otherwise.
 */
- (void) setHighlightActiveLine:(BOOL)highlight;
/** Highlight the gutter line.

 Uses [editor.setHighlightGutterLine()](http://ace.ajax.org/#Editor.setHighlightGutterLine).

 @warning The ACE Editor documentation for this behaviour is incomplete.
 @param highlight YES if the gutter line should be highlighted, NO otherwise.
 */
- (void) setHighlightGutterLine:(BOOL)highlight;
/** Highlight the selected word.

 Uses [editor.setHighlightSelectedWord()](http://ace.ajax.org/#Editor.setHighlightSelectedWord).

 @param highlight YES if the selected word should be highlighted, NO otherwise.
 */
- (void) setHighlightSelectedWord:(BOOL)highlight;
/** Display indent guides.

 Uses [editor.setDisplayIndentGuides()](http://ace.ajax.org/#Editor.setDisplayIndentGuides).

 @param display YES if indent guides should be displayed, NO otherwise.
 */
- (void) setDisplayIndentGuides:(BOOL)display;
/** Enable animated scrolling.

 Uses [editor.setAnimatedScroll()](http://ace.ajax.org/#Editor.setAnimatedScroll).

 @warning The ACE Editor documentation for this behaviour is incomplete.
 @param animate YES if scrolling should be animated, NO otherwise.
 */
- (void) setAnimatedScroll:(BOOL)animate;
/** Change the mouse scroll speed.

 Uses [editor.setScrollSpeed()](http://ace.ajax.org/#Editor.setScrollSpeed).

 @param speed the new scroll speed (in milliseconds).
 */
- (void) setScrollSpeed:(NSUInteger)speed;
/** Set the keyboard handler.

 Uses [editor.setKeyboardHandler()]( http://ace.ajax.org/#Editor.setKeyboardHandler ).

 @param theme The theme to set.
 @see ACETheme
 */
- (void) setKeyboardHandler:(ACEKeyboardHandler)keyboardHandler;
/** Enable basic autocomplete.
 
 User [editor.setOptions({ enableBasicAutocompletion: BOOL })]
 
 @param autocomplete YES if basic autocomplete should be enabled, NO otherwise.
 */
- (void) setBasicAutoCompletion:(BOOL)autocompletion;
/** Enable live autocompletion.
 
 User [editor.setOptions({ enableLiveAutocompletion: BOOL })]
 
 @param liveAutocompletion YES if live autocompletion should be enabled, NO otherwise.
 */
- (void) setLiveAutocompletion:(BOOL)liveAutocompletion;
/** Enable snippets.
 
 User [editor.setOptions({ enableSnippets: BOOL })]
 
 @param snippets YES if snippets should be enabled, NO otherwise.
 */
- (void) setSnippets:(BOOL)snippets;
/** Enable emmet.
 
 User [editor.setOptions({ emmet: BOOL })]
 
 @param emmet YES if emmet should be enabled, NO otherwise.
 */
- (void) setEmmet:(BOOL)emmet;
/** Sets the column defining where the print margin should be.

 Uses [editor.setPrintMarginColumn()]( http://ace.ajax.org/#Editor.setPrintMarginColumn ).

 @param column The column on which the print margin should be drawn.
 */
- (void) setPrintMarginColumn:(NSUInteger)column;
/**
 
 Uses [editor.setShowPrintMargin()]( http://ace.ajax.org/#api=editor&nav=setShowPrintMargin ).
 
 */
- (void) setShowPrintMargin:(BOOL)show;
/** Sets the font size.

 Uses [editor.setFontSize()](http://ace.ajax.org/#Editor.setFontSize).

 @param size The new font size.
 */
- (void) setFontSize:(NSUInteger)size;
/** Moves the cursor to the specified line number, and also into the indiciated column.
 
 Uses [editor.goToLine()].
 
 @param lineNumber The line number to go to
 @param lineNumber  column number to go to
 @param animate If YES animates scolling
 */
- (void) gotoLine:(NSInteger)lineNumber column:(NSInteger)columnNumber animated:(BOOL)animate;

@end
