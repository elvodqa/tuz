package graphics

import "core:fmt"
import gl "vendor:OpenGL"
import glm "core:math/linalg/glsl"


drawRect :: proc(view: View, x, y, w, h: f32, color: glm.vec3)
