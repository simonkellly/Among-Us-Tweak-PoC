
typedef struct {
    int index;
    const mach_header *header;
    const char *name;
    intptr_t address;
} memory_file_info;

memory_file_info getMemoryFileInfo(const char *fileName){
    memory_file_info _info;

    int imageCount = _dyld_image_count();

    for(int i = 0; i < imageCount; i++) {
        const char *name = _dyld_get_image_name(i);
        const mach_header *header = _dyld_get_image_header(i);
        if(!strstr(name, fileName)) continue;

        memory_file_info new_info = {
            i, header, name, _dyld_get_image_vmaddr_slide(i)
        };

        _info = new_info;
    }
    return _info;
}

memory_file_info getBaseInfo(){
    memory_file_info _info = {
        0,
        _dyld_get_image_header(0),
        _dyld_get_image_name(0),
        _dyld_get_image_vmaddr_slide(0)
    };
    return _info;
}

uint64_t getAbsoluteAddress(const char *fileName, uint64_t address){
	memory_file_info info;
	if(fileName != NULL){
	   info = getMemoryFileInfo(fileName);
	} else {
	   info = getBaseInfo();
	}
    if(info.address == 0)
        return 0;
    return info.address + address;
}

#define HOOK(offset, detour, original) MSHookFunction((void *) getAbsoluteAddress("UnityFramework", offset), (void *) detour, (void **) &original);