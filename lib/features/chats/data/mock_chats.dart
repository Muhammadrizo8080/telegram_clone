import '../../auth/models/user.dart';
import '../models/chat.dart';

/// The currently logged-in mock user.
const currentUser = User(
  id: 'user_me',
  name: 'Muhammadrizo',
  phone: '+998 90 123 45 67',
  email: 'muhammadrizo@example.com',
  avatarUrl: null,
);

/// Helper to generate mock dates relative to current time.
DateTime _nowMinus({int days = 0, int hours = 0, int minutes = 0}) {
  return DateTime.now().subtract(
    Duration(days: days, hours: hours, minutes: minutes),
  );
}

/// Realistic mock chat dialogs with Uzbek and international names.
final List<Chat> mockChats = [
  Chat(
    id: 'chat_1',
    title: 'Anvar Karimov',
    participantIds: const ['user_me', 'user_anvar'],
    lastMessage: 'Salom! Bugun darsdan keyin uchrashamizmi?',
    lastMessageTime: _nowMinus(minutes: 15),
    unreadCount: 2,
  ),
  Chat(
    id: 'chat_2',
    title: 'Flutter Developers UZ',
    participantIds: const ['user_me', 'user_anvar', 'user_nodir', 'user_sarah'],
    lastMessage: 'Yangi Flutter versiyasidagi o‘zgarishlarni ko‘rdingizmi?',
    lastMessageTime: _nowMinus(hours: 1, minutes: 20),
    unreadCount: 5,
  ),
  Chat(
    id: 'chat_3',
    title: 'Sarah Jenkins',
    participantIds: const ['user_me', 'user_sarah'],
    lastMessage: 'The new design assets have been updated in Figma.',
    lastMessageTime: _nowMinus(hours: 3),
    unreadCount: 0,
  ),
  Chat(
    id: 'chat_4',
    title: 'Nodirbek Rustamov',
    participantIds: const ['user_me', 'user_nodir'],
    lastMessage: 'Hujjatlarni pochtangizga yuborib qo‘ydim.',
    lastMessageTime: _nowMinus(days: 1, hours: 2),
    unreadCount: 0,
  ),
  Chat(
    id: 'chat_5',
    title: 'Alex Rivers',
    participantIds: const ['user_me', 'user_alex'],
    lastMessage: 'Can we sync up tomorrow around 10 AM?',
    lastMessageTime: _nowMinus(days: 2, hours: 5),
    unreadCount: 1,
  ),
  Chat(
    id: 'chat_6',
    title: 'Dilshodbek Mahmudov',
    participantIds: const ['user_me', 'user_dilshod'],
    lastMessage: 'Ertaga kechki payt futbolga boramizmi?',
    lastMessageTime: _nowMinus(days: 3),
    unreadCount: 0,
  ),
  Chat(
    id: 'chat_7',
    title: 'Elena Petrova',
    participantIds: const ['user_me', 'user_elena'],
    lastMessage: 'Спасибо за подробное ревью кода!',
    lastMessageTime: _nowMinus(days: 4, hours: 4),
    unreadCount: 0,
  ),
  Chat(
    id: 'chat_8',
    title: 'Jasur Mirzayev',
    participantIds: const ['user_me', 'user_jasur'],
    lastMessage: 'Loyiha arxitekturasi juda yaxshi tuzilibdi.',
    lastMessageTime: _nowMinus(days: 5),
    unreadCount: 0,
  ),
  Chat(
    id: 'chat_9',
    title: 'Telegram Notifications',
    participantIds: const ['user_me', 'system_telegram'],
    lastMessage: 'Yangi qurilmadan tizimga kirish qayd etildi (Linux Ubuntu).',
    lastMessageTime: _nowMinus(days: 6),
    unreadCount: 1,
  ),
  Chat(
    id: 'chat_10',
    title: 'Tech Book Club',
    participantIds: const ['user_me', 'user_alex', 'user_sarah'],
    lastMessage: 'We will be discussing chapter 4 this weekend.',
    lastMessageTime: _nowMinus(days: 7),
    unreadCount: 0,
  ),
];
