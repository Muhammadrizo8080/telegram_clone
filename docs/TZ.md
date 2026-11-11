# Telegram Clone (Flutter) — Texnik topshiriq (TZ)

Maqsad: Flutter'ni amaliy o'rganish. Loyiha o'quv xarakterida, shuning uchun hamma narsa bosqichma-bosqich quriladi.

## 1. Loyiha haqida umumiy ma'lumot
- **Nomi:** Telegram Clone (ish nomi: MyGram)
- **Maqsadi:** Telegram messenjerining asosiy imkoniyatlarini Flutter'da qayta yaratish orqali Flutter, state management, real-time aloqa va backend bilan ishlashni o'rganish.
- **Platformalar:** Android (asosiy), ixtiyoriy ravishda iOS va Linux desktop.
- **Muhim eslatma:** Bu loyiha Telegram'ning to'liq nusxasi emas. Telegram'ning shifrlash, kanallar, botlar, qo'ng'iroqlar kabi murakkab qismlari bu TZ'ga kirmaydi. Biz uning yadrosini quramiz: ro'yxatdan o'tish, chatlar ro'yxati, xabar almashish.

## 2. Texnologiyalar steki

| Qatlam | Tavsiya | Nima uchun |
|---|---|---|
| Til / Framework | Flutter + Dart | Asosiy o'rganiladigan texnologiya |
| State management | flutter_bloc (yoki Riverpod) | Siz oldingi loyihada bloc ishlatgansiz, davom ettirish qulay |
| Backend (oson yo'l) | Firebase (Auth, Firestore, Storage, FCM) | Server yozmasdan real-time chat qilish mumkin |
| Backend (qiyin yo'l, ixtiyoriy) | Spring Boot + WebSocket (STOMP) | Java bilimingizni Flutter bilan bog'lash uchun |
| Lokal saqlash | hive yoki drift (SQLite) | Offlayn rejim va kesh uchun |
| Navigatsiya | go_router | Ekranlar orasida o'tish |
| Rasm tanlash | image_picker | Avatar va rasm yuborish |
| Bildirishnoma | Firebase Cloud Messaging | Push xabarlar |

> **Maslahat:** Birinchi versiyani Firebase bilan qiling. Chunki asosiy maqsad Flutter'ni o'rganish, backend yozish emas. Keyin xohlasangiz, backend'ni Spring Boot'ga almashtirasiz.

## 3. Funksional talablar
Talablar MVP (minimal ishlaydigan versiya) va keyingi bosqichlarga bo'lingan.

### 3.1. Autentifikatsiya (MVP)
- Telefon raqami orqali kirish (SMS kod) yoki soddalik uchun email + parol.
- Birinchi kirishda profil to'ldirish: ism, familiya, username, avatar.
- Tizimdan chiqish (logout).
- Sessiyani saqlash: ilova qayta ochilganda foydalanuvchi qayta kirmasligi kerak.

### 3.2. Chatlar ro'yxati (MVP)
- Barcha suhbatlar ro'yxati, oxirgi xabar bo'yicha tartiblangan.
- Har bir elementda: avatar, ism, oxirgi xabar matni, vaqti, o'qilmagan xabarlar soni.
- Ro'yxatni qidirish (ism bo'yicha).
- Chatni o'chirish (swipe yoki uzoq bosish).

### 3.3. Shaxsiy chat ekrani (MVP)
- Matnli xabar yuborish va qabul qilish (real-time).
- Xabar holati: yuborilmoqda → yuborildi → o'qildi.
- Xabarlar vaqti va kunlar bo'yicha ajratgich ("Bugun", "Kecha").
- Xabarni uzoq bosganda menyu: nusxalash, o'chirish, javob berish (reply).
- Yozayotgani ko'rsatkichi ("yozmoqda...").
- Foydalanuvchi onlayn / oxirgi marta ko'ringan vaqti.

### 3.4. Kontaktlar va qidiruv (MVP)
- Username bo'yicha foydalanuvchini topish.
- Yangi chat boshlash.

### 3.5. Profil va sozlamalar (MVP)
- Profilni ko'rish va tahrirlash.
- Avatarni almashtirish.
- Mavzu: yorug' / qorong'i (dark mode).

### 3.6. Media yuborish (2-bosqich)
- Rasm yuborish (galereyadan yoki kameradan).
- Fayl yuborish.
- Ovozli xabar.
- Rasmni to'liq ekranda ko'rish.

### 3.7. Guruh chatlar (3-bosqich)
- Guruh yaratish, a'zo qo'shish/o'chirish.
- Guruh nomi va rasmi.
- Admin huquqlari (oddiy darajada).

### 3.8. Qo'shimcha imkoniyatlar (4-bosqich, ixtiyoriy)
- Push bildirishnomalar.
- Xabarni forward qilish.
- Emoji va stikerlar.
- Xabar ichida qidirish.
- Offlayn rejim: internet bo'lmaganda eski xabarlarni ko'rish.
- Pin qilingan chatlar.

## 4. Nofunksional talablar
- **Tezlik:** chat ro'yxati 1 soniyadan kam vaqtda ochilishi kerak.
- **Real-time:** yangi xabar 1–2 soniya ichida qabul qiluvchida ko'rinishi kerak.
- **Kod sifati:** feature-first papka tuzilmasi, qatlamlarga ajratish (presentation / domain / data).
- **Xavfsizlik:** parollar ochiq saqlanmaydi, Firebase qoidalari (Security Rules) foydalanuvchi faqat o'z chatlarini ko'rishini ta'minlashi kerak.
- **UI:** Telegram'ga o'xshash, lekin nusxa emas. Material 3 dan foydalaniladi.
- **Qurilmalar:** kamida Android 8+.

## 5. Ekranlar ro'yxati
1. Splash ekrani
2. Kirish / Ro'yxatdan o'tish ekrani
3. Profil to'ldirish ekrani
4. Chatlar ro'yxati (bosh ekran)
5. Chat ekrani
6. Foydalanuvchi qidirish ekrani
7. Profil ekrani
8. Sozlamalar ekrani
9. Rasmni to'liq ko'rish ekrani (2-bosqich)
10. Guruh yaratish ekrani (3-bosqich)

## 6. Ma'lumotlar modeli (Firebase Firestore uchun)
Quyidagi tuzilma Firestore da "collection" (jadval o'rniga) va "document" (qator o'rniga) ko'rinishida saqlanadi.

### users — foydalanuvchilar
- `uid` — noyob identifikator
- `name`, `username`, `avatarUrl`
- `isOnline`, `lastSeen`
- `createdAt`

### chats — suhbatlar
- `chatId`
- `type` — private yoki group
- `members` — ishtirokchilar uid ro'yxati
- `lastMessage`, `lastMessageTime`
- `unreadCount` — har bir a'zo uchun alohida

### chats/{chatId}/messages — xabarlar (chat ichidagi ichki collection)
- `messageId`
- `senderId`
- `text`
- `type` — `text`, `image`, `file`, `voice`
- `mediaUrl` (agar bo'lsa)
- `replyTo` (agar javob bo'lsa)
- `status` — `sent`, `delivered`, `read`
- `createdAt`

## 7. Loyiha tuzilmasi (tavsiya)

```text
lib/
├── core/             # umumiy narsalar: tema, konstantalar, yordamchi funksiyalar
├── features/
│   ├── auth/
│   │   ├── data/         # Firebase bilan ishlash
│   │   ├── domain/       # model va repository interfeyslari
│   │   └── presentation/ # ekranlar va bloc
│   ├── chats/
│   ├── chat_room/
│   ├── profile/
│   └── search/
├── app.dart
└── main.dart
```

> **Nima uchun bunday?** Har bir funksiya (feature) o'z papkasida alohida turadi. Shunda loyiha kattalashganda ham adashmaysiz, va bitta funksiyani o'zgartirish boshqasiga ta'sir qilmaydi.

## 8. Ish bosqichlari (yo'l xaritasi)

| Bosqich | Mazmuni | Taxminiy vaqt | Nimani o'rganasiz |
|---|---|---|---|
| 0 | Loyihani yaratish, Firebase ulash, papka tuzilmasi | 2–3 kun | Flutter loyiha tuzilmasi, Firebase sozlash |
| 1 | UI maketlari (backend'siz, soxta ma'lumotlar bilan) | 1–2 hafta | Widget'lar, Layout, ListView, Navigator |
| 2 | Autentifikatsiya | 1 hafta | Firebase Auth, bloc, formalar |
| 3 | Chatlar ro'yxati va foydalanuvchi qidirish | 1 hafta | Firestore, Stream, real-time ma'lumot |
| 4 | Chat ekrani: xabar yuborish/qabul qilish | 2 hafta | Stream, ListView.builder, klaviatura bilan ishlash |
| 5 | Profil, sozlamalar, dark mode | 1 hafta | Theme, SharedPreferences/Hive |
| 6 | Rasm va fayl yuborish | 1–2 hafta | image_picker, Firebase Storage |
| 7 | Guruh chatlar | 2 hafta | Murakkab ma'lumotlar modeli |
| 8 | Push bildirishnomalar, offlayn rejim, tuzatishlar | 1–2 hafta | FCM, lokal kesh |

> **Muhim tavsiya:** 1-bosqichda hamma ekranlarni soxta (mock) ma'lumotlar bilan chizib chiqing. Bu sizga UI ko'nikmasini beradi va keyin backend'ni ulash ancha oson bo'ladi.

## 9. Qabul qilish mezonlari (MVP tayyor bo'ldi deb hisoblash uchun)
- [ ] Foydalanuvchi ro'yxatdan o'ta oladi va tizimga kira oladi.
- [ ] Boshqa foydalanuvchini username bo'yicha topib, chat boshlay oladi.
- [ ] Ikki qurilmada (yoki emulyator + telefon) xabarlar real-time almashiladi.
- [ ] Chatlar ro'yxatida oxirgi xabar va o'qilmagan xabarlar soni to'g'ri ko'rinadi.
- [ ] Ilova yopilib qayta ochilganda sessiya saqlanib qoladi.
- [ ] Dark mode ishlaydi.
- [ ] Ilova crash bo'lmaydi (asosiy ssenariylarda).

## 10. Risklar va maslahatlar
- **Eng katta xato:** hamma narsani birdan qilishga urinish. Avval faqat matnli shaxsiy chatni to'liq ishlating, keyin qo'shimcha funksiyalarga o'ting.
- **Real-time aloqa** boshida murakkab tuyulishi mumkin. Firebase buni sizning o'rningizga hal qiladi.
- **Firebase narxi:** o'quv loyiha uchun bepul tarif (Spark) yetarli.
- **Telegram'ning logotipi va dizaynini to'g'ridan-to'g'ri nusxalamang:** o'z rang va ikonkalaringizni tanlang, chunki bu o'quv loyiha va portfolioga qo'yilsa, o'zingizniki bo'lishi yaxshi.
- **Har bir bosqich oxirida kodni GitHub'ga push qiling:** bu portfolio uchun ham foydali.

## 11. Keyingi qadam
Birinchi bosqichdan boshlang: Flutter loyihasini yarating, papka tuzilmasini tuzing va chatlar ro'yxati ekranini soxta ma'lumotlar bilan chizing.
