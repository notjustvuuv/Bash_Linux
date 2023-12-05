#!/bin/bash

while getopts "d:n:" opt; do
    case $opt in
        d) dir_path=$OPTARG ;;
        n) name=$OPTARG ;;
        *) echo "Использование: $0 -d <dir_path> -n <name>"; exit 1 ;;
    esac
done

if [ -z "$dir_path" ] || [ -z "$name" ]; then
    echo "Необходимо указать путь к каталогу и название архива"
    exit 1
fi

cat > "$name" <<'EOF'
#!/bin/bash

unpackdir=""

while getopts "o:" opt; do
    case $opt in
        o) unpackdir=$OPTARG ;;
        *) echo "Использование: $0 [-o unpackdir]"; exit 1 ;;
    esac
done

if [ -z "$unpackdir" ]; then
    echo "Распаковка в текущий каталог..."
    tar -xzf "$0"
else
    echo "Распаковка в $unpackdir..."
    tar -xzf "$0" -C "$unpackdir"
fi
EOF

tar -czf - "$dir_path" | cat - > "$name"
chmod +x "$name"

echo "Архивация и создание скрипта $name завершены."
