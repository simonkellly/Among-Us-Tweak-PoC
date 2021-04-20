typedef void (*set_Text)(void* obj, System_String_o* str);

void TMP_SetText(TMPro_TextMeshPro_o* tmp, const char* str) {
    ((set_Text) tmp->klass->vtable._66_set_text.methodPtr)(
        tmp, il2cpp_string_new(str)
    );
}