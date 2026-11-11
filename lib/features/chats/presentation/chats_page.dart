import 'package:flutter/material.dart';

import '../../messages/data/mock_messages.dart';
import '../../messages/models/message.dart';
import '../../messages/presentation/chat_page.dart';
import '../data/mock_chats.dart';
import '../models/chat.dart';
import 'widgets/telegram_chat_tile.dart';
import 'widgets/telegram_drawer.dart';

/// Chats page representing Telegram's main screen with search and dialog list.
class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key, this.chats});

  /// The list of chats to display. Defaults to realistic [mockChats].
  final List<Chat>? chats;

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch() {
    setState(() {
      _isSearching = false;
      _searchController.clear();
    });
  }

  List<Chat> get _allChats => widget.chats ?? mockChats;

  List<Chat> _getFilteredChats() {
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      return _allChats;
    }
    return _allChats.where((chat) {
      final titleMatch = chat.title?.toLowerCase().contains(query) ?? false;
      final messageMatch = chat.lastMessage.toLowerCase().contains(query);
      return titleMatch || messageMatch;
    }).toList();
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    if (_isSearching) {
      return AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
          onPressed: _stopSearch,
        ),
        title: TextField(
          controller: _searchController,
          autofocus: true,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
          cursorColor: Colors.white,
          decoration: const InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.white70, fontSize: 18),
            border: InputBorder.none,
          ),
          onChanged: (_) {
            setState(() {});
          },
        ),
        actions: [
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.close),
              tooltip: 'Clear',
              onPressed: () {
                setState(() {
                  _searchController.clear();
                });
              },
            ),
        ],
      );
    }

    return AppBar(
      leading: Builder(
        builder: (innerContext) => IconButton(
          icon: const Icon(Icons.menu),
          tooltip: 'Menu',
          onPressed: () {
            Scaffold.of(innerContext).openDrawer();
          },
        ),
      ),
      title: const Text('Telegram'),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          tooltip: 'Search',
          onPressed: _startSearch,
        ),
      ],
    );
  }

  Message? _getLastMessageForChat(String chatId) {
    final matching = mockMessages.where((m) => m.chatId == chatId).toList();
    if (matching.isEmpty) return null;
    matching.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return matching.last;
  }

  @override
  Widget build(BuildContext context) {
    final displayedChats = _getFilteredChats();

    return Scaffold(
      appBar: _buildAppBar(context),
      drawer: const TelegramDrawer(),
      floatingActionButton: FloatingActionButton(
        tooltip: 'New Message',
        elevation: 3.0,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Yangi xabar boshlash'),
              duration: Duration(seconds: 1),
            ),
          );
        },
        child: const Icon(Icons.edit_rounded, color: Colors.white, size: 24.0),
      ),
      body: displayedChats.isEmpty
          ? Center(
              child: Text(
                _isSearching ? 'No chats found' : 'No messages yet',
                style: const TextStyle(color: Colors.grey, fontSize: 16.0),
              ),
            )
          : ListView.separated(
              itemCount: displayedChats.length,
              separatorBuilder: (context, index) => const Divider(
                indent: 82.0,
                endIndent: 0,
                height: 1.0,
                thickness: 0.6,
              ),
              itemBuilder: (context, index) {
                final chat = displayedChats[index];
                final lastMessage = _getLastMessageForChat(chat.id);
                final isOutgoing =
                    lastMessage != null &&
                    lastMessage.senderId == currentUser.id;
                final messageStatus = isOutgoing ? lastMessage.status : null;

                return TelegramChatTile(
                  chat: chat,
                  isLastMessageOutgoing: isOutgoing,
                  lastMessageStatus: messageStatus,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ChatPage(chat: chat)),
                    );
                  },
                );
              },
            ),
    );
  }
}
