package main

import "core:fmt"
import "core:os"
import "core:runtime"

import "bass"
import "graphics"

import gl "vendor:OpenGL"
import "vendor:glfw"
import "vendor:miniaudio"

GL_MAJOR :: 4
GL_MINOR :: 1

main :: proc() {
    if (glfw.Init() != 1) {
        fmt.println("Error initializing glfw")
        return
    }

    if (glfw.Init() != 1) {
        fmt.println("Failed to initialize GLFW")
        return
    }
    defer glfw.Terminate()

    glfw.WindowHint(glfw.RESIZABLE, 1)
    glfw.WindowHint(glfw.CONTEXT_VERSION_MAJOR, GL_MAJOR)
    glfw.WindowHint(glfw.CONTEXT_VERSION_MINOR, GL_MINOR)
    glfw.WindowHint(glfw.OPENGL_PROFILE,glfw.OPENGL_CORE_PROFILE)
    
    when ODIN_OS == .Darwin {
        glfw.WindowHint(glfw.OPENGL_FORWARD_COMPAT, 1)
    }

    window := glfw.CreateWindow(1280, 600, "Hello World", nil, nil)
    if (window == nil) {
        fmt.println("Failed to open GLFW window")
        return
    }
    defer glfw.DestroyWindow(window)

    glfw.MakeContextCurrent(window)
    glfw.SwapInterval(1)

    glfw.SetWindowSizeLimits(window, 480, 360, glfw.DONT_CARE, glfw.DONT_CARE)
    glfw.SetKeyCallback(window, key_callback)
    glfw.SetFramebufferSizeCallback(window, size_callback)

    gl.load_up_to(GL_MAJOR, GL_MINOR, glfw.gl_set_proc_address)
    fmt.printf("OpenGL version: %s\n", gl.GetString(gl.VERSION))
    fmt.printf("GLSL version: %s\n", gl.GetString(gl.SHADING_LANGUAGE_VERSION))
    fmt.printf("Vendor: %s\n", gl.GetString(gl.VENDOR))
    fmt.printf("Renderer: %s\n", gl.GetString(gl.RENDERER))

    play_bass()

    for (!glfw.WindowShouldClose(window)) {
        WIDTH, HEIGHT := glfw.GetFramebufferSize(window)
        gl.Viewport(0, 0, WIDTH, HEIGHT)
        
        gl.ClearColor(0.0, 0.0, 0.4, 0.0)
        gl.Clear(gl.COLOR_BUFFER_BIT)
        



        glfw.SwapBuffers(window)
        glfw.PollEvents()
    }   
}

key_callback :: proc "c" (window: glfw.WindowHandle, key, scancode, action, mods: i32) {
    context = runtime.default_context()
    if key == glfw.KEY_ESCAPE {
        glfw.SetWindowShouldClose(window, true)
	} else {
        //fmt.printf("key: %d, scancode: %d, action: %d, mods: %d\n", key, scancode, action, mods)
    }
}

size_callback :: proc "c" (window: glfw.WindowHandle, width, height: i32) {
	gl.Viewport(0, 0, width, height)
}


play_bass :: proc() {
    bass.Init(-1, 44100, 0, nil, nil)
    chan := cast(u32)bass.StreamCreateFile(false, "audio.mp3", 0, 0, 0)
    bass.ChannelPlay(chan, false)
    for true {
        pos := bass.ChannelGetPosition(chan, 0)
        fmt.printf("pos: %d\n", pos)
    }
}