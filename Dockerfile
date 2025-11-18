FROM ghcr.io/home-assistant/home-assistant:stable

# החלף את ה-bin בתיקייה שלך עם Python מהודרים מקוסטמים
COPY bin/ /usr/local/lib/python3.13/

# אם אתה צריך להוסיף הרשאות execute לקבצים
RUN chmod +x /usr/local/lib/python3.13/*

# הריץ את ה-netfree script כדי לעדכן את ה-SSL configuration
RUN curl -sL https://netfree.link/dl/unix-ca.sh | sh
