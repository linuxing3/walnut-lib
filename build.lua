target('Walnut')
set_languages('c++20')
set_kind('static')
add_files('Source/**.cpp', 'Platform/GUI/**.cpp')
add_defines('GLFW_INCLUDE_NONE')
add_defines('GLFW_INCLUDE_VULKAN')
add_includedirs('Source')
add_includedirs('Platform/GUI')
add_packages('imgui-walnut')
add_packages('glfw-walnut')
add_links('glfw-walnut')
add_packages('glm')
add_packages('stb')
add_packages('vulkan-headers')
add_packages('spdlog')
