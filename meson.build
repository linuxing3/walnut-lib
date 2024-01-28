#####  GLFW  #####
#@ Project file
project(
  'walnut',
  'cpp',
  version: '1.0.0',
  license: 'MIT',
)

CXX = meson.get_compiler('cpp')

#@ Project variables
libimgui_project = subproject('imgui-walnut')
libimgui_dep = libimgui_project.get_variable('imgui')

libglfw_project = subproject('glfw-walnut')
libglfw_dep = libglfw_project.get_variable('glfw')

libvulkan_path = '/home/vagrant/Downloads/vulkan_sdk/x86_64/lib'
libs_to_link = ['libvulkan']

add_project_arguments('-DGLFW_INCLUDE_NONE', '-DGLFW_INCLUDE_VULKAN', '-std=c++20', language: 'cpp')

### Dependencies ###
deps = []
deps += dependency('spdlog')
foreach lib_name : libs_to_link 
  deps += CXX.find_library(lib_name, dirs : [ libvulkan_path ])
endforeach

### Targets ###
#@ Primary target:
srcfiles = files(
  './Source/Walnut/Core/Log.cpp',
  './Source/Walnut/Random.cpp',
  './Source/Walnut/Serialization/BufferStream.cpp',
  './Source/Walnut/Serialization/FileStream.cpp',
  './Source/Walnut/Serialization/StreamReader.cpp',
  './Source/Walnut/Serialization/StreamWriter.cpp',
  './Source/Walnut/Utils/StringUtils.cpp',
  './Platform/GUI/Walnut/ApplicationGUI.cpp',
  './Platform/GUI/Walnut/ImGui/ImGuiBuild.cpp',
  './Platform/GUI/Walnut/ImGui/ImGuiTheme.cpp',
  './Platform/GUI/Walnut/Image.cpp',
  './Platform/GUI/Walnut/Input/Input.cpp',
  './Platform/GUI/Walnut/UI/Console.cpp',
  './Platform/GUI/Walnut/UI/UI.cpp',
)
incdirs = include_directories('Source', 'Platform/GUI', 'vendor/stb', 'subprojects/imgui-walnut', 'subprojects/glfw-walnut/include')

#  Build
walnut = library(
  'walnut',
  srcfiles,
  include_directories: incdirs,
  dependencies: deps,
  version: meson.project_version(),
  build_by_default: true,
  link_with: [ libglfw_dep, libimgui_dep ],
  pic: true,
)
walnut_dep = declare_dependency(
  include_directories: incdirs,
  link_with: walnut,
)

### Post
#@ Pkg-config
if get_option('install')
  pkg = import('pkgconfig')
  pkg.generate(
    walnut_lib,
    name: 'walnut',
    description: 'A multi-platform library for vulkan, windows, and input',
    url: 'https://www.walnut.org/',
    filebase: 'walnut',
  )
endif

### Post
#@ test
testfiles = files('test/app.cpp')
# Build test app
walnutapp = executable(
  'walnutapp',
  testfiles,
  include_directories: incdirs,
  build_by_default: true,
  link_with: [ walnut , libglfw_dep, libimgui_dep ],
)
