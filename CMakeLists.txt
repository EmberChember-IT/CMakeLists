cmake_minimum_required(VERSION 3.10)  # Убедитесь, что у вас установлена версия CMake 3.10 или выше
project(SQLiteLibrary)     # Укажите имя проекта и его версию

# Указываем стандарт C++
set(CMAKE_CXX_STANDARD 11)  # или 14/17/20 по вашему выбору
set(CMAKE_CXX_STANDARD_REQUIRED True)
set(PROJECT_SOURCE_DIR "/opt/sqlite")	# Поменять на путь, в котором находится файл CMake

# Создаем DLL
add_library(sqlite3 SHARED 
    sqlite3.c
    shell.c
)

# Указываем, что h-файлы должны быть доступны при использовании библиотеки
target_include_directories(sqlite3 PUBLIC
    "${PROJECT_SOURCE_DIR}"  # Директория, где находится CMakeLists.txt
)

# Устанавливаем имя и версию дляо динамической библиотеки
set_target_properties(sqlite3 PROPERTIES
    OUTPUT_NAME "sqlite3"       # Имя выходного файла
    VERSION "${1.0}" # Устанавливаем версию
)

# Установка для использования в других проектах
install(TARGETS sqlite3
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
)

install(FILES sqlite3.h sqlite3ext.h
    DESTINATION include
)
