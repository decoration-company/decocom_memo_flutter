import 'package:decocom_memo_flutter/features/instagram/domain/instagram_models.dart';
import 'package:flutter/material.dart';

class AccountTabs extends StatelessWidget {
  const AccountTabs({
    required this.activeAccount,
    required this.onTap,
    super.key,
  });

  final InstagramAccount activeAccount;
  final ValueChanged<InstagramAccount> onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 92,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          final account = InstagramAccount.values[index];
          final isActive = account == activeAccount;
          return InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () => onTap(account),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 136,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isActive
                      ? const Color(0xFFFF6B9D)
                      : const Color(0xFFE8E8EC),
                  width: 1.4,
                ),
                gradient: isActive
                    ? const LinearGradient(
                        colors: <Color>[Color(0xFFFF6B9D), Color(0xFFE84A7F)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: isActive ? null : Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    account.label,
                    style: TextStyle(
                      color: isActive ? Colors.white : const Color(0xFF3A3A42),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    account.subLabel,
                    style: TextStyle(
                      color: isActive
                          ? Colors.white.withValues(alpha: 0.9)
                          : const Color(0xFF8C8C99),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemCount: InstagramAccount.values.length,
      ),
    );
  }
}
