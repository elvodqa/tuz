package graphics

import gl "vendor:OpenGL"
import "vendor:stb/image"
import "core:fmt"

GLTexture :: struct {
    id: u32
    width: i32
    height: i32
    channels: i32
    desired: i32
}

newTexture :: proc(path: cstring) -> (tex: GLTexture) {
    gl.GenTextures(1, &tex.id)
    gl.BindTexture(gl.TEXTURE_2D, tex.id)

    gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.CLAMP_TO_EDGE)
    gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.CLAMP_TO_EDGE)
    gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR)
    gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR)

    tex.desired = 3
    data := image.load(path, &tex.width, &tex.height, &tex.channels, tex.desired)
    if data == nil {
        fmt.printf("Failed to load texture: %s\n", path)
        return tex
    }

    gl.TexImage2D(gl.TEXTURE_2D, 0, gl.RGB, tex.width, tex.height, 0, gl.RGB, gl.UNSIGNED_BYTE, data)
    gl.GenerateMipmap(gl.TEXTURE_2D)
    image.image_free(data)

    return tex    
}

bindTexture :: proc(tex: GLTexture) {
    gl.BindTexture(gl.TEXTURE_2D, tex.id)
}

unbindTexture :: proc() {
    gl.BindTexture(gl.TEXTURE_2D, 0)
}