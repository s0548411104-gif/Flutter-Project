# 🌍 Country Finder - מדריך המדינות 

אפליקציית פלאטר (Flutter) אינטראקטיבית המאפשרת למשתמשים לחפש ולכלות מידע מפורט על מדינות ברחבי העולם בזמן אמת, תוך שימוש ב-API חיצוני.

---

## ✨ תכונות עיקריות (Features)
* **חיפוש דינמי:** הזנת שם מדינה באנגלית וקבלת מידע מיידי.
* **ממשק משתמש מותאם:** תמיכה מלאה בעברית (RTL) עבור כרטיסי המידע, לצד שדה חיפוש משמאל לימין (LTR) המותאם לשמות המדינות באנגלית.
* **מידע מקיף:** הצגת עיר בירה, יבשת, שפות רשמיות, מטבע מקומי, אוכלוסייה (עם פסיקים לקריאות נוחה), והאם למדינה יש מוצא לים.
* **הצגת דגלים:** טעינה והצגה של דגל המדינה מתוך שרת תמונות מרוחק.

---

## 🛠️ טכנולוגיות וכלים (Tech Stack)
* **Framework:** [Flutter](https://flutter.dev) (Dart)
* **API Source:** [Rest Countries API](https://restcountries.com/)
* **State Management:** `StatefulWidget` & `setState`

---

## 🚀 איך להריץ את הפרויקט באופן מקומי?

### דרישות קדם:
* Flutter SDK מותקן במחשב.
* אנדרואיד סטודיו או VS Code עם תוספי פלאטר.

### שלבי הרצה:
1. שכפלי את המאגר (Repository):
   ```bash
   git clone [https://github.com/YOUR_USERNAME/country_finder.git](https://github.com/YOUR_USERNAME/country_finder.git)

2. היכנסי לתיקיית הפרויקט:
    ```bash
    cd countryFinder

3. משכי את החבילות והספריות התלויות:
   ```bash
    flutter pub get

4. הריצי את האפליקציה על מכשיר וירטואלי או דפדפן:
   ```bash
    flutter run
