

LOG_FILE="test_access.log"
OUTPUT_FILE="bad_admin_ips.txt"


if [ ! -f "$LOG_FILE" ]; then
    echo "Файл $LOG_FILE не знайдено!"
    exit 1
fi

echo "Пошук невдалих запитів до /admin у файлі $LOG_FILE..."
echo "" > "$OUTPUT_FILE"


grep "/admin" "$LOG_FILE" | awk '{ 
    ip=$3; code=$NF; 
    if (code >= 400) print ip, code 
}' | sort | uniq > "$OUTPUT_FILE"

echo "✅ Результати збережено у $OUTPUT_FILE"
