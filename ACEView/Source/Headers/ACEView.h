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

extern NSString *const ACETextDidEndEditingNotification;

#pragma mark - ACEViewDelegate
@protocol ACEViewDelegate <NSObject>

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

@property(assign) id delegate;
@property(readonly) NSRange firstSelectedRange;
@property(readonly) NSString *string;

#pragma mark - ACEView interaction
/**---------------------------------------------------------------------------------------
 * @name ACE Editor API equivalent methods "ACE Editor API"
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
 */
- (void) setString:(NSString *)string;

/** Set the syntax highlighting mode.

 Uses [editor.getSession().setMode()](http://ace.ajax.org/#EditSession.setMode).

 @param ACEMode the mode to set.
 @see ACEMode
 */
- (void) setMode:(ACEMode)mode;
/** Set the theme.

 Uses [editor.getSession().setTheme()](http://ace.ajax.org/#Editor.setTheme).

 @param ACETheme the theme to set.
 @see ACETheme
 */
- (void) setTheme:(ACETheme)theme;

/** Turn wrapping behaviour on or off.

 Specifies whether to use wrapping behaviors or not, i.e. automatically wrapping the selection with characters such as brackets when such a character is typed in.

 Uses [editor.setWrapBehavioursEnabled()](http://ace.ajax.org/#Editor.setWrapBehavioursEnabled).

 @param BOOL YES if wrapping behaviours are to be enabled, NO otherwise.
 @see setUseSoftWrap:
 @see setWrapLimitRange:
 */
- (void) setWrappingBehavioursEnabled:(BOOL)wrap;
/** Sets whether or not line wrapping is enabled.

 Define the wrap limit with setWrapLimitRange.

 Uses [editor.getSession().setUseWrapMode()](http://ace.ajax.org/#EditSession.setUseWrapMode).

 @param BOOL YES if line wrapping is to be enabled, NO otherwise.
 @see setWrappingBehaviourEnabled:
 @see setWrapLimitRange:
 */
- (void) setUseSoftWrap:(BOOL)wrap;
/**  Sets the boundaries of wrap.

 Uses [editor.getSession().setWrapLimitRange()](http://ace.ajax.org/#EditSession.setWrapLimitRange).

 @param NSRange Range within which lines should be constrained. Typically range.location will be 0.
 @see setWrappingBehaviourEnabled:
 @see setUseSoftWrap:
 */
- (void) setWrapLimitRange:(NSRange)range;
/** Show or hide invisible characters.

 Uses [editor.setShowInvisibles()](http://ace.ajax.org/#Editor.setShowInvisibles).

 @param BOOL YES if inivisible characters are to be shown, NO otherwise.
 */
- (void) setShowInvisibles:(BOOL)show;
/** Show or hide folding widgets.

 Uses [editor.setShowFoldWidgets()](http://ace.ajax.org/#Editor.setShowFoldWidgets).

 @param BOOL YES if folding widgets are to be shown, NO otherwise.
 */
- (void) setShowFoldWidgets:(BOOL)show;
/** Enable fading of folding widgets.

 Uses [editor.setFadeFoldWidgets()](http://ace.ajax.org/#Editor.setFadeFoldWidgets).

 @param BOOL YES if folding widgets should be faded, NO otherwise.
 */
- (void) setFadeFoldWidgets:(BOOL)fade;
/** Highlight the active line.

 Uses [editor.setHighlightActiveLine()](http://ace.ajax.org/#Editor.setHighlightActiveLine).

 @param BOOL YES if the active line should be highlighted, NO otherwise.
 */
- (void) setHighlightActiveLine:(BOOL)highlight;
/** Highlight the gutter line.

 Uses [editor.setHighlightGutterLine()](http://ace.ajax.org/#Editor.setHighlightGutterLine).

 @warning The ACE Editor documentation for this behaviour is incomplete.
 @param BOOL YES if the gutter line should be highlighted, NO otherwise.
 */
- (void) setHighlightGutterLine:(BOOL)highlight;
/** Highlight the selected word.

 Uses [editor.setHighlightSelectedWord()](http://ace.ajax.org/#Editor.setHighlightSelectedWord).

 @param BOOL YES if the selected word should be highlighted, NO otherwise.
 */
- (void) setHighlightSelectedWord:(BOOL)highlight;
/** Display indent guides.

 Uses [editor.setDisplayIndentGuides()](http://ace.ajax.org/#Editor.setDisplayIndentGuides).

 @param BOOL YES if indent guides should be displayed, NO otherwise.
 */
- (void) setDisplayIndentGuides:(BOOL)display;
/** Enable animated scrolling.

 Uses [editor.setAnimatedScroll()](http://ace.ajax.org/#Editor.setAnimatedScroll).

 @warning The ACE Editor documentation for this behaviour is incomplete.
 @param BOOL YES if scrolling should be animated, NO otherwise.
 */
- (void) setAnimatedScroll:(BOOL)animate;
/** Change the mouse scroll speed.

 Uses [editor.setScrollSpeed()](http://ace.ajax.org/#Editor.setScrollSpeed).

 @param NSUInteger the new scroll speed (in milliseconds).
 */
- (void) setScrollSpeed:(NSUInteger)speed;
/** Sets the column defining where the print margin should be.

 Uses [editor.setPrintMarginColumn()](http://ace.ajax.org/#Editor.setPrintMarginColumn).

 @param NSUInteger The column on which the print margin should be drawn.
 */
- (void) setPrintMarginColumn:(NSUInteger)column;
/** Sets the font size.

 Uses [editor.setFontSize()](http://ace.ajax.org/#Editor.setFontSize).

 @param NSUInteger The new font size.
 */
- (void) setFontSize:(NSUInteger)size;

@end
