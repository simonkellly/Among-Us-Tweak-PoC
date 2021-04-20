#line 1 "Tweak.xm"
#include <substrate.h>
#include <mach-o/dyld.h>
#include <mach/mach.h>
#import "UIKit/UIKit.h"
#import <Foundation/Foundation.h>
#include "utils/alert.hpp"
#include "Resources/il2cpp.h"
#include "utils/il2cpp_api_functions.hpp"
#include "utils/tmp_extensions.hpp"
#include  "utils/hook_helper.hpp"

#define timer(sec) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, sec * NSEC_PER_SEC), dispatch_get_main_queue(), ^


UnityEngine_Material_o *(*get_Material)(UnityEngine_Renderer_o *);
void (*set_Color)(UnityEngine_Material_o *, UnityEngine_Color_o);





void (*base_VersionShower_Start)(VersionShower_o* this_);
void hook_VersionShower_Start(VersionShower_o* this_) {
    base_VersionShower_Start(this_);
    TMP_SetText(this_->fields.text, "\n<color=#7eeff7ff>When the <color=#ff0000ff>Impostor</color> is SUS!</color>\n<color=#00ff00ff>Reactor.iOS wen</color>");
}

void (*base_GameStartManager_Update)(GameStartManager_o* this_);
void hook_GameStartManager_Update(GameStartManager_o* this_) {
    base_GameStartManager_Update(this_);
    
    this_->fields.MinPlayers = 0;
}

void (*base_IntroCutscene_BeginCrewmate)(IntroCutscene_o* this_, uintptr_t player_controls);
void hook_IntroCutscene_BeginCrewmate(IntroCutscene_o* this_, uintptr_t player_controls) {
    base_IntroCutscene_BeginCrewmate(this_, player_controls);

    TMPro_TextMeshPro_o* Title = this_->fields.Title;
    TMPro_TextMeshPro_o* ImpostorText = this_->fields.ImpostorText;

    UnityEngine_MeshRenderer_o* BackgroundBar = this_->fields.BackgroundBar;

    UnityEngine_Color_o jester_color;
    jester_color.fields.r = 1;
    jester_color.fields.g = 0.67;
    jester_color.fields.b = 0.95;
    jester_color.fields.a = 1;

    set_Color(get_Material((UnityEngine_Renderer_o *) BackgroundBar), jester_color);

    TMP_SetText(Title, "<color=#ffabf1ff>Jester</color>");
    TMP_SetText(ImpostorText, "Fool the <color=#26e6ffff>crew</color> and get voted out!");
}

void (*base_PlayerControl_FixedUpdate)(PlayerControl_o* this_);
void hook_PlayerControl_FixedUpdate(PlayerControl_o* this_) {
    base_PlayerControl_FixedUpdate(this_);

    if (this_->fields.DEOCJFPDHPN) {
        TMP_SetText(this_->fields.nameText, "<color=#ffabf1ff>Loommas</color>");
    }
}


bool (*base_SaveManager_GetPurchase)(void* this_, uintptr_t _);
bool hook_SaveManager_GetPurchase(void* this_, uintptr_t _) {
    return true;
}

bool (*base_StatsManager_get_AmBanned)(void* this_);
bool hook_StatsManager_get_AmBanned(void* this_) {
    return false;
}

void (*base_ShipStatus_CheckEndCriteria)(void* this_);
void hook_ShipStatus_CheckEndCriteria(void* this_) {}

void setup() {
    showAlert(@"Dear Amogus Player", @"The Fitness🏋🚴⛹Gram📊📈📑™ Pacer❤️ Test😩📝 is a multistage1⃣🙂2⃣😐3⃣😩 aerobic✈️🛩🚁 capacity📦🗃 🗄🗳test😩📝 that progressively📈📊 gets more➕ difficult💔😩🔫 as it continues🕛🕐🕑. The 2⃣0⃣ meter📏 pacer❤️ test😩📝 will begin in 3⃣0⃣ seconds. Line➖ up🔼⬆️ at the start. The running 👞👞speed starts▶️ slowly📊📉, but gets faster📊📈 each minute🕛 after you hear ▶️👂❗️this signal📢📣. A single1⃣ lap 🔁should😅 be completed🔃 each time🕛 you hear▶️👂❗️ this sound📢📣. Remember😅 to run👞👞 in a straight😅🚫🌈🚫 line, and run👞👞 as long🕛🕐🕑 as possible🙂😐😣😩. The 2⃣nd time you fail🚷😩 to complete🔃 a lap🔁 before the sound📢📣, your test😩📝 is over🚷. The test😩📝 will begin▶️ on the word start🏁. On your mark✒️✏️, get ready3⃣2⃣1⃣, start⏯.:)", @"Proceed ➡️");

    il2cpp_string_new = (System_String_o * (*)(const char *)) getAbsoluteAddress("UnityFramework", 0xDCAA80);
    get_Material = (UnityEngine_Material_o* (*)(UnityEngine_Renderer_o *)) getAbsoluteAddress("UnityFramework", 0x2E6A204);
    set_Color = (void (*)(UnityEngine_Material_o *, UnityEngine_Color_o)) getAbsoluteAddress("UnityFramework", 0x2E4E94C);
    
    HOOK(0x10379A0, hook_VersionShower_Start, base_VersionShower_Start);
    HOOK(0x17E2070, hook_SaveManager_GetPurchase, base_SaveManager_GetPurchase);

    
    HOOK(0x1528568, hook_IntroCutscene_BeginCrewmate, base_IntroCutscene_BeginCrewmate);
    HOOK(0x19B782C, hook_ShipStatus_CheckEndCriteria, base_ShipStatus_CheckEndCriteria);

    
    HOOK(0x1485CC0, hook_GameStartManager_Update, base_GameStartManager_Update);
    
    
    HOOK(0x175FA70, hook_PlayerControl_FixedUpdate, base_PlayerControl_FixedUpdate);

    
    HOOK(0x14EB5A8, hook_StatsManager_get_AmBanned, base_StatsManager_get_AmBanned);
}


static void didFinishLaunching(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef info) {
    setup();
}


static __attribute__((constructor)) void _logosLocalCtor_a35f2b9f(int __unused argc, char __unused **argv, char __unused **envp) {
  CFNotificationCenterAddObserver(CFNotificationCenterGetLocalCenter(), NULL, &didFinishLaunching, (CFStringRef)UIApplicationDidFinishLaunchingNotification, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
}
