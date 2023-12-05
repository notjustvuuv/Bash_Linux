#!/bin/bash

correct=0
incorrect=0
total_guesses=0
correct_numbers=""
steps=0

while true; do
    number=$((RANDOM % 10))
    ((steps++))
    
    echo "Шаг $steps"
    read -p "Введите число от 0 до 9 (q для выхода): " user_input
    
    if [[ $user_input == "q" ]]; then
        echo "Игра завершена."
        break
    fi
    
    if ! [[ $user_input =~ ^[0-9]$ ]]; then
        echo "Вы ввели не то! Введите одну цифру от 0 до 9 или q для выхода."
        continue
    fi
    
    if [[ $user_input -eq $number ]]; then
        ((Correct++))
        correct_numbers+="\033[0;32m$user_input\033[0m "
        echo "Вы угадали число!"
    else
        ((incorrect++))
        correct_numbers+="\033[0;31m$user_input\033[0m "
        echo "Вы не угадали число... Загаданное число: $number"
    fi
    
    ((total_guesses++))
    
    if ((total_guesses > 10)); then
        correct_numbers=$(echo $correct_numbers | awk '{print $NF; for(i=NF-1;i>=NF-9;i--) printf("%s ",$i)}')
    fi
    
    echo -e "Статистика игры:"
    echo "Последние 10 чисел: $correct_numbers"
    echo "Угаданных чисел: $((correct * 100 / total_guesses))%"
    echo "Не угаданных чисел: $((incorrect * 100 / total_guesses))%"
    
done
