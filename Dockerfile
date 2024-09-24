# Используем базовый образ с минимальным окружением для сборки
FROM ubuntu:20.04

# Установка часового пояса до установки других пакетов
ENV TZ=Europe/Moscow 
RUN apt-get update && \
    apt-get install -y tzdata && \
    ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata

# Установка необходимых пакетов
RUN apt-get install -y \
    build-essential \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

# Создаем директорию для проекта
WORKDIR /opt/sqlite

# Копируем исходные файлы SQLite в контейнер
COPY ./data /opt/sqlite

# Собираем библиотеку SQLite как shared library (.so)
RUN cmake . && make

# Указываем точку выхода в контейнере
CMD ["ls", "-l", "libsqlite3.so"]
