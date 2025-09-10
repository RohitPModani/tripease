import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:gal/gal.dart';
import '../../models/trip.dart';
import '../../models/booking.dart';
import '../../models/attachment.dart';
import '../../themes/app_theme.dart';
import '../../providers/booking_provider.dart';
import '../../widgets/booking_form_modal.dart';
import '../../widgets/document_viewer.dart';
import '../../l10n/app_localizations.dart';
import '../../utils/currency_formatter.dart';
import '../../utils/snackbar.dart';

class BookingsTab extends StatefulWidget {
  final Trip trip;

  const BookingsTab({super.key, required this.trip});

  @override
  State<BookingsTab> createState() => _BookingsTabState();
}

class _BookingsTabState extends State<BookingsTab> {
  String _searchQuery = '';
  BookingType? _selectedType;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BookingProvider>(context, listen: false).loadBookings(widget.trip.id);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Booking> _getFilteredBookings(List<Booking> bookings) {
    List<Booking> filtered = bookings;
    
    // Filter by type
    if (_selectedType != null) {
      filtered = filtered.where((booking) => booking.type == _selectedType).toList();
    }
    
    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      filtered = filtered.where((booking) {
        return booking.title.toLowerCase().contains(query) ||
               booking.description.toLowerCase().contains(query) ||
               booking.vendor.toLowerCase().contains(query) ||
               booking.confirmationNumber.toLowerCase().contains(query);
      }).toList();
    }
    
    return filtered;
  }

  List<Booking> _getSortedBookings(List<Booking> bookings) {
    final filtered = _getFilteredBookings(bookings);
    filtered.sort((a, b) {
      // Sort by status (confirmed first)
      if (a.status != b.status) {
        final statusOrder = [
          BookingStatus.confirmed,
          BookingStatus.pending,
          BookingStatus.cancelled,
        ];
        return statusOrder.indexOf(a.status).compareTo(statusOrder.indexOf(b.status));
      }
      // Then by date
      if (a.bookingDate != null && b.bookingDate != null) {
        return a.bookingDate!.compareTo(b.bookingDate!);
      } else if (a.bookingDate != null) {
        return -1;
      } else if (b.bookingDate != null) {
        return 1;
      }
      return 0;
    });
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(
      builder: (context, bookingProvider, child) {
        if (bookingProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppTheme.primaryColor,
            ),
          );
        }

        final sortedBookings = _getSortedBookings(bookingProvider.bookings);

        return Scaffold(
          body: Column(
            children: [
              if (bookingProvider.bookings.isNotEmpty) ...[
                _buildSearchAndFilters(bookingProvider.bookings),
              ],
              Expanded(
                child: bookingProvider.bookings.isEmpty
                    ? _buildEmptyState(bookingProvider)
                    : sortedBookings.isEmpty && (_searchQuery.isNotEmpty || _selectedType != null)
                        ? _buildNoResultsState()
                        : RefreshIndicator(
                            onRefresh: () => bookingProvider.loadBookings(widget.trip.id),
                            color: AppTheme.primaryColor,
                            child: ListView.builder(
                              padding: const EdgeInsets.all(16),
                              itemCount: sortedBookings.length,
                              itemBuilder: (context, index) {
                                return _buildBookingItem(sortedBookings[index], bookingProvider);
                              },
                            ),
                          ),
              ),
            ],
          ),
          floatingActionButton: Container(
            decoration: AppTheme.glowingButtonDecoration,
            child: FloatingActionButton.extended(
              onPressed: () => _showAddBookingDialog(bookingProvider),
              icon: const Icon(Iconsax.add),
              label: Text(
                AppLocalizations.of(context)!.addBooking,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              elevation: 0,
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(BookingProvider bookingProvider) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.secondaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Iconsax.airplane,
                size: 48,
                color: AppTheme.secondaryColor,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              AppLocalizations.of(context)!.noBookingsYet,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.keepTrackMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.textSecondaryDark
                    : AppTheme.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              decoration: AppTheme.glowingButtonDecoration,
              child: ElevatedButton.icon(
                onPressed: () => _showAddBookingDialog(bookingProvider),
                icon: const Icon(Iconsax.add),
                label: Text(
                  AppLocalizations.of(context)!.addFirstBooking,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingItem(Booking booking, BookingProvider bookingProvider) {
    return Dismissible(
      key: Key(booking.id),
      direction: DismissDirection.horizontal,
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          // Delete action
          return await _showDeleteConfirmation(booking, bookingProvider);
        } else if (direction == DismissDirection.startToEnd) {
          // Edit action - don't dismiss, just open edit dialog
          _showEditBookingDialog(booking, bookingProvider);
          return false;
        }
        return false;
      },
      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Iconsax.edit_2,
                  color: Colors.white,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  AppLocalizations.of(context)!.edit,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      secondaryBackground: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppTheme.error,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppLocalizations.of(context)!.delete,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Iconsax.trash,
                  color: Colors.white,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppTheme.surfaceDark
              : AppTheme.surfaceLight,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _getTypeColor(booking.type).withValues(alpha: 0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              offset: const Offset(0, 2),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _showBookingDetailsBottomSheet(booking, bookingProvider),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _getTypeColor(booking.type).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getTypeIcon(booking.type),
                    color: _getTypeColor(booking.type),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            booking.type.getDisplayName(AppLocalizations.of(context)!),
                            style: TextStyle(
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? AppTheme.textSecondaryDark
                                  : AppTheme.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                          if (booking.bookingDate != null) ...[
                            const SizedBox(width: 8),
                            Icon(
                              Iconsax.calendar_1,
                              size: 12,
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? AppTheme.textSecondaryDark
                                  : AppTheme.textSecondary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${booking.bookingDate!.day}/${booking.bookingDate!.month}/${booking.bookingDate!.year}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).brightness == Brightness.dark
                                  ? AppTheme.textSecondaryDark
                                  : AppTheme.textSecondary,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (booking.attachments.isNotEmpty) ...[
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: AppTheme.primaryColor.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Icon(
                          Iconsax.attach_circle,
                          color: AppTheme.primaryColor,
                          size: 14,
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusColor(booking.status).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _getStatusColor(booking.status).withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        booking.status.getDisplayName(AppLocalizations.of(context)!),
                        style: TextStyle(
                          color: _getStatusColor(booking.status),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showBookingDetailsBottomSheet(Booking booking, BookingProvider bookingProvider) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.75,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppTheme.surfaceDark
              : AppTheme.surfaceLight,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: (Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.textSecondaryDark
                    : AppTheme.textSecondary).withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: _getTypeColor(booking.type).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            _getTypeIcon(booking.type),
                            color: _getTypeColor(booking.type),
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.bookingDetails,
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                booking.type.getDisplayName(AppLocalizations.of(context)!),
                                style: TextStyle(
                                  color: _getTypeColor(booking.type),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      AppLocalizations.of(context)!.title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      booking.title,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    if (booking.description.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      Text(
                        AppLocalizations.of(context)!.description,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        booking.description,
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.textSecondaryDark
                    : AppTheme.textSecondary,
                          height: 1.4,
                        ),
                      ),
                    ],
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.status,
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(booking.status).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: _getStatusColor(booking.status).withValues(alpha: 0.3),
                                  ),
                                ),
                                child: Text(
                                  booking.status.getDisplayName(AppLocalizations.of(context)!),
                                  style: TextStyle(
                                    color: _getStatusColor(booking.status),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (booking.bookingDate != null) ...[
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.date,
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(
                                      Iconsax.calendar_1,
                                      size: 16,
                                      color: Theme.of(context).brightness == Brightness.dark
                                  ? AppTheme.textSecondaryDark
                                  : AppTheme.textSecondary,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      '${booking.bookingDate!.day}/${booking.bookingDate!.month}/${booking.bookingDate!.year}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                    if (booking.vendor.isNotEmpty || booking.confirmationNumber.isNotEmpty || booking.amount > 0) ...[
                      const SizedBox(height: 20),
                      if (booking.vendor.isNotEmpty) ...[
                        Text(
                          AppLocalizations.of(context)!.vendor,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(booking.vendor),
                        const SizedBox(height: 12),
                      ],
                      if (booking.confirmationNumber.isNotEmpty) ...[
                        Text(
                          AppLocalizations.of(context)!.confirmationNumber,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(booking.confirmationNumber),
                        const SizedBox(height: 12),
                      ],
                      if (booking.amount > 0) ...[
                        Text(
                          AppLocalizations.of(context)!.amount,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          CurrencyFormatter.formatAmount(booking.amount, widget.trip.defaultCurrency),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ],
                    // Attachments Section
                    if (booking.attachments.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      Text(
                        AppLocalizations.of(context)!.attachments,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...booking.attachments.map((attachment) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppTheme.primaryColor.withValues(alpha: 0.2),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                attachment.isPdf ? Iconsax.document_text :
                                attachment.isImage ? Iconsax.image :
                                Iconsax.document,
                                color: AppTheme.primaryColor,
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      attachment.fileName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      attachment.displaySize,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Theme.of(context).brightness == Brightness.dark
                                  ? AppTheme.textSecondaryDark
                                  : AppTheme.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () => _viewAttachment(attachment),
                                icon: Icon(
                                  Iconsax.eye,
                                  color: AppTheme.primaryColor,
                                  size: 26,
                                ),
                                tooltip: AppLocalizations.of(context)!.view,
                              ),
                              IconButton(
                                onPressed: () => _downloadAttachment(attachment),
                                icon: Icon(
                                  Iconsax.document_download,
                                  color: AppTheme.secondaryColor,
                                  size: 24,
                                ),
                                tooltip: AppLocalizations.of(context)!.download,
                              ),
                              IconButton(
                                onPressed: () => _shareAttachment(attachment),
                                icon: Icon(
                                  Iconsax.share,
                                  color: AppTheme.accentColor,
                                  size: 24,
                                ),
                                tooltip: AppLocalizations.of(context)!.share,
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                              _showEditBookingDialog(booking, bookingProvider);
                            },
                            icon: const Icon(Iconsax.edit_2),
                            label: Text(AppLocalizations.of(context)!.edit),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              Navigator.pop(context);
                              await bookingProvider.deleteBooking(booking.id);
                            },
                            icon: const Icon(Iconsax.trash),
                            label: Text(AppLocalizations.of(context)!.delete),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.error,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Color _getTypeColor(BookingType type) {
    switch (type) {
      case BookingType.flight:
        return Colors.blue;
      case BookingType.hotel:
        return Colors.purple;
      case BookingType.activity:
        return Colors.orange;
      case BookingType.transport:
        return Colors.green;
      case BookingType.restaurant:
        return Colors.red;
      case BookingType.other:
        return Theme.of(context).brightness == Brightness.dark
            ? AppTheme.textSecondaryDark
            : AppTheme.textSecondary;
    }
  }

  IconData _getTypeIcon(BookingType type) {
    switch (type) {
      case BookingType.flight:
        return Iconsax.airplane;
      case BookingType.hotel:
        return Iconsax.building_4;
      case BookingType.activity:
        return Iconsax.camera;
      case BookingType.transport:
        return Iconsax.car;
      case BookingType.restaurant:
        return Iconsax.cup;
      case BookingType.other:
        return Iconsax.bookmark;
    }
  }

  Color _getStatusColor(BookingStatus status) {
    switch (status) {
      case BookingStatus.confirmed:
        return Colors.green;
      case BookingStatus.pending:
        return Colors.orange;
      case BookingStatus.cancelled:
        return AppTheme.error;
    }
  }

  Future<void> _viewAttachment(BookingAttachment attachment) async {
    DocumentViewer.show(context, attachment);
  }

  Future<void> _downloadAttachment(BookingAttachment attachment) async {
    try {
      final file = File(attachment.filePath);
      if (!await file.exists()) {
        if (!mounted) return;
        showAppSnackBar(context, AppLocalizations.of(context)!.fileNotFound, type: SnackBarType.error);
        return;
      }

      // For images, offer choice between gallery and file save
      if (attachment.isImage) {
        await _showImageDownloadOptions(attachment, file);
      } else {
        // For documents, use file save dialog
        await _saveFileWithDialog(attachment, file);
      }
    } catch (e) {
      if (!mounted) return;
      showAppSnackBar(
        context,
        AppLocalizations.of(context)!.errorDownloadingFile(e.toString()),
        type: SnackBarType.error,
      );
    }
  }

  Future<void> _showImageDownloadOptions(BookingAttachment attachment, File file) async {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: (Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.textSecondaryDark
                    : AppTheme.textSecondary).withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 24),
            Text(
              AppLocalizations.of(context)!.download,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 24),
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Iconsax.gallery, color: AppTheme.primaryColor),
              ),
              title: Text(AppLocalizations.of(context)!.saveToPhotos),
              subtitle: Text(AppLocalizations.of(context)!.saveToPhotosDescription),
              onTap: () async {
                Navigator.pop(context);
                await _saveToGallery(attachment, file);
              },
            ),
            SizedBox(height: 8),
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.secondaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Iconsax.folder, color: AppTheme.secondaryColor),
              ),
              title: Text(AppLocalizations.of(context)!.saveToFiles),
              subtitle: Text(AppLocalizations.of(context)!.saveToFilesDescription),
              onTap: () async {
                Navigator.pop(context);
                await _saveFileWithDialog(attachment, file);
              },
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Future<void> _saveToGallery(BookingAttachment attachment, File file) async {
    try {
      if (attachment.isImage) {
        await Gal.putImage(attachment.filePath);
        if (!mounted) return;
        showAppSnackBar(
          context,
          AppLocalizations.of(context)!.imageSavedToPhotos,
          type: SnackBarType.success,
        );
      }
    } catch (e) {
      if (!mounted) return;
      showAppSnackBar(
        context,
        AppLocalizations.of(context)!.errorSavingToPhotos(e.toString()),
        type: SnackBarType.error,
      );
    }
  }

  Future<void> _saveFileWithDialog(BookingAttachment attachment, File file) async {
    try {
      // Use FilePicker to let user choose save location
      String? outputFile = await FilePicker.platform.saveFile(
        dialogTitle: AppLocalizations.of(context)!.saveToFiles,
        fileName: attachment.fileName,
        type: FileType.any,
      );

      if (outputFile == null) {
        // User cancelled the dialog
        return;
      }

      // Copy the file to chosen location
      await file.copy(outputFile);

      if (!mounted) return;
      showAppSnackBar(
        context,
        AppLocalizations.of(context)!.fileSavedSuccessfully,
        type: SnackBarType.success,
        actionLabel: AppLocalizations.of(context)!.open,
        onAction: () {
          Share.shareXFiles([XFile(outputFile)]);
        },
      );
    } catch (e) {
      if (!mounted) return;
      showAppSnackBar(
        context,
        AppLocalizations.of(context)!.errorSavingFile(e.toString()),
        type: SnackBarType.error,
      );
    }
  }


  Future<void> _shareAttachment(BookingAttachment attachment) async {
    try {
      final file = File(attachment.filePath);
      if (await file.exists()) {
        await Share.shareXFiles(
          [XFile(attachment.filePath)],
          subject: attachment.fileName,
        );
      } else {
        if (!mounted) return;
        showAppSnackBar(context, AppLocalizations.of(context)!.fileNotFound, type: SnackBarType.error);
      }
    } catch (e) {
      if (!mounted) return;
      showAppSnackBar(
        context,
        AppLocalizations.of(context)!.errorSharingFile(e.toString()),
        type: SnackBarType.error,
      );
    }
  }

  void _showAddBookingDialog(BookingProvider bookingProvider) {
    // Check if booking limit is reached (15 per trip)
    if (bookingProvider.bookings.length >= 15) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.bookingLimitReached),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
    
    BookingFormModal.show(context, widget.trip.id, widget.trip.defaultCurrency);
  }

  void _showEditBookingDialog(Booking booking, BookingProvider bookingProvider) {
    BookingFormModal.show(
      context, 
      widget.trip.id, 
      widget.trip.defaultCurrency,
      booking: booking,
    );
  }

  Widget _buildSearchAndFilters(List<Booking> bookings) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildSearchBar(),
          const SizedBox(height: 16),
          _buildFilterChips(bookings),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.surfaceDark
            : AppTheme.surfaceLight,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withValues(alpha: 0.1),
            offset: const Offset(0, 4),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
        decoration: InputDecoration(
          hintText: 'Search bookings...',
          prefixIcon: const Icon(Iconsax.search_normal_1),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Iconsax.close_circle),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _searchQuery = '';
                    });
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }

  Widget _buildFilterChips(List<Booking> bookings) {
    final flightCount = bookings.where((booking) => booking.type == BookingType.flight).length;
    final hotelCount = bookings.where((booking) => booking.type == BookingType.hotel).length;
    final activityCount = bookings.where((booking) => booking.type == BookingType.activity).length;
    final transportCount = bookings.where((booking) => booking.type == BookingType.transport).length;
    final restaurantCount = bookings.where((booking) => booking.type == BookingType.restaurant).length;
    final otherCount = bookings.where((booking) => booking.type == BookingType.other).length;

    return SizedBox(
      height: 40,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            FilterChip(
              label: Text(AppLocalizations.of(context)!.allWithCount(bookings.length)),
              selected: _selectedType == null,
              onSelected: (selected) {
                setState(() {
                  _selectedType = null;
                });
              },
              selectedColor: AppTheme.primaryColor.withValues(alpha: 0.2),
              checkmarkColor: AppTheme.primaryColor,
              labelStyle: TextStyle(
                color: _selectedType == null ? AppTheme.primaryColor : null,
                fontWeight: _selectedType == null ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
            const SizedBox(width: 8),
            FilterChip(
              label: Text('Flight ($flightCount)'),
              selected: _selectedType == BookingType.flight,
              onSelected: (selected) {
                setState(() {
                  _selectedType = selected ? BookingType.flight : null;
                });
              },
              selectedColor: _getTypeColor(BookingType.flight).withValues(alpha: 0.2),
              checkmarkColor: _getTypeColor(BookingType.flight),
              labelStyle: TextStyle(
                color: _selectedType == BookingType.flight ? _getTypeColor(BookingType.flight) : null,
                fontWeight: _selectedType == BookingType.flight ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
            const SizedBox(width: 8),
            FilterChip(
              label: Text('${AppLocalizations.of(context)!.hotel} ($hotelCount)'),
              selected: _selectedType == BookingType.hotel,
              onSelected: (selected) {
                setState(() {
                  _selectedType = selected ? BookingType.hotel : null;
                });
              },
              selectedColor: _getTypeColor(BookingType.hotel).withValues(alpha: 0.2),
              checkmarkColor: _getTypeColor(BookingType.hotel),
              labelStyle: TextStyle(
                color: _selectedType == BookingType.hotel ? _getTypeColor(BookingType.hotel) : null,
                fontWeight: _selectedType == BookingType.hotel ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
            const SizedBox(width: 8),
            FilterChip(
              label: Text('${AppLocalizations.of(context)!.activities} ($activityCount)'),
              selected: _selectedType == BookingType.activity,
              onSelected: (selected) {
                setState(() {
                  _selectedType = selected ? BookingType.activity : null;
                });
              },
              selectedColor: _getTypeColor(BookingType.activity).withValues(alpha: 0.2),
              checkmarkColor: _getTypeColor(BookingType.activity),
              labelStyle: TextStyle(
                color: _selectedType == BookingType.activity ? _getTypeColor(BookingType.activity) : null,
                fontWeight: _selectedType == BookingType.activity ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
            const SizedBox(width: 8),
            FilterChip(
              label: Text('${AppLocalizations.of(context)!.transport} ($transportCount)'),
              selected: _selectedType == BookingType.transport,
              onSelected: (selected) {
                setState(() {
                  _selectedType = selected ? BookingType.transport : null;
                });
              },
              selectedColor: _getTypeColor(BookingType.transport).withValues(alpha: 0.2),
              checkmarkColor: _getTypeColor(BookingType.transport),
              labelStyle: TextStyle(
                color: _selectedType == BookingType.transport ? _getTypeColor(BookingType.transport) : null,
                fontWeight: _selectedType == BookingType.transport ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
            const SizedBox(width: 8),
            FilterChip(
              label: Text('Restaurant ($restaurantCount)'),
              selected: _selectedType == BookingType.restaurant,
              onSelected: (selected) {
                setState(() {
                  _selectedType = selected ? BookingType.restaurant : null;
                });
              },
              selectedColor: _getTypeColor(BookingType.restaurant).withValues(alpha: 0.2),
              checkmarkColor: _getTypeColor(BookingType.restaurant),
              labelStyle: TextStyle(
                color: _selectedType == BookingType.restaurant ? _getTypeColor(BookingType.restaurant) : null,
                fontWeight: _selectedType == BookingType.restaurant ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
            const SizedBox(width: 8),
            FilterChip(
              label: Text('${AppLocalizations.of(context)!.other} ($otherCount)'),
              selected: _selectedType == BookingType.other,
              onSelected: (selected) {
                setState(() {
                  _selectedType = selected ? BookingType.other : null;
                });
              },
              selectedColor: _getTypeColor(BookingType.other).withValues(alpha: 0.2),
              checkmarkColor: _getTypeColor(BookingType.other),
              labelStyle: TextStyle(
                color: _selectedType == BookingType.other ? _getTypeColor(BookingType.other) : null,
                fontWeight: _selectedType == BookingType.other ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoResultsState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.search_normal_1,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'No bookings found',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your search terms or filters',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                _searchController.clear();
                setState(() {
                  _searchQuery = '';
                  _selectedType = null;
                });
              },
              icon: const Icon(Iconsax.refresh),
              label: Text('Clear Filters'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _showDeleteConfirmation(Booking booking, BookingProvider bookingProvider) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Iconsax.warning_2,
                  color: AppTheme.error,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(AppLocalizations.of(context)!.deleteBooking),
            ],
          ),
          content: Text(
            AppLocalizations.of(context)!.deleteDocumentConfirmation(booking.title),
            style: const TextStyle(height: 1.4),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                AppLocalizations.of(context)!.cancel,
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppTheme.textSecondaryDark
                      : AppTheme.textSecondary,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop(true);
                await bookingProvider.deleteBooking(booking.id);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.error,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(AppLocalizations.of(context)!.delete),
            ),
          ],
        );
      },
    ) ?? false;
  }

}

extension BookingTypeExtension on BookingType {
  String getDisplayName(AppLocalizations l10n) {
    switch (this) {
      case BookingType.flight:
        return l10n.flight;
      case BookingType.hotel:
        return l10n.hotel;
      case BookingType.activity:
        return l10n.activities; // Using existing activities key
      case BookingType.transport:
        return l10n.transport;
      case BookingType.restaurant:
        return l10n.restaurant;
      case BookingType.other:
        return l10n.other;
    }
  }
}

extension BookingStatusExtension on BookingStatus {
  String getDisplayName(AppLocalizations l10n) {
    switch (this) {
      case BookingStatus.confirmed:
        return l10n.confirmed;
      case BookingStatus.pending:
        return l10n.pending;
      case BookingStatus.cancelled:
        return l10n.cancelled;
    }
  }
}
