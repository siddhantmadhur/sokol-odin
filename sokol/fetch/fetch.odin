// machine generated, do not edit

package sokol_fetch

import "core:c"

SOKOL_DEBUG :: #config(SOKOL_DEBUG, ODIN_DEBUG)

DEBUG :: #config(SOKOL_FETCH_DEBUG, SOKOL_DEBUG)
USE_GL :: #config(SOKOL_USE_GL, false)
USE_DLL :: #config(SOKOL_DLL, false)

when ODIN_OS == .Windows {
    when USE_DLL {
        when USE_GL {
            when DEBUG { foreign import sokol_fetch_clib { "../sokol_dll_windows_x64_gl_debug.lib" } }
            else       { foreign import sokol_fetch_clib { "../sokol_dll_windows_x64_gl_release.lib" } }
        } else {
            when DEBUG { foreign import sokol_fetch_clib { "../sokol_dll_windows_x64_d3d11_debug.lib" } }
            else       { foreign import sokol_fetch_clib { "../sokol_dll_windows_x64_d3d11_release.lib" } }
        }
    } else {
        when USE_GL {
            when DEBUG { foreign import sokol_fetch_clib { "sokol_fetch_windows_x64_gl_debug.lib" } }
            else       { foreign import sokol_fetch_clib { "sokol_fetch_windows_x64_gl_release.lib" } }
        } else {
            when DEBUG { foreign import sokol_fetch_clib { "sokol_fetch_windows_x64_d3d11_debug.lib" } }
            else       { foreign import sokol_fetch_clib { "sokol_fetch_windows_x64_d3d11_release.lib" } }
        }
    }
} else when ODIN_OS == .Darwin {
    when USE_DLL {
             when  USE_GL && ODIN_ARCH == .arm64 &&  DEBUG { foreign import sokol_fetch_clib { "../dylib/sokol_dylib_macos_arm64_gl_debug.dylib" } }
        else when  USE_GL && ODIN_ARCH == .arm64 && !DEBUG { foreign import sokol_fetch_clib { "../dylib/sokol_dylib_macos_arm64_gl_release.dylib" } }
        else when  USE_GL && ODIN_ARCH == .amd64 &&  DEBUG { foreign import sokol_fetch_clib { "../dylib/sokol_dylib_macos_x64_gl_debug.dylib" } }
        else when  USE_GL && ODIN_ARCH == .amd64 && !DEBUG { foreign import sokol_fetch_clib { "../dylib/sokol_dylib_macos_x64_gl_release.dylib" } }
        else when !USE_GL && ODIN_ARCH == .arm64 &&  DEBUG { foreign import sokol_fetch_clib { "../dylib/sokol_dylib_macos_arm64_metal_debug.dylib" } }
        else when !USE_GL && ODIN_ARCH == .arm64 && !DEBUG { foreign import sokol_fetch_clib { "../dylib/sokol_dylib_macos_arm64_metal_release.dylib" } }
        else when !USE_GL && ODIN_ARCH == .amd64 &&  DEBUG { foreign import sokol_fetch_clib { "../dylib/sokol_dylib_macos_x64_metal_debug.dylib" } }
        else when !USE_GL && ODIN_ARCH == .amd64 && !DEBUG { foreign import sokol_fetch_clib { "../dylib/sokol_dylib_macos_x64_metal_release.dylib" } }
    } else {
        when USE_GL {
            when ODIN_ARCH == .arm64 {
                when DEBUG { foreign import sokol_fetch_clib { "sokol_fetch_macos_arm64_gl_debug.a" } }
                else       { foreign import sokol_fetch_clib { "sokol_fetch_macos_arm64_gl_release.a" } }
            } else {
                when DEBUG { foreign import sokol_fetch_clib { "sokol_fetch_macos_x64_gl_debug.a" } }
                else       { foreign import sokol_fetch_clib { "sokol_fetch_macos_x64_gl_release.a" } }
            }
        } else {
            when ODIN_ARCH == .arm64 {
                when DEBUG { foreign import sokol_fetch_clib { "sokol_fetch_macos_arm64_metal_debug.a" } }
                else       { foreign import sokol_fetch_clib { "sokol_fetch_macos_arm64_metal_release.a" } }
            } else {
                when DEBUG { foreign import sokol_fetch_clib { "sokol_fetch_macos_x64_metal_debug.a" } }
                else       { foreign import sokol_fetch_clib { "sokol_fetch_macos_x64_metal_release.a" } }
            }
        }
    }
} else when ODIN_OS == .Linux {
    when DEBUG { foreign import sokol_fetch_clib { "sokol_fetch_linux_x64_gl_debug.a" } }
    else       { foreign import sokol_fetch_clib { "sokol_fetch_linux_x64_gl_release.a" } }
} else when ODIN_OS == .Freestanding {

} else {
    #panic("This OS is currently not supported")
}

@(default_calling_convention="c", link_prefix="sfetch_")
foreign sokol_fetch_clib {
    setup :: proc(#by_ptr desc: Desc)  ---
    shutdown :: proc()  ---
    valid :: proc() -> bool ---
    desc :: proc() -> Desc ---
    max_userdata_bytes :: proc() -> c.int ---
    max_path :: proc() -> c.int ---
    send :: proc(#by_ptr request: Request) -> Handle ---
    handle_valid :: proc(h: Handle) -> bool ---
    dowork :: proc()  ---
    bind_buffer :: proc(h: Handle, buffer: Range)  ---
    unbind_buffer :: proc(h: Handle) -> rawptr ---
    cancel :: proc(h: Handle)  ---
    pause :: proc(h: Handle)  ---
    continue_t :: proc(h: Handle)  ---
}

Log_Item :: enum i32 {
    OK,
    MALLOC_FAILED,
    FILE_PATH_UTF8_DECODING_FAILED,
    SEND_QUEUE_FULL,
    REQUEST_CHANNEL_INDEX_TOO_BIG,
    REQUEST_PATH_IS_NULL,
    REQUEST_PATH_TOO_LONG,
    REQUEST_CALLBACK_MISSING,
    REQUEST_CHUNK_SIZE_GREATER_BUFFER_SIZE,
    REQUEST_USERDATA_PTR_IS_SET_BUT_USERDATA_SIZE_IS_NULL,
    REQUEST_USERDATA_PTR_IS_NULL_BUT_USERDATA_SIZE_IS_NOT,
    REQUEST_USERDATA_SIZE_TOO_BIG,
    CLAMPING_NUM_CHANNELS_TO_MAX_CHANNELS,
    REQUEST_POOL_EXHAUSTED,
}

Logger :: struct {
    func : proc "c" (a0: cstring, a1: u32, a2: u32, a3: cstring, a4: u32, a5: cstring, a6: rawptr),
    user_data : rawptr,
}

Range :: struct {
    ptr : rawptr,
    size : c.size_t,
}

Allocator :: struct {
    alloc_fn : proc "c" (a0: c.size_t, a1: rawptr) -> rawptr,
    free_fn : proc "c" (a0: rawptr, a1: rawptr),
    user_data : rawptr,
}

Desc :: struct {
    max_requests : u32,
    num_channels : u32,
    num_lanes : u32,
    allocator : Allocator,
    logger : Logger,
}

Handle :: struct {
    id : u32,
}

Error :: enum i32 {
    NO_ERROR,
    FILE_NOT_FOUND,
    NO_BUFFER,
    BUFFER_TOO_SMALL,
    UNEXPECTED_EOF,
    INVALID_HTTP_STATUS,
    CANCELLED,
}

Response :: struct {
    handle : Handle,
    dispatched : bool,
    fetched : bool,
    paused : bool,
    finished : bool,
    failed : bool,
    cancelled : bool,
    error_code : Error,
    channel : u32,
    lane : u32,
    path : cstring,
    user_data : rawptr,
    data_offset : u32,
    data : Range,
    buffer : Range,
}

Request :: struct {
    channel : u32,
    path : cstring,
    callback : proc "c" (a0: ^Response),
    chunk_size : u32,
    buffer : Range,
    user_data : Range,
}

