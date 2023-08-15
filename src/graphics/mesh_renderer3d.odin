package graphics

import "core:fmt"
import gl "vendor:OpenGL"
import glm "core:math/linalg/glsl"

Mesh :: struct {
    Vertices: []glm.vec3
    Normals: []glm.vec3
    TexCoords: []glm.vec2
    Indices: []u32
}

Material :: struct {
    Diffuse: glm.vec3
    Specular: glm.vec3
    Shininess: f32
}

MeshRenderer3D :: struct {
    mesh: Mesh
    material: Material
}

newMesh :: proc(vertices: []glm.vec3, normals: []glm.vec3, texCoords: []glm.vec2, indices: []u32) -> Mesh {
    return Mesh {
        Vertices= vertices,
        Normals= normals,
        TexCoords= texCoords,
        Indices= indices,
    }
}

newMeshRenderer3D :: proc(mesh: Mesh, material: Material) -> MeshRenderer3D {
    return MeshRenderer3D {
        mesh= mesh,
        material= material,
    }
}


