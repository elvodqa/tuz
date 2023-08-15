package graphics

import "core:fmt"
import gl "vendor:OpenGL"
import glm "core:math/linalg/glsl"

View :: struct {
    position: glm.vec3
    rotation: glm.vec3
    scale: glm.vec3

    projection: glm.mat4
    view: glm.mat4

    fov: f32
    aspect: f32
    near: f32
    far: f32
}

newView3D :: proc(pos, rot, scale: glm.vec3, fov, aspect, near, far: f32) -> View {
    view := View{
        position=pos,
        rotation=rot,
        scale=scale,

        fov=fov,
        aspect=aspect,
        near=near,
        far=far,
    }
    
    view.projection = glm.mat4Perspective(view.fov, view.aspect, view.near, view.far)
    view.view *= glm.identity(glm.mat4)
    view.view *= glm.mat4Translate(view.position)
    view.view *= glm.mat4Rotate(glm.vec3{1, 0, 0}, view.rotation.x)
    view.view *= glm.mat4Rotate(glm.vec3{0, 1, 0}, view.rotation.y)
    view.view *= glm.mat4Rotate(glm.vec3{0, 0, 1}, view.rotation.z)
    view.view *= glm.mat4Scale(view.scale)
    
    return view
}

newView2D :: proc(pos, rot, scale, size: glm.vec2) -> View {
    view := View{
        position=glm.vec3{pos.x, pos.y, 0},
        rotation=glm.vec3{rot.x, rot.y, 0},
        scale=glm.vec3{scale.x, scale.y, 1},

        fov=0,
        aspect=0,
        near=0,
        far=0,
    }

    view.projection = glm.mat4Ortho3d(0, size.x, 0, size.y, -1, 1)
    view.view *= glm.identity(glm.mat4)
    view.view *= glm.mat4Translate(view.position)
    view.view *= glm.mat4Rotate(glm.vec3{1, 0, 0}, view.rotation.x)
    view.view *= glm.mat4Rotate(glm.vec3{0, 1, 0}, view.rotation.y)
    view.view *= glm.mat4Rotate(glm.vec3{0, 0, 1}, view.rotation.z)
    view.view *= glm.mat4Scale(view.scale)
    
    return view
}  
