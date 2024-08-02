#!/bin/bash

# Путь к файлу ocpasswd
OCPASSWD_FILE="/etc/ocserv/ocpasswd"

# Путь к файлу с пользователями и паролями
USER_FILE="users.txt"

# Проверяем, существует ли файл с пользователями
if [ ! -f "$USER_FILE" ]; then
    echo "Файл $USER_FILE не найден!"
    exit 1
fi

# Читаем файл и добавляем пользователей
while read -r line; do
    user=$(echo $line | awk '{print $1}')
    password=$(echo $line | awk '{print $2}')
    
    if [ -n "$user" ] && [ -n "$password" ]; then
        echo "Добавляем пользователя $user"
        echo -e "${password}\n${password}" | docker exec -i ocserv_container ocpasswd -c $OCPASSWD_FILE $user
        if [ $? -eq 0 ]; then
            echo "Пользователь $user успешно добавлен"
        else
            echo "Ошибка при добавлении пользователя $user"
        fi
    else
        echo "Строка в файле некорректна: $line"
    fi
done < "$USER_FILE"