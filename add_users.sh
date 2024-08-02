#!/bin/bash

OCPASSWD_FILE="/etc/ocserv/ocpasswd"

USER_FILE="users.txt"

if [ ! -f "$USER_FILE" ]; then
    echo "Файл $USER_FILE не найден!"
    exit 1
fi

while IFS=$'\t' read -r user password; do
    echo "Добавляем пользователя $user"
    echo -e "${password}\n${password}" | docker exec -i ocserv_container ocpasswd -c $OCPASSWD_FILE $user
done < "$USER_FILE"