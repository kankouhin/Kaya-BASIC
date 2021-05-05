cmake_minimum_required(VERSION 3.0.0)
project(bpp)

add_compile_definitions(__BPPWIN__)
#add_compile_definitions(__BPPMAC__)
#add_compile_definitions(__BPPLNX__)
set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -static -static-libstdc++ -static-libgcc")

aux_source_directory(. DIR_SRCS)
add_executable(bpp ${DIR_SRCS})

set(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/../bin)



