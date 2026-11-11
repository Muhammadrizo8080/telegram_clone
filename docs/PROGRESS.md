# Loyiha rivojlanish bosqichlari (Progress Tracking)

Bu faylda Telegram Clone loyihasining barcha 5 ta asosiy bosqichlari va ularning holati qayd etib boriladi.

---

## ✅ 0-Bosqich: Loyiha poydevori va sozlash (Setup) — TUGALLANDI
- [x] Flutter loyihasini yaratish (`telegram_clone`)
- [x] Git repozitoriy va `.gitignore` sozlash
- [x] Texnik topshiriq (`docs/TZ.md`) kiritilishi
- [x] Feature-first papkalar tuzilmasi (`core/`, `features/*/{data,models,presentation}`)
- [x] `intl` paketi ulandi
- [x] `AppColors` va `AppDimensions` konstantalari (`core/constants/app_constants.dart`)
- [x] Material 3 Light va Dark mavzulari (`core/theme/app_theme.dart`)
- [x] Vaqt formatlash yordamchisi (`core/utils/date_utils.dart`)
- [x] Qo'lda yozilgan `User`, `Chat`, `Message` modellari (`fromJson`, `toJson`, `copyWith`)
- [x] O'zbekcha va inglizcha realistik mock ma'lumotlar (`mock_chats.dart`, `mock_messages.dart`)
- [x] Bo'sh placeholder sahifalar (`SplashPage`, `LoginPage`, `ChatsPage`, `ChatPage`, `ProfilePage`, `SettingsPage`)
- [x] Boshlang'ich `TelegramApp` smoke testi va date utils testi
- [x] `flutter analyze` va `flutter test` muvaffaqiyatli o'tishi

---

## ✅ 1-Bosqich: Soxta (mock) ma'lumotlar bilan UI maketlari — TUGALLANDI
- [x] `ChatsPage`: `ListView.separated`, `TelegramChatTile` (avatar, ism, oxirgi xabar, vaqt, o'qilmagan xabarlar soni)
- [x] `ChatPage`: Shaxsiy chat ekrani, xabarlar ro'yxati (kiruvchi va chiquvchi xabar pufakchalari - bubbles, sana ajratkichlari)
- [x] Xabar yuborish maydoni (`TelegramChatInputBar`: TextField, yuborish/ovoz tugmasi, emoji, fayl qisqichi)
- [x] `ChatsPage` dan `ChatPage` ga Telegram uslubida o'tish
- [x] `ProfilePage`: Foydalanuvchi ma'lumotlari, katta avatar, tezkor amallar, bio va media bo'limi
- [x] `SettingsPage`: Sozlamalar menyusi (akkaunt kartochkasi, bo'limlar va mavzu o'zgartirish tugmasi bilan)
- [x] Chatlar ro'yxatida ism va xabar bo'yicha jonli qidiruv (Search)
- [x] Telegram yon menyusi (Drawer: profil sarlavhasi, menyular ro'yxati, tungi rejim)
- [x] 36 ta keng qamrovli unit va widget testlar muvaffaqiyatli o'tishi

---

## 🔲 2-Bosqich: Holatni boshqarish (State Management)
- [ ] Holat boshqarish kutubxonasini tanlash (`flutter_bloc` yoki `Riverpod`)
- [ ] Autentifikatsiya holatini boshqarish (Login / Logout)
- [ ] Chatlar va yangi xabar yuborish holatini reaktiv yangilash
- [ ] Yorug' va qorong'i rejim (Theme mode) holatini boshqarish

---

## 🔲 3-Bosqich: Lokal xotira (Local Storage & Offline Mode)
- [ ] Lokal kesh kutubxonasini ulash (`Hive` yoki `Drift`)
- [ ] Chatlar va xabarlarni oflayn ko'rish uchun saqlash
- [ ] Oxirgi sessiya holatini eslab qolish

---

## ⏸️ 4-Bosqich: Haqiqiy backend (Firebase) — Postponed (Developer will do it himself later)
> [!NOTE]
> Backend (Firebase) is out of scope for now: the developer will integrate it later by himself.

- [ ] Firebase loyihasini yaratish va ulash (Firebase Auth, Cloud Firestore)
- [ ] Real-time xabarlar oqimi (`StreamBuilder` / Firestore snapshots)
- [ ] Firebase Storage: avatar va rasmlar yuklash
- [ ] Firebase Cloud Messaging (FCM) orqali push-bildirishnomalar

---

## 🔲 5-Bosqich: Yakunlash, xatolarni ushlash va nashr
- [ ] Internet yo'qligi va xatolik holatlari uchun chiroyli xabarlar (Empty / Error states)
- [ ] Android uchun reliz yig'ish (`flutter build apk`)
- [ ] Yakuniy hujjatlar va GitHub repozitoriyaga joylash
