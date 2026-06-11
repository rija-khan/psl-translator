import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

class PslBottomNavigation extends StatelessWidget {
  const PslBottomNavigation({
    required this.selectedIndex,
    required this.onChanged,
    required this.onSettings,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final VoidCallback onSettings;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE5E7EB))),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: [
              Expanded(
                child: _BottomItem(
                  icon: Icons.home,
                  label: l10n.home,
                  selected: selectedIndex == 0,
                  onTap: () => onChanged(0),
                ),
              ),
              Expanded(
                child: _BottomItem(
                  icon: Icons.menu_book,
                  label: l10n.learn,
                  selected: selectedIndex == 3,
                  onTap: () => onChanged(3),
                ),
              ),
              Expanded(
                child: _BottomItem(
                  icon: Icons.settings,
                  label: l10n.settings,
                  selected: false,
                  onTap: onSettings,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomItem extends StatelessWidget {
  const _BottomItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? const Color(0xFF10B981) : const Color(0xFF6B7280);
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 5,
            child: selected
                ? Container(
                    width: 29,
                    height: 2,
                    margin: const EdgeInsets.only(bottom: 3),
                    color: const Color(0xFF10B981),
                  )
                : null,
          ),
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 3),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
