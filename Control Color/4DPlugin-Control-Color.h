/* --------------------------------------------------------------------------------
 #
 #	4DPlugin-Control-Color.h
 #	source generated by 4D Plugin Wizard
 #	Project : Control Color
 #	author : miyako
 #	2023/09/19
 #  
 # --------------------------------------------------------------------------------*/

#ifndef PLUGIN_CONTROL_COLOR_H
#define PLUGIN_CONTROL_COLOR_H

#include "4DPluginAPI.h"

#if VERSIONMAC
#import <Cocoa/Cocoa.h>
#else
#include <winrt/Windows.UI.ViewManagement.h>
#include <iostream>
#endif

#include "4DPlugin-JSON.h"

#pragma mark -

void Get_control_color(PA_PluginParameters params);

#endif /* PLUGIN_CONTROL_COLOR_H */
