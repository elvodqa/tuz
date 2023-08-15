package graphics

import "core:fmt"
import gl "vendor:OpenGL"
import glm "core:math/linalg/glsl"

Shader :: struct {
    id: u32
}

newShaderFromFile :: proc($vert, $frag: string) -> (s: Shader) {
    program, ok := gl.load_shaders_file(
        vert, frag)
    if !ok {
        fmt.printf("Failed to load shaders: %s, %s\n",
            vert, frag)
        return Shader{0}
    }
    s.id = program
    return s
}

newShaderFromSource :: proc($vert, $frag: string) -> (s: Shader) {
    program, ok := gl.load_shaders_source(
        vert, frag)
    if !ok {
        fmt.printf("Failed to load shader from source\n")
        return Shader{0}
    }
    s.id = program
    return s
}

setUniformInt :: proc(s: ^Shader, name: cstring, value: i32) {
    gl.UseProgram(s.id)
    gl.Uniform1i(gl.GetUniformLocation(s.id, name), value)
}

setUniformFloat :: proc(s: ^Shader, name: cstring, value: f32) {
    gl.UseProgram(s.id)
    gl.Uniform1f(gl.GetUniformLocation(s.id, name), value)
}

setUniformVec2 :: proc(s: ^Shader, name: cstring, value: glm.vec2) {
    gl.UseProgram(s.id)
    gl.Uniform2f(gl.GetUniformLocation(s.id, name), value.x, value.y)
    gl.UseProgram(0)
}

setUniformVec3 :: proc(s: ^Shader, name: cstring, value: glm.vec3) {
    gl.UseProgram(s.id)
    gl.Uniform3f(gl.GetUniformLocation(s.id, name), value.x, value.y, value.z)
    gl.UseProgram(0)
}

setUniformVec4 :: proc(s: ^Shader, name: cstring, value: glm.vec4) {
    gl.UseProgram(s.id)
    gl.Uniform4f(gl.GetUniformLocation(s.id, name), value.x, value.y, value.z, value.w)
    gl.UseProgram(0)
}

setUniformMat4 :: proc(s: ^Shader, name: cstring, value: ^glm.mat4) {
    gl.UseProgram(s.id)
    gl.UniformMatrix4fv(gl.GetUniformLocation(s.id, name), 1, false, &value[0, 0])
    gl.UseProgram(0)
}

bindShader :: proc(s: ^Shader) {
    gl.UseProgram(s.id)
}

unbindShader :: proc() {
    gl.UseProgram(0)
}