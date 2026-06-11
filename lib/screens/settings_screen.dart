import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/auth_service.dart';
import '../theme/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    required this.authService,
    required this.onSignedOut,
    super.key,
  });

  final AuthService authService;
  final VoidCallback onSignedOut;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  LocalUser? _user;
  bool _isLoading = true;
  bool _isDeleting = false;

  // Settings state
  String _audioLanguage = 'English';
  String _contentLanguage = 'English';
  bool _autoPlayAudio = true;

  static const List<String> _languages = [
    'English',
    'Urdu',
    'Sindhi',
    'Punjabi',
    'Pashto',
  ];

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await widget.authService.currentUser();
    if (!mounted) return;
    setState(() {
      _user = user;
      _isLoading = false;
    });
  }

  Future<void> _logout() async {
    await widget.authService.logout();
    if (!mounted) return;
    widget.onSignedOut();
  }

  Future<void> _confirmDelete() async {
    final l10n = AppLocalizations.of(context)!;
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.settingsDeleteTitle),
        content: Text(l10n.settingsDeleteBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.settingsCancel),
          ),
          FilledButton.icon(
            onPressed: () => Navigator.of(context).pop(true),
            icon: const Icon(Icons.delete_outline),
            label: Text(l10n.settingsDelete),
          ),
        ],
      ),
    );
    if (shouldDelete != true || !mounted) return;
    setState(() => _isDeleting = true);
    await widget.authService.deleteCurrentAccount();
    if (!mounted) return;
    widget.onSignedOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Semi-transparent background replicates the modal overlay look
      backgroundColor: Colors.black.withValues(alpha: .35),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: _isLoading
                ? const CircularProgressIndicator(color: AppTheme.primary)
                : _SettingsCard(
                    user: _user,
                    audioLanguage: _audioLanguage,
                    contentLanguage: _contentLanguage,
                    autoPlayAudio: _autoPlayAudio,
                    languages: _languages,
                    isDeleting: _isDeleting,
                    onAudioLanguageChanged: (v) =>
                        setState(() => _audioLanguage = v),
                    onContentLanguageChanged: (v) =>
                        setState(() => _contentLanguage = v),
                    onAutoPlayChanged: (v) =>
                        setState(() => _autoPlayAudio = v),
                    onClose: () => Navigator.of(context).pop(),
                    onLogout: _logout,
                    onDeleteAccount: _isDeleting ? null : _confirmDelete,
                  ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// The floating white card
// ─────────────────────────────────────────────────────────────────────────────
class _SettingsCard extends StatelessWidget {
  const _SettingsCard({
    required this.user,
    required this.audioLanguage,
    required this.contentLanguage,
    required this.autoPlayAudio,
    required this.languages,
    required this.isDeleting,
    required this.onAudioLanguageChanged,
    required this.onContentLanguageChanged,
    required this.onAutoPlayChanged,
    required this.onClose,
    required this.onLogout,
    required this.onDeleteAccount,
  });

  final LocalUser? user;
  final String audioLanguage;
  final String contentLanguage;
  final bool autoPlayAudio;
  final List<String> languages;
  final bool isDeleting;
  final ValueChanged<String> onAudioLanguageChanged;
  final ValueChanged<String> onContentLanguageChanged;
  final ValueChanged<bool> onAutoPlayChanged;
  final VoidCallback onClose;
  final VoidCallback onLogout;
  final VoidCallback? onDeleteAccount;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 460),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .18),
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Top bar: title + ✕ ───────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 22, 16, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  l10n.settingsTitle,
                  style: const TextStyle(
                    color: AppTheme.textDark,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: onClose,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.close, color: AppTheme.textDark, size: 20),
                  ),
                ),
              ],
            ),
          ),

          // ── Green settings row ───────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 14, 22, 10),
            child: Row(
              children: [
                const Icon(Icons.settings_rounded, color: AppTheme.primary, size: 20),
                const SizedBox(width: 8),
                Text(
                  l10n.settingsLabel,
                  style: const TextStyle(
                    color: AppTheme.primary,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: Color(0xFFE5E7EB)),

          // ── Default Audio Language ───────────────────────────────────────
          _DropdownRow(
            label: l10n.settingsDefaultAudioLanguage,
            value: audioLanguage,
            items: languages,
            onChanged: onAudioLanguageChanged,
          ),

          const Divider(height: 1, color: Color(0xFFE5E7EB), indent: 22, endIndent: 22),

          // ── Default Content Language ─────────────────────────────────────
          _DropdownRow(
            label: l10n.settingsDefaultContentLanguage,
            value: contentLanguage,
            items: languages,
            onChanged: onContentLanguageChanged,
          ),

          const Divider(height: 1, color: Color(0xFFE5E7EB), indent: 22, endIndent: 22),

          // ── Sign Language Type (static info row) ─────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.settingsSignLanguageType,
                    style: const TextStyle(
                      color: AppTheme.textDark,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  l10n.settingsSignLanguageValue,
                  style: const TextStyle(
                    color: AppTheme.textMuted,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: Color(0xFFE5E7EB), indent: 22, endIndent: 22),

          // ── Auto-Play Audio ──────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 4),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.settingsAutoPlayAudio,
                    style: const TextStyle(
                      color: AppTheme.textDark,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  autoPlayAudio ? l10n.settingsOn : l10n.settingsOff,
                  style: const TextStyle(
                    color: AppTheme.textMuted,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(width: 8),
                Switch(
                  value: autoPlayAudio,
                  onChanged: onAutoPlayChanged,
                  activeColor: AppTheme.primary,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: Color(0xFFE5E7EB)),

          // ── User profile row (if available) ─────────────────────────────
          if (user != null) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 16, 22, 4),
              child: Row(
                children: [
                  const Icon(Icons.person_rounded, color: AppTheme.primary, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    l10n.settingsAccount,
                    style: const TextStyle(
                      color: AppTheme.primary,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Color(0xFFE5E7EB)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: AppTheme.surfaceTint,
                    child: Text(
                      (user!.username.isNotEmpty ? user!.username[0] : '?').toUpperCase(),
                      style: const TextStyle(
                        color: AppTheme.primary,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user!.username,
                          style: const TextStyle(
                            color: AppTheme.textDark,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          user!.email,
                          style: const TextStyle(
                            color: AppTheme.textMuted,
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Color(0xFFE5E7EB)),
          ],

          // ── Logout ───────────────────────────────────────────────────────
          _ActionRow(
            icon: Icons.logout_rounded,
            label: l10n.settingsLogout,
            subtitle: l10n.settingsLogoutSubtitle,
            iconColor: AppTheme.primary,
            textColor: AppTheme.textDark,
            onTap: onLogout,
          ),

          const Divider(height: 1, color: Color(0xFFE5E7EB), indent: 22, endIndent: 22),

          // ── Delete Account ───────────────────────────────────────────────
          _ActionRow(
            icon: Icons.delete_outline_rounded,
            label: l10n.settingsDeleteAccount,
            subtitle: l10n.settingsDeleteSubtitle,
            iconColor: Colors.red,
            textColor: Colors.red,
            trailing: isDeleting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.red),
                  )
                : null,
            onTap: onDeleteAccount,
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Dropdown row (audio/content language)
// ─────────────────────────────────────────────────────────────────────────────
class _DropdownRow extends StatelessWidget {
  const _DropdownRow({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String label;
  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: AppTheme.textDark,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isDense: true,
                icon: const Icon(Icons.keyboard_arrow_down_rounded,
                    color: AppTheme.textDark, size: 18),
                style: const TextStyle(
                  color: AppTheme.textDark,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                items: items
                    .map((lang) => DropdownMenuItem(
                          value: lang,
                          child: Text(lang),
                        ))
                    .toList(),
                onChanged: (v) {
                  if (v != null) onChanged(v);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Action row (Logout / Delete Account)
// ─────────────────────────────────────────────────────────────────────────────
class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.iconColor,
    required this.textColor,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final String subtitle;
  final Color iconColor;
  final Color textColor;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppTheme.textMuted,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            trailing ??
                Icon(Icons.chevron_right_rounded, color: textColor, size: 20),
          ],
        ),
      ),
    );
  }
}
