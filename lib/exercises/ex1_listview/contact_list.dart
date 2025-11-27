// This is the contact list screen for the midterm exam app. - Phone Number
import 'package:flutter/material.dart';
import 'package:midterm_exam/utils/constants.dart';

class Contact {
  String name;
  String phone;
  String image;
  Contact(this.name, this.phone, this.image);
}

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final contacts = [
    Contact("Nguyễn Văn An", "0123 456 789", "goat.jpg"),
    Contact("Trần Thị Bình", "0988 111 222", "horse.jpg"),
    Contact("Lê Minh Châu", "0933 555 999", "penguin.jpg"),

    Contact("Phạm Văn Dũng", "0123 456 780", "wolf.jpg"),
    Contact("Hoàng Thị Hạnh", "0988 111 223", "horse.jpg"),
    Contact("Vũ Anh Khoa", "0933 555 998", "unicorn.jpg"),

    Contact("Đặng Thị Lan", "0123 456 781", "goat.jpg"),
    Contact("Ngô Văn Long", "0988 111 224", "horse.jpg"),
    Contact("Lý Thị Mai", "0933 555 997", "unicorn.jpg"),

    Contact("Trương Minh Nam", "0123 456 782", "goat.jpg"),
    Contact("Bùi Thị Nhung", "0988 111 225", "horse.jpg"),
    Contact("Phan Văn Phúc", "0933 555 996", "wolf.jpg"),

    Contact("Đỗ Thị Quỳnh", "0123 456 783", "goat.jpg"),
    Contact("Lâm Văn Sơn", "0988 111 226", "horse.jpg"),
    Contact("Hoàng Thị Thanh", "0933 555 995", "wolf.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.themeSecondary,
      appBar: AppBar(
        title: const Text(
          "Danh Bạ Điện Thoại",
          style: TextStyle(color: AppColors.secondaryText),
        ),
        backgroundColor: AppColors.themePrimary,
        elevation: 0,
      ),
      // Using ListView.builder for better performance with long lists
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];

          // Each contact item is a card-like container [modify for better UI]
          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            // InkWell for tap effect on the entire contact item
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 16,
                ),
                child: Row(
                  children: [
                    // Better to use actual images in a real app
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: AppColors.primaryText,
                      backgroundImage: AssetImage(
                        'assets/images/${contact.image}',
                      ),
                    ),

                    const SizedBox(width: 16),

                    // Name + phone
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            contact.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryText,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            contact.phone,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Button Calling
                    IconButton(
                      icon: const Icon(
                        Icons.call,
                        color: AppColors.themePrimary,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
